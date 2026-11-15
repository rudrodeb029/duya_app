import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Ilm (knowledge) reward emblem: four softly-rounded golden diamonds
/// arranged in a diamond cluster (top, left, right, bottom).
class IlmDiamondsPainter extends CustomPainter {
  const IlmDiamondsPainter({this.color = const Color(0xFFE2C378)});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = math.min(size.width, size.height);
    final center = Offset(size.width / 2, size.height / 2);
    // Each small diamond is a square rotated 45°; half-diagonal = r.
    final r = s * 0.22;
    final gap = s * 0.035;
    final offset = r + gap;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (final d in [
      Offset(0, -offset),
      Offset(-offset, 0),
      Offset(offset, 0),
      Offset(0, offset),
    ]) {
      final c = center + d;
      final path = Path()
        ..moveTo(c.dx, c.dy - r)
        ..lineTo(c.dx + r, c.dy)
        ..lineTo(c.dx, c.dy + r)
        ..lineTo(c.dx - r, c.dy)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant IlmDiamondsPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Sized Ilm icon widget built on [IlmDiamondsPainter].
class IlmIcon extends StatelessWidget {
  const IlmIcon({super.key, this.size = 20, this.color = const Color(0xFFD4A84B)});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: IlmDiamondsPainter(color: color)),
    );
  }
}

/// Draws an 8-pointed Rub el Hizb geometric star emblem used as Duya's signature motif.
class RubElHizbPainter extends CustomPainter {
  const RubElHizbPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.filled = false,
  });

  final Color color;
  final double strokeWidth;
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final side = math.min(size.width, size.height) * 0.62;
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round;

    for (final angle in [0.0, math.pi / 4]) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: side,
        height: side,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(side * 0.08)),
        paint,
      );
      canvas.restore();
    }

    final dotPaint = Paint()..color = color;
    canvas.drawCircle(center, side * 0.1, dotPaint);
  }

  @override
  bool shouldRepaint(covariant RubElHizbPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.filled != filled;
}

/// Clips a container into a gentle Islamic Mihrab pointed arch.
class MihrabArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final archHeight = size.height * 0.28;
    path.moveTo(0, size.height);
    path.lineTo(0, archHeight);
    path.quadraticBezierTo(size.width * 0.12, archHeight * 0.25, size.width * 0.5, 0);
    path.quadraticBezierTo(size.width * 0.88, archHeight * 0.25, size.width, archHeight);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Draws subtle concentric celestial orbit rings behind hero cards.
class ConcentricOrbitPainter extends CustomPainter {
  const ConcentricOrbitPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.85, size.height * 0.22);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, i * 44.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConcentricOrbitPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Duya Arch Shield Logo: gold geometric mihrab crest housing a crisp emerald mosque silhouette.
class DuyaArchLogoPainter extends CustomPainter {
  const DuyaArchLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final archPath = Path()
      ..moveTo(w * 0.50, h * 0.04)
      ..quadraticBezierTo(w * 0.72, h * 0.16, w * 0.88, h * 0.28)
      ..lineTo(w * 0.88, h * 0.88)
      ..lineTo(w * 0.12, h * 0.88)
      ..lineTo(w * 0.12, h * 0.28)
      ..quadraticBezierTo(w * 0.28, h * 0.16, w * 0.50, h * 0.04)
      ..close();

    canvas.drawShadow(archPath, const Color(0x2810543D), 4, false);
    canvas.drawPath(archPath, Paint()..color = Colors.white);

    final goldBorder = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE0BA58), Color(0xFFC08E2C), Color(0xFF939B43)],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(archPath, goldBorder);

    // Subtle green base trim inside arch
    final greenTrim = Paint()..color = const Color(0xFF14634C);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.16, h * 0.79, w * 0.68, h * 0.08),
        const Radius.circular(2),
      ),
      greenTrim,
    );

    // Mosque minarets & main central dome
    final emeraldPaint = Paint()..color = const Color(0xFF135E46);
    // Left minaret
    canvas.drawRect(Rect.fromLTWH(w * 0.25, h * 0.44, w * 0.06, h * 0.36), emeraldPaint);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.24, h * 0.44)
        ..lineTo(w * 0.28, h * 0.34)
        ..lineTo(w * 0.32, h * 0.44)
        ..close(),
      emeraldPaint,
    );
    // Right minaret
    canvas.drawRect(Rect.fromLTWH(w * 0.69, h * 0.44, w * 0.06, h * 0.36), emeraldPaint);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.68, h * 0.44)
        ..lineTo(w * 0.72, h * 0.34)
        ..lineTo(w * 0.76, h * 0.44)
        ..close(),
      emeraldPaint,
    );
    // Center body & dome
    canvas.drawRect(Rect.fromLTWH(w * 0.34, h * 0.56, w * 0.32, h * 0.24), emeraldPaint);
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.56), width: w * 0.30, height: h * 0.26),
      math.pi,
      math.pi,
      true,
      emeraldPaint,
    );
    // Spire + arched doorway cutout
    canvas.drawLine(
      Offset(w * 0.50, h * 0.36),
      Offset(w * 0.50, h * 0.44),
      Paint()
        ..color = const Color(0xFF135E46)
        ..strokeWidth = 1.8,
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.45, h * 0.65, w * 0.10, h * 0.15),
        topLeft: Radius.circular(w * 0.05),
        topRight: Radius.circular(w * 0.05),
      ),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Crisp golden Rawdah Mosque silhouette with dome & flanking minarets.
class RawdahMosqueIconPainter extends CustomPainter {
  const RawdahMosqueIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final primaryGold = Paint()..color = const Color(0xFFC2902E);
    final brightGold = Paint()..color = const Color(0xFFDFB559);
    final bronzeAccent = Paint()..color = const Color(0xFF9A6C18);

    // Base plinth
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.10, h * 0.74, w * 0.80, h * 0.12),
        const Radius.circular(2),
      ),
      primaryGold,
    );
    // Flanking side domes
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.28, h * 0.66), width: w * 0.20, height: h * 0.22),
      math.pi,
      math.pi,
      true,
      brightGold,
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.72, h * 0.66), width: w * 0.20, height: h * 0.22),
      math.pi,
      math.pi,
      true,
      brightGold,
    );
    // Minarets
    canvas.drawRect(Rect.fromLTWH(w * 0.14, h * 0.36, w * 0.08, h * 0.40), primaryGold);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.13, h * 0.36)
        ..lineTo(w * 0.18, h * 0.22)
        ..lineTo(w * 0.23, h * 0.36)
        ..close(),
      bronzeAccent,
    );
    canvas.drawRect(Rect.fromLTWH(w * 0.78, h * 0.36, w * 0.08, h * 0.40), primaryGold);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.77, h * 0.36)
        ..lineTo(w * 0.82, h * 0.22)
        ..lineTo(w * 0.87, h * 0.36)
        ..close(),
      bronzeAccent,
    );
    // Central dome & spire
    canvas.drawRect(Rect.fromLTWH(w * 0.34, h * 0.56, w * 0.32, h * 0.20), primaryGold);
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.56), width: w * 0.34, height: h * 0.36),
      math.pi,
      math.pi,
      true,
      primaryGold,
    );
    canvas.drawCircle(Offset(w * 0.50, h * 0.34), w * 0.035, bronzeAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Crisp 3D isometric Kaaba cube with Kiswah gold band for Hajj & Umrah tiles.
class IsometricKaabaIconPainter extends CustomPainter {
  const IsometricKaabaIconPainter({this.variant = 0});

  final int variant;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final topFace = Path()
      ..moveTo(w * 0.50, h * 0.16)
      ..lineTo(w * 0.84, h * 0.30)
      ..lineTo(w * 0.50, h * 0.44)
      ..lineTo(w * 0.16, h * 0.30)
      ..close();

    final leftFace = Path()
      ..moveTo(w * 0.16, h * 0.30)
      ..lineTo(w * 0.50, h * 0.44)
      ..lineTo(w * 0.50, h * 0.86)
      ..lineTo(w * 0.16, h * 0.72)
      ..close();

    final rightFace = Path()
      ..moveTo(w * 0.50, h * 0.44)
      ..lineTo(w * 0.84, h * 0.30)
      ..lineTo(w * 0.84, h * 0.72)
      ..lineTo(w * 0.50, h * 0.86)
      ..close();

    canvas.drawPath(topFace, Paint()..color = const Color(0xFF28483D));
    canvas.drawPath(leftFace, Paint()..color = const Color(0xFF1A342B));
    canvas.drawPath(rightFace, Paint()..color = const Color(0xFF234136));

    // Gold Kiswah Hizam calligraphy belt across both visible faces
    final leftBand = Path()
      ..moveTo(w * 0.16, h * 0.41)
      ..lineTo(w * 0.50, h * 0.55)
      ..lineTo(w * 0.50, h * 0.62)
      ..lineTo(w * 0.16, h * 0.48)
      ..close();
    final rightBand = Path()
      ..moveTo(w * 0.50, h * 0.55)
      ..lineTo(w * 0.84, h * 0.41)
      ..lineTo(w * 0.84, h * 0.48)
      ..lineTo(w * 0.50, h * 0.62)
      ..close();
    final gold = Paint()..color = const Color(0xFFD5A946);
    canvas.drawPath(leftBand, gold);
    canvas.drawPath(rightBand, Paint()..color = const Color(0xFFE3BE64));

    // Subtle gold door on the right (or left) face
    final doorRect = variant == 0
        ? (Path()
          ..moveTo(w * 0.61, h * 0.60)
          ..lineTo(w * 0.70, h * 0.56)
          ..lineTo(w * 0.70, h * 0.73)
          ..lineTo(w * 0.61, h * 0.77)
          ..close())
        : (Path()
          ..moveTo(w * 0.30, h * 0.56)
          ..lineTo(w * 0.39, h * 0.60)
          ..lineTo(w * 0.39, h * 0.77)
          ..lineTo(w * 0.30, h * 0.73)
          ..close());
    canvas.drawPath(doorRect, gold);
  }

  @override
  bool shouldRepaint(covariant IsometricKaabaIconPainter oldDelegate) =>
      oldDelegate.variant != variant;
}

/// Sculptural green-to-gold corner arch ribbon for the Prayer Time card.
class PrayerArchRibbonPainter extends CustomPainter {
  const PrayerArchRibbonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldSwoosh = Path()
      ..moveTo(w * 0.56, 0)
      ..quadraticBezierTo(w * 0.96, h * 0.36, w * 0.98, h)
      ..lineTo(0, h)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(
      goldSwoosh,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD6AD4E), Color(0xFFB58C35), Color(0xFFF3DF9E)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    final emeraldShape = Path()
      ..moveTo(0, h * 0.14)
      ..quadraticBezierTo(w * 0.20, 0, w * 0.32, h * 0.02)
      ..quadraticBezierTo(w * 0.88, h * 0.38, w * 0.84, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(
      emeraldShape,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2B876A), Color(0xFF125A43), Color(0xFF0E4936)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Faint mosque watermark behind the prayer banner center.
class MosqueWatermarkPainter extends CustomPainter {
  const MosqueWatermarkPainter({this.color = const Color(0x1614634C)});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = color;

    canvas.drawRect(Rect.fromLTWH(w * 0.12, h * 0.62, w * 0.76, h * 0.38), paint);
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.62), width: w * 0.42, height: h * 0.56),
      math.pi,
      math.pi,
      true,
      paint,
    );
    canvas.drawRect(Rect.fromLTWH(w * 0.18, h * 0.18, w * 0.06, h * 0.50), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.76, h * 0.24, w * 0.05, h * 0.44), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.49, h * 0.14, w * 0.02, h * 0.24), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Curved emerald & gold silk swoosh ribbon for card bottom-right corners.
class CardSilkRibbonPainter extends CustomPainter {
  const CardSilkRibbonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldCurve = Path()
      ..moveTo(w * 0.28, h)
      ..quadraticBezierTo(w * 0.68, h * 0.66, w, h * 0.36)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(
      goldCurve,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFD2A343), Color(0xFFF0D58A)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    final greenCurve = Path()
      ..moveTo(w * 0.38, h)
      ..quadraticBezierTo(w * 0.72, h * 0.74, w, h * 0.46)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(
      greenCurve,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF0E4D39), Color(0xFF1F7A5D)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Bottom footer emerald & gold silk wave hovering right above the bottom nav bar.
class BottomWaveBannerPainter extends CustomPainter {
  const BottomWaveBannerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final goldWave = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(w * 0.22, h * 0.48, w * 0.54, h * 0.72)
      ..quadraticBezierTo(w * 0.80, h * 0.90, w, h * 0.26)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(
      goldWave,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFD8AE52), Color(0xFFF3DF9E), Color(0xFFD4A745)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    final emeraldWave = Path()
      ..moveTo(0, h * 0.24)
      ..quadraticBezierTo(w * 0.28, h * 0.72, w * 0.62, h * 0.84)
      ..quadraticBezierTo(w * 0.84, h * 0.90, w, h * 0.44)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(
      emeraldWave,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF16694E), Color(0xFF288264), Color(0xFF0F4F3B)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Eight distinct ornamental Islamic frame styles paired with each Challenge Door card.
enum DoorBorderStyle {
  nabawiLattice,
  quranMushaf,
  makkahKiswah,
  madinahDome,
  umrahWaves,
  hajjSunburst,
  prayerMihrab,
  duasTasbih,
}

/// Renders an intricate, unique Islamic ornamental border around each Challenge
/// Door card according to [style] and [accentColor].
class DoorIslamicBorderPainter extends CustomPainter {
  const DoorIslamicBorderPainter({
    required this.style,
    required this.accentColor,
    this.goldColor = const Color(0xFFC99A3B),
  });

  final DoorBorderStyle style;
  final Color accentColor;
  final Color goldColor;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    const inset = 6.0;
    final outer = Rect.fromLTWH(inset, inset, w - inset * 2, h - inset * 2);
    final inner = outer.deflate(4.0);

    final primaryStroke = Paint()
      ..color = accentColor.withValues(alpha: 0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25;

    final goldStroke = Paint()
      ..color = goldColor.withValues(alpha: 0.72)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.05;

    final goldFill = Paint()
      ..color = goldColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final primaryFill = Paint()
      ..color = accentColor.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;

    switch (style) {
      case DoorBorderStyle.nabawiLattice:
        // Chamfered octagonal outer frame + inner gold hairline & center Rub-el-Hizb stars.
        canvas.drawPath(_chamferedPath(outer, 9), primaryStroke);
        canvas.drawPath(_chamferedPath(inner, 6), goldStroke);
        _drawOctagram(
          canvas,
          Offset(w / 2, outer.top),
          4.2,
          goldFill,
        );
        _drawOctagram(
          canvas,
          Offset(w / 2, outer.bottom),
          4.2,
          primaryFill,
        );
        for (final p in _corners(outer, 4.5)) {
          canvas.drawCircle(p, 1.8, goldFill);
        }

      case DoorBorderStyle.quranMushaf:
        // Illuminated Mushaf border with gentle pointed crown crest & diamond corner seals.
        final arch = Path()
          ..moveTo(outer.left + 8, outer.top)
          ..lineTo(w / 2 - 14, outer.top)
          ..quadraticBezierTo(w / 2, outer.top - 5, w / 2 + 14, outer.top)
          ..lineTo(outer.right - 8, outer.top)
          ..quadraticBezierTo(outer.right, outer.top, outer.right, outer.top + 8)
          ..lineTo(outer.right, outer.bottom - 8)
          ..quadraticBezierTo(outer.right, outer.bottom, outer.right - 8, outer.bottom)
          ..lineTo(outer.left + 8, outer.bottom)
          ..quadraticBezierTo(outer.left, outer.bottom, outer.left, outer.bottom - 8)
          ..lineTo(outer.left, outer.top + 8)
          ..quadraticBezierTo(outer.left, outer.top, outer.left + 8, outer.top);
        canvas.drawPath(arch, primaryStroke);
        canvas.drawRRect(
          RRect.fromRectAndRadius(inner, const Radius.circular(4)),
          goldStroke,
        );
        for (final p in _corners(inner, 2.0)) {
          _drawDiamond(canvas, p, 3.3, goldFill);
        }

      case DoorBorderStyle.makkahKiswah:
        // Kiswah belt double frame with scalloped corner brackets & square gold studs on vertical rails.
        canvas.drawRRect(
          RRect.fromRectAndRadius(outer, const Radius.circular(5)),
          primaryStroke..strokeWidth = 1.6,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(inner, const Radius.circular(3)),
          goldStroke,
        );
        for (final t in [0.28, 0.5, 0.72]) {
          final y = outer.top + outer.height * t;
          _drawDiamond(canvas, Offset(outer.left, y), 2.3, goldFill);
          _drawDiamond(canvas, Offset(outer.right, y), 2.3, goldFill);
        }
        _drawCornerScallops(canvas, outer, goldColor.withValues(alpha: 0.75));

      case DoorBorderStyle.madinahDome:
        // Curved horseshoe-dome top rail + fine crescent medallions at bottom corners.
        final domeFrame = Path()
          ..moveTo(outer.left, outer.bottom - 6)
          ..lineTo(outer.left, outer.top + 14)
          ..quadraticBezierTo(outer.left, outer.top, outer.left + 16, outer.top)
          ..lineTo(outer.right - 16, outer.top)
          ..quadraticBezierTo(outer.right, outer.top, outer.right, outer.top + 14)
          ..lineTo(outer.right, outer.bottom - 6)
          ..quadraticBezierTo(outer.right, outer.bottom, outer.right - 6, outer.bottom)
          ..lineTo(outer.left + 6, outer.bottom)
          ..quadraticBezierTo(outer.left, outer.bottom, outer.left, outer.bottom - 6);
        canvas.drawPath(domeFrame, goldStroke..strokeWidth = 1.35);
        canvas.drawRRect(
          RRect.fromRectAndRadius(inner, const Radius.circular(6)),
          primaryStroke,
        );
        _drawOctagram(
          canvas,
          Offset(outer.left + 9, outer.bottom - 9),
          3.4,
          primaryFill,
        );
        _drawOctagram(
          canvas,
          Offset(outer.right - 9, outer.bottom - 9),
          3.4,
          primaryFill,
        );

      case DoorBorderStyle.umrahWaves:
        // Clean Hejaz outer frame + golden twin-peak Safa & Marwah wave line along bottom edge.
        canvas.drawRRect(
          RRect.fromRectAndRadius(outer, const Radius.circular(6)),
          primaryStroke,
        );
        canvas.drawLine(
          Offset(inner.left + 10, inner.top),
          Offset(inner.right - 10, inner.top),
          goldStroke,
        );
        final hillLine = Path()
          ..moveTo(inner.left + 8, inner.bottom)
          ..lineTo(w * 0.34, inner.bottom)
          ..quadraticBezierTo(w * 0.42, inner.bottom - 6, w * 0.50, inner.bottom)
          ..quadraticBezierTo(w * 0.58, inner.bottom - 6, w * 0.66, inner.bottom)
          ..lineTo(inner.right - 8, inner.bottom);
        canvas.drawPath(hillLine, goldStroke..strokeWidth = 1.25);
        for (final p in _corners(outer, 5)) {
          _drawDiamond(canvas, p, 2.4, primaryFill);
        }

      case DoorBorderStyle.hajjSunburst:
        // Geometric stepped corner L-brackets + dotted pilgrim trail top/bottom dividers.
        canvas.drawRRect(
          RRect.fromRectAndRadius(outer, const Radius.circular(5)),
          goldStroke,
        );
        _drawCornerBrackets(canvas, outer, accentColor.withValues(alpha: 0.72));
        for (var i = -3; i <= 3; i++) {
          final x = w / 2 + i * 7.0;
          canvas.drawCircle(
            Offset(x, inner.bottom),
            i == 0 ? 2.1 : 1.2,
            i == 0 ? goldFill : primaryFill,
          );
        }

      case DoorBorderStyle.prayerMihrab:
        // Crisp Mihrab top arch accent + 4 Qibla compass ticks on midpoints.
        canvas.drawRRect(
          RRect.fromRectAndRadius(outer, const Radius.circular(6)),
          primaryStroke,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(inner, const Radius.circular(4)),
          goldStroke..strokeWidth = 0.85,
        );
        final tickPaint = Paint()
          ..color = goldColor.withValues(alpha: 0.9)
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(w / 2, outer.top - 2), Offset(w / 2, inner.top + 2), tickPaint);
        canvas.drawLine(Offset(w / 2, inner.bottom - 2), Offset(w / 2, outer.bottom + 2), tickPaint);
        canvas.drawLine(Offset(outer.left - 2, h / 2), Offset(inner.left + 2, h / 2), tickPaint);
        canvas.drawLine(Offset(inner.right - 2, h / 2), Offset(outer.right + 2, h / 2), tickPaint);

      case DoorBorderStyle.duasTasbih:
        // Pearl-beaded Tasbih dots along top & bottom edges inside a fine teal frame.
        canvas.drawRRect(
          RRect.fromRectAndRadius(outer, const Radius.circular(7)),
          primaryStroke,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(inner, const Radius.circular(5)),
          goldStroke..strokeWidth = 0.85,
        );
        for (var x = inner.left + 12; x <= inner.right - 12; x += 9.0) {
          canvas.drawCircle(Offset(x, inner.bottom), 1.4, goldFill);
        }
        for (final p in _corners(outer, 5)) {
          canvas.drawCircle(p, 2.2, primaryFill);
        }
    }
  }

  List<Offset> _corners(Rect r, double offset) => [
        Offset(r.left + offset, r.top + offset),
        Offset(r.right - offset, r.top + offset),
        Offset(r.left + offset, r.bottom - offset),
        Offset(r.right - offset, r.bottom - offset),
      ];

  Path _chamferedPath(Rect r, double c) => Path()
    ..moveTo(r.left + c, r.top)
    ..lineTo(r.right - c, r.top)
    ..lineTo(r.right, r.top + c)
    ..lineTo(r.right, r.bottom - c)
    ..lineTo(r.right - c, r.bottom)
    ..lineTo(r.left + c, r.bottom)
    ..lineTo(r.left, r.bottom - c)
    ..lineTo(r.left, r.top + c)
    ..close();

  void _drawDiamond(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path()
      ..moveTo(center.dx, center.dy - r)
      ..lineTo(center.dx + r, center.dy)
      ..lineTo(center.dx, center.dy + r)
      ..lineTo(center.dx - r, center.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawOctagram(Canvas canvas, Offset center, double radius, Paint paint) {
    final side = radius * 1.4;
    for (final angle in [0.0, math.pi / 4]) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: side, height: side),
        paint,
      );
      canvas.restore();
    }
  }

  void _drawCornerScallops(Canvas canvas, Rect r, Color color) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    const len = 10.0;
    // Top-left, top-right, bottom-left, bottom-right subtle inner arcs
    canvas.drawArc(
      Rect.fromLTWH(r.left - len / 2, r.top - len / 2, len, len),
      0,
      math.pi / 2,
      false,
      p,
    );
    canvas.drawArc(
      Rect.fromLTWH(r.right - len / 2, r.top - len / 2, len, len),
      math.pi / 2,
      math.pi / 2,
      false,
      p,
    );
    canvas.drawArc(
      Rect.fromLTWH(r.left - len / 2, r.bottom - len / 2, len, len),
      -math.pi / 2,
      math.pi / 2,
      false,
      p,
    );
    canvas.drawArc(
      Rect.fromLTWH(r.right - len / 2, r.bottom - len / 2, len, len),
      math.pi,
      math.pi / 2,
      false,
      p,
    );
  }

  void _drawCornerBrackets(Canvas canvas, Rect r, Color color) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.square;
    const leg = 11.0;
    final path = Path()
      ..moveTo(r.left, r.top + leg)
      ..lineTo(r.left, r.top)
      ..lineTo(r.left + leg, r.top)
      ..moveTo(r.right - leg, r.top)
      ..lineTo(r.right, r.top)
      ..lineTo(r.right, r.top + leg)
      ..moveTo(r.left, r.bottom - leg)
      ..lineTo(r.left, r.bottom)
      ..lineTo(r.left + leg, r.bottom)
      ..moveTo(r.right - leg, r.bottom)
      ..lineTo(r.right, r.bottom)
      ..lineTo(r.right, r.bottom - leg);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant DoorIslamicBorderPainter oldDelegate) =>
      oldDelegate.style != style ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.goldColor != goldColor;
}
