import 'dart:math' as math;
import 'package:flutter/material.dart';

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

/// Custom architectural door silhouettes for the 4 Knowledge Challenge doors.
class ChallengeDoorPainter extends CustomPainter {
  const ChallengeDoorPainter({
    required this.doorColor,
    required this.variantIndex,
  });

  final Color doorColor;
  final int variantIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final fill = Paint()
      ..color = doorColor
      ..style = PaintingStyle.fill;

    final path = Path();
    if (variantIndex == 0) {
      // Stepped Prophet's Mosque door silhouette
      path.moveTo(w * 0.16, h * 0.94);
      path.lineTo(w * 0.16, h * 0.44);
      path.lineTo(w * 0.08, h * 0.34);
      path.lineTo(w * 0.24, h * 0.2);
      path.lineTo(w * 0.5, h * 0.08);
      path.lineTo(w * 0.76, h * 0.2);
      path.lineTo(w * 0.92, h * 0.34);
      path.lineTo(w * 0.84, h * 0.44);
      path.lineTo(w * 0.84, h * 0.94);
      path.close();
    } else if (variantIndex == 1) {
      // Pointed Ogee Qur'an arch door
      path.moveTo(w * 0.18, h * 0.94);
      path.lineTo(w * 0.18, h * 0.35);
      path.quadraticBezierTo(w * 0.25, h * 0.18, w * 0.5, h * 0.07);
      path.quadraticBezierTo(w * 0.75, h * 0.18, w * 0.82, h * 0.35);
      path.lineTo(w * 0.82, h * 0.94);
      path.close();
    } else if (variantIndex == 2) {
      // Scalloped Makkah arch door
      path.moveTo(w * 0.16, h * 0.94);
      path.lineTo(w * 0.16, h * 0.34);
      path.arcToPoint(Offset(w * 0.36, h * 0.16), radius: Radius.circular(w * 0.14));
      path.arcToPoint(Offset(w * 0.64, h * 0.16), radius: Radius.circular(w * 0.16));
      path.arcToPoint(Offset(w * 0.84, h * 0.34), radius: Radius.circular(w * 0.14));
      path.lineTo(w * 0.84, h * 0.94);
      path.close();
    } else {
      // Horseshoe Madinah dome-arch door
      path.moveTo(w * 0.18, h * 0.94);
      path.lineTo(w * 0.18, h * 0.4);
      path.arcToPoint(
        Offset(w * 0.82, h * 0.4),
        radius: Radius.circular(w * 0.33),
        largeArc: true,
      );
      path.lineTo(w * 0.82, h * 0.94);
      path.close();
    }

    canvas.drawPath(path, fill);

    // Center seam & traditional double-handle detail
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(w * 0.5, h * 0.12),
      Offset(w * 0.5, h * 0.94),
      linePaint,
    );

    final knobPaint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(w * 0.44, h * 0.56), 3.2, knobPaint);
    canvas.drawCircle(Offset(w * 0.56, h * 0.56), 3.2, knobPaint);
  }

  @override
  bool shouldRepaint(covariant ChallengeDoorPainter oldDelegate) =>
      oldDelegate.doorColor != doorColor ||
      oldDelegate.variantIndex != variantIndex;
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

/// Crisp green Rawdah Mosque silhouette with dome & flanking minarets.
class RawdahMosqueIconPainter extends CustomPainter {
  const RawdahMosqueIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final green = Paint()..color = const Color(0xFF14634C);
    final bright = Paint()..color = const Color(0xFF218063);
    final gold = Paint()..color = const Color(0xFFD5A946);

    // Base plinth
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.10, h * 0.74, w * 0.80, h * 0.12),
        const Radius.circular(2),
      ),
      green,
    );
    // Flanking side domes
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.28, h * 0.66), width: w * 0.20, height: h * 0.22),
      math.pi,
      math.pi,
      true,
      bright,
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.72, h * 0.66), width: w * 0.20, height: h * 0.22),
      math.pi,
      math.pi,
      true,
      bright,
    );
    // Minarets
    canvas.drawRect(Rect.fromLTWH(w * 0.14, h * 0.36, w * 0.08, h * 0.40), green);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.13, h * 0.36)
        ..lineTo(w * 0.18, h * 0.22)
        ..lineTo(w * 0.23, h * 0.36)
        ..close(),
      green,
    );
    canvas.drawRect(Rect.fromLTWH(w * 0.78, h * 0.36, w * 0.08, h * 0.40), green);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.77, h * 0.36)
        ..lineTo(w * 0.82, h * 0.22)
        ..lineTo(w * 0.87, h * 0.36)
        ..close(),
      green,
    );
    // Central dome & spire
    canvas.drawRect(Rect.fromLTWH(w * 0.34, h * 0.56, w * 0.32, h * 0.20), green);
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.56), width: w * 0.34, height: h * 0.36),
      math.pi,
      math.pi,
      true,
      green,
    );
    canvas.drawCircle(Offset(w * 0.50, h * 0.34), w * 0.035, gold);
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
