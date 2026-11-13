import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';

/// Quiz Question screen for a chosen Challenge Door with 4 choices,
/// "Check your answer" submission, explanation, and draw entry feedback.
class ChallengeQuizView extends StatefulWidget {
  const ChallengeQuizView({super.key, required this.doorId});

  final String doorId;

  @override
  State<ChallengeQuizView> createState() => _ChallengeQuizViewState();
}

class _ChallengeQuizViewState extends State<ChallengeQuizView> {
  int? _selectedOption;
  bool _submitted = false;
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ChallengeRepository>();
    final door = repo.getDoorById(widget.doorId);
    final question = repo.getQuestionForDoor(widget.doorId);
    final doorIndex = repo.doors.indexWhere((d) => d.id == door.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(door.titleEn),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              avatar: const Icon(Icons.vpn_key_outlined, size: 16),
              label: Text('${repo.keysCount}'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DuyaCard(
            child: Column(
              children: [
                CustomPaint(
                  size: const Size(86, 108),
                  painter: ChallengeDoorPainter(
                    doorColor: Color(door.colorHex),
                    variantIndex: doorIndex < 0 ? 0 : doorIndex,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  question.questionEn,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 18),
                ...List.generate(question.optionsEn.length, (i) {
                  final isSelected = _selectedOption == i;
                  Color? tileColor;
                  if (_submitted) {
                    if (i == question.correctIndex) {
                      tileColor = DuyaColors.successSoft;
                    } else if (isSelected && !_isCorrect) {
                      tileColor = DuyaColors.errorSoft;
                    }
                  } else if (isSelected) {
                    tileColor = DuyaColors.desertGoldSoft;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DuyaCard(
                      color: tileColor,
                      onTap: _submitted
                          ? null
                          : () => setState(() => _selectedOption = i),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              question.optionsEn[i],
                              style: TextStyle(
                                fontWeight:
                                    isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: tileColor != null
                                    ? DuyaColors.textPrimaryLight
                                    : null,
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: DuyaColors.emerald,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (_submitted)
            DuyaCard(
              color: _isCorrect ? DuyaColors.successSoft : DuyaColors.warningSoft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isCorrect
                        ? 'MashaAllah! Entry Secured in Today’s Draw'
                        : 'Good Try — Learn & Try Another Door',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: DuyaColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    question.explanationEn,
                    style: const TextStyle(color: DuyaColors.textPrimaryLight),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Source: ${question.reference}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: DuyaColors.emerald,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            const Text(
              'Your key unlocks the door for a chance to win an Umrah trip for two. Choose the right answer to secure your entry.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedOption == null
                  ? null
                  : _submitted
                      ? () => context.go('/challenge/play')
                      : () {
                          final ok = repo.submitAnswer(
                            question: question,
                            selectedIndex: _selectedOption!,
                          );
                          setState(() {
                            _submitted = true;
                            _isCorrect = ok;
                          });
                        },
              child: Text(_submitted ? 'Back to Doors' : 'Check your answer'),
            ),
          ),
        ],
      ),
    );
  }
}
