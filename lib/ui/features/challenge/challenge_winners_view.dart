import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../../data/repositories/challenge_repository.dart';
import '../../../domain/models/challenge_models.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';
import '../../core/widgets/islamic_patterns.dart';
import 'challenge_shell_view.dart';

/// Winners Leaderboard screen featuring the interactive Islamic Ilm Raffle Wheel
/// Spotlight and Today / Previous winners list.
class ChallengeWinnersView extends StatefulWidget {
  const ChallengeWinnersView({super.key});

  @override
  State<ChallengeWinnersView> createState() => _ChallengeWinnersViewState();
}

class _ChallengeWinnersViewState extends State<ChallengeWinnersView>
    with TickerProviderStateMixin {
  bool _showToday = true;

  late final AnimationController _spinController;
  late Animation<double> _rotationAnimation;
  late final AnimationController _marqueeController;
  final ScrollController _marqueeScrollController = ScrollController();

  double _currentRotation = -(math.pi / 2);
  int _winnerIndex = 0;
  bool _showWinnerCard = false;
  int _spinSeed = 0;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    );
    _rotationAnimation = AlwaysStoppedAnimation<double>(_currentRotation);

    _marqueeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(_onMarqueeTick)
      ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (context.read<ChallengeRepository>().canSpinRaffle) {
        _spinWheel(initialSpin: true);
      }
    });
  }

  void _onMarqueeTick() {
    if (!_marqueeScrollController.hasClients) return;
    _marqueeScrollController.jumpTo(_marqueeScrollController.offset + 0.75);
  }

  @override
  void dispose() {
    _marqueeController.dispose();
    _marqueeScrollController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  List<RaffleParticipant> _getParticipants(BuildContext context) {
    final repo = context.read<ChallengeRepository>();
    final auth = context.read<AuthProfileRepository>();
    return repo.eligibleRaffleParticipants(
      currentUserName: auth.profile.fullName,
      currentUserCountry: auth.profile.nationality,
    );
  }

  void _handleSpinRequest() {
    final repo = context.read<ChallengeRepository>();
    if (!repo.canSpinRaffle) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Minimum ${ChallengeRepository.minIlmForRaffleSpin} Ilm required to spin the raffle (you have ${ChallengeRepository.formatIlm(repo.ilmBalance)} Ilm — need ${ChallengeRepository.formatIlm(repo.ilmNeededForRaffle)} more Ilm).',
            ),
          ),
        );
      return;
    }
    _spinWheel();
  }

  void _spinWheel({bool initialSpin = false}) {
    final participants = _getParticipants(context);
    if (participants.isEmpty) return;

    final count = participants.length;
    final sweep = (2 * math.pi) / count;

    // Select a deterministic-yet-varied winner index across spins so every
    // spin lands cleanly on an eligible Ilm participant.
    final int nextWinnerIdx;
    if (initialSpin) {
      nextWinnerIdx = 0;
    } else {
      _spinSeed++;
      nextWinnerIdx = (_winnerIndex + 3 + (_spinSeed * 5)) % count;
    }

    // Target rotation aligns slice [nextWinnerIdx] directly beneath the top
    // pointer at -pi/2 after 6 full clockwise revolutions.
    final baseTarget = -(math.pi / 2) - (nextWinnerIdx * sweep);
    final currentTurns = (_currentRotation / (2 * math.pi)).floor();
    final targetRotation = ((currentTurns + 6) * 2 * math.pi) + baseTarget;

    setState(() {
      _winnerIndex = nextWinnerIdx;
      _showWinnerCard = false;
      _rotationAnimation = Tween<double>(
        begin: _currentRotation,
        end: targetRotation,
      ).animate(
        CurvedAnimation(
          parent: _spinController,
          curve: const Cubic(0.12, 0.78, 0.16, 1.0),
        ),
      );
    });

    _spinController.forward(from: 0.0).whenCompleteOrCancel(() {
      if (!mounted) return;
      final latestParticipants = _getParticipants(context);
      final safeIdx = _winnerIndex.clamp(0, latestParticipants.length - 1);
      final chosen = latestParticipants[safeIdx];
      context.read<ChallengeRepository>().recordRaffleWinner(chosen);
      setState(() {
        _currentRotation = targetRotation % (2 * math.pi);
        _showWinnerCard = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ChallengeRepository>();
    final auth = context.watch<AuthProfileRepository>();
    final participants = repo.eligibleRaffleParticipants(
      currentUserName: auth.profile.fullName,
      currentUserCountry: auth.profile.nationality,
    );
    final safeWinnerIdx = _winnerIndex.clamp(0, participants.length - 1);
    final activeWinner = repo.selectedRaffleWinner ?? participants[safeWinnerIdx];
    final list = repo.winners.where((w) => w.isToday == _showToday).toList();

    return ChallengeScaffold(
      currentIndex: 1,
      title: 'Raffle',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Islamic Raffle Wheel Spotlight Card
          _IslamicRaffleWheelSpotlight(
            participants: participants,
            rotationAnimation: _rotationAnimation,
            isSpinning: _spinController.isAnimating,
            canSpin: repo.canSpinRaffle,
            winner: activeWinner,
            showWinnerCard: _showWinnerCard,
            onSpinAgain: _handleSpinRequest,
            onCenterHubSpin: _handleSpinRequest,
            onToggleWinnerCard: () =>
                setState(() => _showWinnerCard = !_showWinnerCard),
          ),
          const SizedBox(height: 10),
          // Eligible Ilm Seekers continuous left-to-right sliding marquee
          SizedBox(
            height: 28,
            child: ListView.builder(
              controller: _marqueeScrollController,
              scrollDirection: Axis.horizontal,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (participants.isEmpty) return const SizedBox.shrink();
                final p = participants[index % participants.length];
                final isWinner = !_spinController.isAnimating &&
                    p.id == activeWinner.id;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IlmIcon(
                          size: 10,
                          color: isWinner
                              ? const Color(0xFFC79A3C)
                              : DuyaColors.emerald,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${p.displayName} (${ChallengeRepository.formatIlm(p.ilmScore)} Ilm)',
                          style: TextStyle(
                            fontSize: 9.2,
                            fontWeight:
                                isWinner ? FontWeight.w700 : FontWeight.w500,
                            color: isWinner
                                ? DuyaColors.emerald
                                : DuyaColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'List of winners',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label: Text('Today', style: TextStyle(fontSize: 11)),
              ),
              ButtonSegment(
                value: false,
                label: Text('Previous winners', style: TextStyle(fontSize: 11)),
              ),
            ],
            selected: {_showToday},
            onSelectionChanged: (set) => setState(() => _showToday = set.first),
          ),
          const SizedBox(height: 12),
          ...list.map(
            (w) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DuyaCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: w.isSpotlight
                          ? DuyaColors.emerald
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: Text(
                        w.displayName.characters.first,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: w.isSpotlight
                              ? Colors.white
                              : DuyaColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  w.displayName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                              if (w.isSpotlight) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: DuyaColors.desertGoldSoft,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Raffle Winner',
                                    style: TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w700,
                                      color: DuyaColors.emerald,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${w.prizeTitle} • ${w.dateLabel}',
                            style: const TextStyle(fontSize: 10.5),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 13),
                              const SizedBox(width: 3),
                              Text(
                                w.country,
                                style: const TextStyle(fontSize: 10.0),
                              ),
                            ],
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
      ),
    );
  }
}

class _IslamicRaffleWheelSpotlight extends StatelessWidget {
  const _IslamicRaffleWheelSpotlight({
    required this.participants,
    required this.rotationAnimation,
    required this.isSpinning,
    required this.canSpin,
    required this.winner,
    required this.showWinnerCard,
    required this.onSpinAgain,
    required this.onCenterHubSpin,
    required this.onToggleWinnerCard,
  });

  final List<RaffleParticipant> participants;
  final Animation<double> rotationAnimation;
  final bool isSpinning;
  final bool canSpin;
  final RaffleParticipant winner;
  final bool showWinnerCard;
  final VoidCallback onSpinAgain;
  final VoidCallback onCenterHubSpin;
  final VoidCallback onToggleWinnerCard;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 236,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated spinning wheel canvas on transparent background
            Positioned.fill(
              child: GestureDetector(
                onTap: isSpinning ? null : onToggleWinnerCard,
                child: AnimatedBuilder(
                  animation: rotationAnimation,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _IslamicRaffleWheelPainter(
                        participants: participants,
                        rotation: rotationAnimation.value,
                        canSpin: canSpin,
                        highlightedId:
                            !isSpinning ? winner.id : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Interactive tap-to-spin target over the bottom-center Islamic hub
            Positioned(
              bottom: 0,
              width: 116,
              height: 56,
              child: MouseRegion(
                cursor: isSpinning
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: isSpinning ? null : onCenterHubSpin,
                  child: const Tooltip(
                    message: 'Tap to Spin Raffle',
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ),
            if (!isSpinning && !showWinnerCard)
              Positioned(
                top: 6,
                right: 8,
                child: InkWell(
                  onTap: onToggleWinnerCard,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    color: Colors.transparent,
                    child: const Text(
                      'Show Winner Card',
                      style: TextStyle(
                        color: DuyaColors.emerald,
                        fontSize: 9.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            // Centered "Congratulations!" Winner Announcement Card
            AnimatedScale(
              scale: (!isSpinning && showWinnerCard) ? 1.0 : 0.86,
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutBack,
              child: AnimatedOpacity(
                opacity: (!isSpinning && showWinnerCard) ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 220),
                child: IgnorePointer(
                  ignoring: isSpinning || !showWinnerCard,
                  child: Container(
                    width: 286,
                    margin: const EdgeInsets.only(top: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFD5C28F),
                        width: 1.1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x240E523C),
                          blurRadius: 14,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Emerald header strip ("Congratulations!")
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF115840),
                                Color(0xFF196E52),
                                Color(0xFF115840),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(6.5),
                            ),
                          ),
                          child: const Text(
                            'Congratulations!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF6E7C1),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                          child: Column(
                            children: [
                              Text(
                                winner.displayName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF10553F),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Selected from Ilm-eligible seekers (${ChallengeRepository.formatIlm(winner.ilmScore)} Ilm) — Winner of an ${winner.prizeTitle} • ${winner.country}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF35594C),
                                  fontSize: 9.2,
                                  height: 1.3,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sponsored by: Duya Haramain',
                                    style: TextStyle(
                                      color: Color(0xFF5D7A6E),
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: onSpinAgain,
                                    child: const Text(
                                      '• Spin Again',
                                      style: TextStyle(
                                        color: DuyaColors.emerald,
                                        fontSize: 8.8,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: onToggleWinnerCard,
                                    child: const Text(
                                      '• View Wheel',
                                      style: TextStyle(
                                        color: Color(0xFF8C6D2E),
                                        fontSize: 8.8,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IslamicRaffleWheelPainter extends CustomPainter {
  _IslamicRaffleWheelPainter({
    required this.participants,
    required this.rotation,
    required this.canSpin,
    this.highlightedId,
  });

  final List<RaffleParticipant> participants;
  final double rotation;
  final bool canSpin;
  final String? highlightedId;

  @override
  void paint(Canvas canvas, Size size) {
    if (participants.isEmpty) return;

    // Position the wheel center at the bottom edge so the upper hemisphere
    // spans cleanly across the transparent section.
    final center = Offset(size.width / 2, size.height + 10);
    final radius = math.min(size.width * 0.45, 198.0);
    final outerBezelRadius = radius + 14;

    // 1. Outer emerald/gold bezel ring
    final glowPaint = Paint()
      ..color = const Color(0xFF288568).withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, outerBezelRadius, glowPaint);

    final outerRingPaint = Paint()
      ..color = const Color(0xFF1D6F55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, outerBezelRadius, outerRingPaint);

    // Sweeping highlight arc on the upper-left bezel
    final highlightArcPaint = Paint()
      ..color = const Color(0xFFC79A3C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerBezelRadius),
      -math.pi * 0.84,
      math.pi * 0.22,
      false,
      highlightArcPaint,
    );

    // 2. Rotating bezel tick marks between radius + 4 and outerBezelRadius - 3
    const tickCount = 60;
    final tickPaint = Paint()
      ..color = const Color(0xFF1D6F55).withValues(alpha: 0.55)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < tickCount; i++) {
      final tickAngle = (rotation * 0.5) + (i * 2 * math.pi / tickCount);
      final p1 = Offset(
        center.dx + (radius + 4) * math.cos(tickAngle),
        center.dy + (radius + 4) * math.sin(tickAngle),
      );
      final p2 = Offset(
        center.dx + (outerBezelRadius - 4) * math.cos(tickAngle),
        center.dy + (outerBezelRadius - 4) * math.sin(tickAngle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    // 3. Wheel radial slices + participant names
    final count = participants.length;
    final sweep = (2 * math.pi) / count;
    final wheelRect = Rect.fromCircle(center: center, radius: radius);

    final sliceBorderPaint = Paint()
      ..color = const Color(0xFFE7EFEA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    for (var i = 0; i < count; i++) {
      final participant = participants[i];
      final centerAngle = rotation + (i * sweep);
      final startAngle = centerAngle - (sweep / 2);
      final isHighlighted =
          highlightedId != null && participant.id == highlightedId;

      final Color sliceColor;
      if (isHighlighted) {
        sliceColor = const Color(0xFFC79A3C);
      } else if (i.isEven) {
        sliceColor = const Color(0xFF125A43);
      } else {
        sliceColor = const Color(0xFF2E8569);
      }

      final fillPaint = Paint()
        ..color = sliceColor
        ..style = PaintingStyle.fill;

      canvas.drawArc(wheelRect, startAngle, sweep, true, fillPaint);
      canvas.drawArc(wheelRect, startAngle, sweep, true, sliceBorderPaint);

      // Draw participant name radially inside each slice
      _drawRadialParticipantLabel(
        canvas: canvas,
        center: center,
        angle: centerAngle,
        radius: radius,
        participant: participant,
        isHighlighted: isHighlighted,
      );
    }

    // Inner rim stroke around the slice perimeter
    final innerRimPaint = Paint()
      ..color = const Color(0xFFB7DCEB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawCircle(center, radius, innerRimPaint);

    // 5. Center Islamic rosette hub at the bottom
    final hubRadius = radius * 0.25;
    final hubFill = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFF5A9AB5), Color(0xFF194B61)],
      ).createShader(Rect.fromCircle(center: center, radius: hubRadius));
    canvas.drawCircle(center, hubRadius, hubFill);

    final hubBorder = Paint()
      ..color = const Color(0xFFD9EEF7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, hubRadius, hubBorder);

    // "SPIN" label inside the center hub (shows 250 Ilm requirement when locked)
    final spinLabel = TextPainter(
      text: TextSpan(
        text: canSpin ? 'SPIN' : '250 Ilm',
        style: TextStyle(
          color: canSpin
              ? const Color(0xFFFFF3C4)
              : const Color(0xFFFFF3C4).withValues(alpha: 0.8),
          fontSize: canSpin ? 10.0 : 8.5,
          fontWeight: FontWeight.w800,
          letterSpacing: canSpin ? 1.1 : 0.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    spinLabel.paint(
      canvas,
      Offset(
        center.dx - spinLabel.width / 2,
        center.dy - (hubRadius * 0.48) - spinLabel.height / 2,
      ),
    );

    // 6. Top 12-o'clock teardrop pointer pin
    _drawTopPointer(canvas, Offset(center.dx, center.dy - radius));
  }

  void _drawRadialParticipantLabel({
    required Canvas canvas,
    required Offset center,
    required double angle,
    required double radius,
    required RaffleParticipant participant,
    required bool isHighlighted,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);

    final normalized = angle % (2 * math.pi);
    final cosVal = math.cos(normalized);
    final flip = cosVal < 0;

    canvas.rotate(flip ? normalized + math.pi : normalized);

    final textSpan = TextSpan(
      text: participant.displayName,
      style: TextStyle(
        color: isHighlighted ? const Color(0xFFFFF3C4) : Colors.white,
        fontSize: 9.6,
        fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );

    final tp = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: radius * 0.62);

    final innerOffset = radius * 0.30;
    final outerOffset = radius * 0.92;
    final posDx = innerOffset + ((outerOffset - innerOffset - tp.width) / 2);
    final dx = flip ? -(posDx + tp.width) : posDx;

    tp.paint(canvas, Offset(dx, -tp.height / 2));
    canvas.restore();
  }

  void _drawTopPointer(Canvas canvas, Offset rimTop) {
    final pinHeadCenter = Offset(rimTop.dx, rimTop.dy - 12);
    final pinTip = Offset(rimTop.dx, rimTop.dy + 16);

    final shadowPath = Path()
      ..moveTo(pinHeadCenter.dx - 7, pinHeadCenter.dy)
      ..arcToPoint(
        Offset(pinHeadCenter.dx + 7, pinHeadCenter.dy),
        radius: const Radius.circular(7),
      )
      ..lineTo(pinTip.dx, pinTip.dy)
      ..close();

    canvas.drawShadow(shadowPath, Colors.black, 4, true);

    final leftHalf = Path()
      ..moveTo(pinHeadCenter.dx, pinHeadCenter.dy - 7)
      ..arcToPoint(
        Offset(pinHeadCenter.dx - 7, pinHeadCenter.dy),
        radius: const Radius.circular(7),
        clockwise: false,
      )
      ..lineTo(pinTip.dx, pinTip.dy)
      ..close();

    final rightHalf = Path()
      ..moveTo(pinHeadCenter.dx, pinHeadCenter.dy - 7)
      ..arcToPoint(
        Offset(pinHeadCenter.dx + 7, pinHeadCenter.dy),
        radius: const Radius.circular(7),
      )
      ..lineTo(pinTip.dx, pinTip.dy)
      ..close();

    canvas.drawPath(
      leftHalf,
      Paint()..color = const Color(0xFF7AC2DF),
    );
    canvas.drawPath(
      rightHalf,
      Paint()..color = const Color(0xFF3E7E9B),
    );
    canvas.drawCircle(
      pinHeadCenter,
      6.5,
      Paint()..color = const Color(0xFF6BB5D4),
    );
    canvas.drawCircle(
      pinHeadCenter,
      6.5,
      Paint()
        ..color = const Color(0xFFD5F0FA)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _IslamicRaffleWheelPainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.canSpin != canSpin ||
        oldDelegate.highlightedId != highlightedId ||
        oldDelegate.participants.length != participants.length;
  }
}
