import 'package:flutter/material.dart';

/// A pixel-perfect logo painted in vector for FarmGate Pay
class FarmGateLogo extends StatelessWidget {
  final double size;

  const FarmGateLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _FarmGateLogoPainter(),
      ),
    );
  }
}

class _FarmGateLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    // Draw the orange gradient circle background
    final basePaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFFBBF24), // amber-400
          Color(0xFFD97706), // amber-600
        ],
        center: Alignment(-0.25, -0.25),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius, basePaint);

    // Clip to the circle boundary for the fields at the bottom
    canvas.save();
    final clipPath = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(clipPath);

    final greenFieldPaint = Paint()
      ..color = const Color(0xFF1B5E20) // dark green
      ..style = PaintingStyle.fill;
    
    final whiteFieldPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw bottom field background (curve starting at ~55% of height)
    final fieldPath = Path();
    fieldPath.moveTo(0, h * 0.55);
    fieldPath.cubicTo(w * 0.3, h * 0.35, w * 0.7, h * 0.75, w, h * 0.55);
    fieldPath.lineTo(w, h);
    fieldPath.lineTo(0, h);
    fieldPath.close();
    canvas.drawPath(fieldPath, greenFieldPaint);

    // White stripe 1
    final whiteStripePath1 = Path();
    whiteStripePath1.moveTo(0, h * 0.7);
    whiteStripePath1.cubicTo(w * 0.35, h * 0.52, w * 0.7, h * 0.85, w, h * 0.7);
    whiteStripePath1.lineTo(w, h * 0.76);
    whiteStripePath1.cubicTo(w * 0.7, h * 0.9, w * 0.35, h * 0.62, 0, h * 0.76);
    whiteStripePath1.close();
    canvas.drawPath(whiteStripePath1, whiteFieldPaint);

    // Green stripe 2
    final greenStripe2 = Path();
    greenStripe2.moveTo(0, h * 0.82);
    greenStripe2.cubicTo(w * 0.35, h * 0.72, w * 0.7, h * 0.94, w, h * 0.82);
    greenStripe2.lineTo(w, h * 0.87);
    greenStripe2.cubicTo(w * 0.7, h * 0.98, w * 0.35, h * 0.8, 0, h * 0.87);
    greenStripe2.close();
    canvas.drawPath(greenStripe2, greenFieldPaint);

    // White stripe 3 (bottom curve)
    final whiteStripePath3 = Path();
    whiteStripePath3.moveTo(0, h * 0.9);
    whiteStripePath3.cubicTo(w * 0.35, h * 0.82, w * 0.7, h * 0.98, w, h * 0.9);
    whiteStripePath3.lineTo(w, h);
    whiteStripePath3.lineTo(0, h);
    whiteStripePath3.close();
    canvas.drawPath(whiteStripePath3, whiteFieldPaint);

    // Darker green stripe at very bottom
    final darkGreenStripe = Path();
    darkGreenStripe.moveTo(0, h * 0.95);
    darkGreenStripe.cubicTo(w * 0.35, h * 0.9, w * 0.7, h * 1.0, w, h * 0.95);
    darkGreenStripe.lineTo(w, h);
    darkGreenStripe.lineTo(0, h);
    darkGreenStripe.close();
    canvas.drawPath(darkGreenStripe, Paint()..color = const Color(0xFF0F3D13)..style = PaintingStyle.fill);

    canvas.restore();

    // Draw the green plant on top
    final plantPaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..style = PaintingStyle.fill;
    
    // Stem
    final stemPath = Path();
    stemPath.moveTo(w * 0.47, h * 0.65);
    stemPath.lineTo(w * 0.47, h * 0.36);
    stemPath.cubicTo(w * 0.47, h * 0.35, w * 0.53, h * 0.35, w * 0.53, h * 0.36);
    stemPath.lineTo(w * 0.53, h * 0.65);
    stemPath.close();
    canvas.drawPath(stemPath, plantPaint);

    // Center Leaf (Vertical)
    final centerLeaf = Path();
    centerLeaf.moveTo(w * 0.5, h * 0.20);
    centerLeaf.cubicTo(w * 0.42, h * 0.27, w * 0.42, h * 0.38, w * 0.5, h * 0.44);
    centerLeaf.cubicTo(w * 0.58, h * 0.38, w * 0.58, h * 0.27, w * 0.5, h * 0.20);
    centerLeaf.close();
    canvas.drawPath(centerLeaf, plantPaint);

    // Center leaf line
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = w * 0.02
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.24), Offset(w * 0.5, h * 0.42), linePaint);

    // Left Leaf
    final leftLeaf = Path();
    leftLeaf.moveTo(w * 0.36, h * 0.27);
    leftLeaf.cubicTo(w * 0.31, h * 0.35, w * 0.39, h * 0.46, w * 0.49, h * 0.41);
    leftLeaf.cubicTo(w * 0.46, h * 0.32, w * 0.40, h * 0.25, w * 0.36, h * 0.27);
    leftLeaf.close();
    canvas.drawPath(leftLeaf, plantPaint);

    // Left leaf line
    canvas.drawLine(Offset(w * 0.38, h * 0.29), Offset(w * 0.47, h * 0.39), linePaint);

    // Right Leaf
    final rightLeaf = Path();
    rightLeaf.moveTo(w * 0.64, h * 0.27);
    rightLeaf.cubicTo(w * 0.69, h * 0.35, w * 0.61, h * 0.46, w * 0.51, h * 0.41);
    rightLeaf.cubicTo(w * 0.54, h * 0.32, w * 0.60, h * 0.25, w * 0.64, h * 0.27);
    rightLeaf.close();
    canvas.drawPath(rightLeaf, plantPaint);

    // Right leaf line
    canvas.drawLine(Offset(w * 0.62, h * 0.29), Offset(w * 0.53, h * 0.39), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
