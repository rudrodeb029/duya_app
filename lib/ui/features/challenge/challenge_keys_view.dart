import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import 'challenge_shell_view.dart';

/// Challenge Keys screen showing current keys, daily draw entries & code redemption.
class ChallengeKeysView extends StatefulWidget {
  const ChallengeKeysView({super.key});

  @override
  State<ChallengeKeysView> createState() => _ChallengeKeysViewState();
}

class _ChallengeKeysViewState extends State<ChallengeKeysView> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ChallengeRepository>();

    return ChallengeScaffold(
      currentIndex: 2,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Challenge keys'),
          Text(
            'Your keys',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          DuyaCard(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: DuyaColors.desertGoldSoft,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.vpn_key_outlined,
                        color: DuyaColors.emerald,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${repo.keysCount}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: DuyaColors.emerald,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Draw entries earned today: ${repo.drawEntriesCount}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text('One daily key refreshes every 24 hours.'),
                const Divider(height: 28),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.vpn_key_outlined, color: DuyaColors.emerald),
                  title: Text('A key for every day'),
                  subtitle: Text('You get one complimentary key each morning.'),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.share_outlined, color: DuyaColors.emerald),
                  title: Text('Share & collect keys'),
                  subtitle: Text(
                    'Share with family and friends; enter DUYA2026 or BARAKAH below to test redemption.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _codeController,
            decoration: const InputDecoration(
              hintText: 'Add code to get new key (e.g. DUYA2026)',
              prefixIcon: Icon(Icons.confirmation_number_outlined),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final res = repo.redeemCode(_codeController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(res.message)),
              );
              if (res.success) _codeController.clear();
            },
            child: const Text('Check the code'),
          ),
        ],
      ),
    );
  }
}
