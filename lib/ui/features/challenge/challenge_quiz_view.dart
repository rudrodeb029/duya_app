import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/challenge_repository.dart';
import '../../../domain/models/challenge_models.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// Quiz Question screen for a chosen Challenge Door with 100 daily questions
/// (rotating across 10 days = 1,000 per door), sequential question-by-question
/// progression, and a 10-question minimum joining requirement.
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
  QuizQuestion? _submittedQuestion;
  int? _submittedQuestionNumber;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final repo = context.read<ChallengeRepository>();
      if (repo.questionsForDoor(widget.doorId).length <
          ChallengeRepository.dailyQuestionsPerDoor) {
        repo.loadExpandedQuestions();
      }
    });
  }

  void _advanceToNextQuestion() {
    setState(() {
      _selectedOption = null;
      _submitted = false;
      _isCorrect = false;
      _submittedQuestion = null;
      _submittedQuestionNumber = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ChallengeRepository>();
    final door = repo.getDoorById(widget.doorId);
    final dailyQuestions = repo.dailyQuestionsForDoor(door.id);
    final dailyTotal = dailyQuestions.length;
    final answeredToday = repo.answeredCountToday(door.id);
    final minJoin = ChallengeRepository.minQuestionsToJoin;
    final isJoined = repo.isDoorJoined(door.id);
    final isExhausted = repo.isDoorExhaustedToday(door.id);
    final cycleDay = repo.dailyCycleDayNumberForDoor(door.id);

    final activeQuestion = _submitted && _submittedQuestion != null
        ? _submittedQuestion!
        : repo.getQuestionForDoor(door.id);
    final displayNum = _submitted && _submittedQuestionNumber != null
        ? _submittedQuestionNumber!
        : (answeredToday + 1).clamp(1, dailyTotal);

    final joinProgress = isJoined
        ? (answeredToday / (dailyTotal > 0 ? dailyTotal : 1)).clamp(0.0, 1.0)
        : (answeredToday / minJoin).clamp(0.0, 1.0);

    return DuyaSubpageScaffold(
      title: door.titleEn,
      actions: [
        DuyaIlmChip(
          count: repo.ilmBalance,
          onTap: () => context.go('/challenge/ilm'),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    door.imageAsset,
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Question $displayNum of $dailyTotal • Day $cycleDay of ${ChallengeRepository.dailyCycleDays}',
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isJoined
                        ? DuyaColors.successSoft.withValues(alpha: 0.65)
                        : DuyaColors.desertGoldSoft.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          isJoined
                              ? '✓ $answeredToday / $dailyTotal joined'
                              : '$answeredToday / $minJoin joined',
                          style: const TextStyle(
                            fontSize: 8.8,
                            fontWeight: FontWeight.w600,
                            color: DuyaColors.emerald,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: joinProgress,
                          minHeight: 3.5,
                          backgroundColor: Colors.black.withValues(alpha: 0.08),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isJoined
                                ? DuyaColors.emerald
                                : DuyaColors.desertGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  activeQuestion.questionEn,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 12),
                ...List.generate(activeQuestion.optionsEn.length, (i) {
                  final isSelected = _selectedOption == i;
                  Color? tileColor;
                  if (_submitted) {
                    if (i == activeQuestion.correctIndex) {
                      tileColor = DuyaColors.successSoft;
                    } else if (isSelected && !_isCorrect) {
                      tileColor = DuyaColors.errorSoft;
                    }
                  } else if (isSelected) {
                    tileColor = DuyaColors.desertGoldSoft;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DuyaCard(
                      borderRadius: 8,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 11,
                      ),
                      color: tileColor ?? Colors.transparent,
                      onTap: _submitted
                          ? null
                          : () => setState(() => _selectedOption = i),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              activeQuestion.optionsEn[i],
                              style: TextStyle(
                                fontSize: 10.8,
                                height: 1.3,
                                fontWeight: isSelected
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                                color: tileColor != null
                                    ? DuyaColors.textPrimaryLight
                                    : null,
                              ),
                            ),
                          ),
                          if (isSelected ||
                              (_submitted && i == activeQuestion.correctIndex))
                            Icon(
                              _submitted &&
                                      isSelected &&
                                      i != activeQuestion.correctIndex
                                  ? Icons.cancel
                                  : Icons.check_circle,
                              size: 17,
                              color: _submitted &&
                                      isSelected &&
                                      i != activeQuestion.correctIndex
                                  ? DuyaColors.error
                                  : DuyaColors.emerald,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (_submitted)
            DuyaCard(
              borderRadius: 8,
              padding: const EdgeInsets.all(12),
              color:
                  _isCorrect ? DuyaColors.successSoft : DuyaColors.warningSoft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isCorrect
                        ? 'MashaAllah! +${ChallengeRepository.ilmCorrectReward} Ilm & +1 Draw Entry'
                        : 'Good Try — +${ChallengeRepository.ilmLearningReward} Ilm for Learning',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: DuyaColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activeQuestion.explanationEn,
                    style: const TextStyle(
                      fontSize: 11.5,
                      height: 1.35,
                      color: DuyaColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Source: ${activeQuestion.reference}',
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: DuyaColors.emerald,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              answeredToday == 0
                  ? 'Spending 1 Ilm unlocks today’s $dailyTotal questions — answer at least $minJoin questions to join!'
                  : isJoined
                      ? 'You have met the $minJoin-question minimum! Keep answering up to $dailyTotal questions today.'
                      : 'Answer ${repo.remainingToJoin(door.id)} more question${repo.remainingToJoin(door.id) == 1 ? '' : 's'} to reach the minimum $minJoin questions to join.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9.8),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedOption == null
                  ? null
                  : _submitted
                      ? (isExhausted
                          ? () => context.go('/challenge/play')
                          : _advanceToNextQuestion)
                      : () {
                          final qToSubmit = activeQuestion;
                          final qNum = displayNum;
                          final ok = repo.submitAnswer(
                            question: qToSubmit,
                            selectedIndex: _selectedOption!,
                          );
                          setState(() {
                            _submitted = true;
                            _isCorrect = ok;
                            _submittedQuestion = qToSubmit;
                            _submittedQuestionNumber = qNum;
                          });
                        },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
              child: Text(
                !_submitted
                    ? 'Check your answer'
                    : isExhausted
                        ? 'All $dailyTotal Completed — Back to Doors'
                        : 'Next Question (${answeredToday + 1} of $dailyTotal)',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (_submitted && !isExhausted && isJoined) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () => context.go('/challenge/play'),
                icon: const Icon(Icons.door_front_door_outlined, size: 16),
                label: Text(
                  'Back to Doors ($answeredToday/$dailyTotal answered)',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
