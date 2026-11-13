import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/market_wallet_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Multi-currency Duya Travel Wallet with balance conversion, top-up & ledger.
class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<MarketWalletRepository>();
    final formatted = NumberFormat('#,##0.00').format(repo.convertedBalance);

    return Scaffold(
      appBar: AppBar(title: const Text('Duya Wallet')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: DuyaColors.celestialHeroGradient,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                const Text(
                  'Current Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  formatted,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  repo.displayCurrency,
                  style: const TextStyle(
                    color: DuyaColors.desertGoldSoft,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  children: MarketWalletRepository.currencyRates.keys.map((cur) {
                    final selected = cur == repo.displayCurrency;
                    return ChoiceChip(
                      label: Text(cur),
                      selected: selected,
                      onSelected: (_) => repo.setDisplayCurrency(cur),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => repo.topUpWallet(500),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DuyaColors.desertGold,
                        foregroundColor: DuyaColors.celestialNight,
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Top Up +500 SAR'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Recent Transactions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ...repo.transactions.map(
            (tx) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: tx.isCredit
                          ? DuyaColors.successSoft
                          : DuyaColors.sandstone,
                      child: Icon(
                        tx.isCredit ? Icons.arrow_downward : Icons.payment,
                        color: tx.isCredit
                            ? DuyaColors.success
                            : DuyaColors.emerald,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${tx.category} • ${tx.dateLabel}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${tx.isCredit ? '+' : '-'} ${tx.amountSar.toStringAsFixed(0)} SAR',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: tx.isCredit
                            ? DuyaColors.success
                            : DuyaColors.textPrimaryLight,
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
