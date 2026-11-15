import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/prayer_ritual_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Haram Mobility (Golf Cart / Wheelchair) & Zamzam Pickup Stations screen.
class HaramServicesView extends StatefulWidget {
  const HaramServicesView({super.key});

  @override
  State<HaramServicesView> createState() => _HaramServicesViewState();
}

class _HaramServicesViewState extends State<HaramServicesView> {
  String _selectedType = 'Golf Cart (Tawaf & Sa‘i)';
  String _selectedGate = 'Ajyad Escalator Entrance';
  String _selectedWindow = 'After Asr Prayer';

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<PrayerRitualRepository>();

    return DuyaSubpageScaffold(
      title: 'Haram Mobility & Zamzam',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          DuyaCard(
            color: DuyaColors.desertGoldSoft,
            child: Row(
              children: [
                const Icon(
                  Icons.electric_rickshaw_outlined,
                  size: 38,
                  color: DuyaColors.emerald,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Electric Golf Cart & Wheelchair',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                          color: DuyaColors.textPrimaryLight,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Reserve upper-mezzanine electric cart assistance for Tawaf and Sa‘i.',
                        style: TextStyle(
                          fontSize: 11,
                          color: DuyaColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<String>(
            initialValue: _selectedType,
            decoration: const InputDecoration(labelText: 'Service Type'),
            items: const [
              DropdownMenuItem(
                value: 'Golf Cart (Tawaf & Sa‘i)',
                child: Text('Golf Cart (Tawaf & Sa‘i)'),
              ),
              DropdownMenuItem(
                value: 'Assisted Wheelchair',
                child: Text('Assisted Wheelchair'),
              ),
              DropdownMenuItem(
                value: 'Self-Push Wheelchair',
                child: Text('Self-Push Wheelchair'),
              ),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _selectedType = v);
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedGate,
            decoration: const InputDecoration(labelText: 'Pickup Station'),
            items: const [
              DropdownMenuItem(
                value: 'Ajyad Escalator Entrance',
                child: Text('Ajyad Escalator Entrance'),
              ),
              DropdownMenuItem(
                value: 'Shubaykah Bridge Mezzanine',
                child: Text('Shubaykah Bridge Mezzanine'),
              ),
              DropdownMenuItem(
                value: 'Marwah Gate 22',
                child: Text('Marwah Gate 22'),
              ),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _selectedGate = v);
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedWindow,
            decoration: const InputDecoration(labelText: 'Preferred Time'),
            items: const [
              DropdownMenuItem(
                value: 'After Fajr Prayer',
                child: Text('After Fajr Prayer'),
              ),
              DropdownMenuItem(
                value: 'After Asr Prayer',
                child: Text('After Asr Prayer'),
              ),
              DropdownMenuItem(
                value: 'After Isha Prayer',
                child: Text('After Isha Prayer'),
              ),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _selectedWindow = v);
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              repo.requestHaramService(
                serviceType: _selectedType,
                gateLocation: _selectedGate,
                timeWindow: _selectedWindow,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Haram mobility assistance scheduled!'),
                ),
              );
            },
            child: const Text('Schedule Mobility Cart'),
          ),
          if (repo.haramRequests.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'Scheduled Requests',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(height: 8),
            ...repo.haramRequests.map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DuyaCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.check_circle,
                      color: DuyaColors.success,
                    ),
                    title: Text(r.serviceType),
                    subtitle: Text('${r.gateLocation} • ${r.timeWindow}'),
                    trailing: Text(r.status),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          DuyaCard(
            onTap: () => context.push('/market/category/zamzam'),
            child: const Row(
              children: [
                Icon(Icons.water_drop_outlined, color: DuyaColors.emerald, size: 32),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Official Zamzam Water Cartons',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text('Order 5L travel cartons to your hotel or airport.'),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
