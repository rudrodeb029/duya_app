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

    return DuyaSubpageScaffold(
      title: 'Duya Wallet',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          DuyaDaylightBannerCard(
            imageAsset: 'assets/images/hero_mosque_header.jpg',
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F3EE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Current Balance',
                    style: TextStyle(
                      color: DuyaColors.emerald,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  formatted,
                  style: const TextStyle(
                    color: Color(0xFF10553F),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  repo.displayCurrency,
                  style: const TextStyle(
                    color: DuyaColors.desertGold,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: () => repo.topUpWallet(500),
                  icon: const Icon(Icons.add),
                  label: const Text('Top Up +500 SAR'),
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
