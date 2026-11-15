import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import 'challenge_shell_view.dart';

/// Challenge Support Center with expandable FAQ accordion & 24/7 Customer Care.
class ChallengeHelpView extends StatelessWidget {
  const ChallengeHelpView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ChallengeRepository>();

    return ChallengeScaffold(
      currentIndex: 4,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Support center',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          ...repo.faqs.map(
            (faq) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                padding: EdgeInsets.zero,
                child: ExpansionTile(
                  shape: const Border(),
                  title: Text(
                    faq.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(faq.answer),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text('Customer care', style: TextStyle(fontSize: 11.5)),
          Text(
            'We’re here for you',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const DuyaCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.phone_outlined, color: DuyaColors.emerald),
              title: Text('Inside Saudi Arabia 24/7'),
              subtitle: Text(
                '1966',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const DuyaCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.public, color: DuyaColors.emerald),
              title: Text('Outside Saudi Arabia 24/7'),
              subtitle: Text(
                '+966 9200 02814',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const DuyaCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.email_outlined, color: DuyaColors.emerald),
              title: Text('Email Support'),
              subtitle: Text(
                'care@duya.app',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
