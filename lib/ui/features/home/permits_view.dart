import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Rawdah & Umrah Permits screen allowing slot selection and QR pass generation.
class PermitsView extends StatefulWidget {
  const PermitsView({super.key, this.initialFilter = 'all'});

  final String initialFilter;

  @override
  State<PermitsView> createState() => _PermitsViewState();
}

class _PermitsViewState extends State<PermitsView> {
  late String _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final repo = context.watch<PrayerRitualRepository>();
    final slots = repo.permitSlots.where((s) {
      if (_filter == 'rawdah') return s.type.startsWith('rawdah');
      if (_filter == 'umrah') return s.type == 'umrah';
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Al-Rawdah & Umrah Permits')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All Permits'),
                selected: _filter == 'all',
                onSelected: (_) => setState(() => _filter = 'all'),
              ),
              ChoiceChip(
                label: const Text('Al-Rawdah'),
                selected: _filter == 'rawdah',
                onSelected: (_) => setState(() => _filter = 'rawdah'),
              ),
              ChoiceChip(
                label: const Text('Umrah'),
                selected: _filter == 'umrah',
                onSelected: (_) => setState(() => _filter = 'umrah'),
              ),
            ],
          ),
          if (repo.permitBookings.isNotEmpty) ...[
            const SizedBox(height: 18),
            const Text(
              'Your Active Permits',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...repo.permitBookings.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DuyaCard(
                  color: DuyaColors.successSoft,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.qr_code_2,
                        size: 46,
                        color: DuyaColors.emerald,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              b.slot.titleEn,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: DuyaColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              '${b.slot.dateLabel} • ${b.slot.timeWindow}',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: DuyaColors.textSecondaryLight,
                              ),
                            ),
                            Text(
                              'Code: ${b.permitCode} • ${b.status}',
                              style: const TextStyle(
                                color: DuyaColors.emerald,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          const Text(
            'Available Prayer & Entry Windows',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ...slots.map(
            (slot) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DuyaCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            slot.titleEn,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.5,
                            ),
                          ),
                        ),
                        Chip(
                          label: Text(
                            slot.availabilityLabel,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(slot.locationLabel),
                    const SizedBox(height: 4),
                    Text(
                      '${slot.dateLabel} • ${slot.timeWindow}',
                      style: const TextStyle(
                        color: DuyaColors.emerald,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (auth.profile.isGuest) {
                            showLoginPromptSheet(context);
                            return;
                          }
                          final booking =
                              repo.bookPermit(slot, auth.profile.fullName);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Permit confirmed (${booking.permitCode})!',
                              ),
                            ),
                          );
                        },
                        child: const Text('Reserve Slot'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
