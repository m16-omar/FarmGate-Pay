import 'package:flutter/material.dart';
import '../../../../main.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  void _onGoToDashboard(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainTabShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              
              // 1. Done Stepper Progress
              _buildCompletedStepper(),
              const SizedBox(height: 36),

              // 2. Confetti & Checkmark Circle Graphic
              SizedBox(
                height: 160,
                width: double.infinity,
                child: CustomPaint(
                  painter: _SuccessGraphicsPainter(),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Success Title & Description
              const Text(
                'Account Created',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Successfully!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.eco, color: Color(0xFF2E7D32), size: 24),
                ],
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'You\'re all set! Start using FarmGate Pay to receive instant payments for your harvest.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 28),

              // 4. "What you can do now" Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What you can do now',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Line Indicator
                    Container(
                      width: 48,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE75A1E), // Orange line
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 1. Receive Instant Payments
                    _buildFeatureRow(
                      icon: Icons.account_balance_wallet,
                      iconBg: const Color(0xFFF1F8E9),
                      iconColor: const Color(0xFF558B2F),
                      title: 'Receive Instant Payments',
                      description: 'Get paid within minutes after delivery confirmation.',
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F1EF)),

                    // 2. Track Deliveries
                    _buildFeatureRow(
                      icon: Icons.assignment_outlined,
                      iconBg: const Color(0xFFFFF8E1),
                      iconColor: const Color(0xFFF57F17),
                      title: 'Track Deliveries',
                      description: 'Monitor your deliveries, weights and payment status.',
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F1EF)),

                    // 3. View Earnings
                    _buildFeatureRow(
                      icon: Icons.trending_up,
                      iconBg: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                      title: 'View Earnings',
                      description: 'See your earnings history and performance insights.',
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F1EF)),

                    // 4. Get Support
                    _buildFeatureRow(
                      icon: Icons.headset_mic_outlined,
                      iconBg: const Color(0xFFECEFF1),
                      iconColor: const Color(0xFF37474F),
                      title: 'Get Support',
                      description: 'Reach our support team anytime you need help.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 5. Dashboard Navigation Buttons
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _onGoToDashboard(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Go to Dashboard',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              TextButton(
                onPressed: () => _onGoToDashboard(context),
                child: const Text(
                  'Explore App Features',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedStepper() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStepCircle(1, 'Phone'),
        _buildStepLine(),
        _buildStepCircle(2, 'Verify'),
        _buildStepLine(),
        _buildStepCircle(3, 'Profile'),
        _buildStepLine(),
        _buildStepCircle(4, 'Complete'),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFF2E7D32),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.check, size: 14, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Container(
      width: 20,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF2E7D32),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 18),
      ],
    );
  }
}

/// A custom painter that draws a large green check badge, leaves, and flying confetti particles
class _SuccessGraphicsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.5);

    // 1. Draw Confetti particles
    final confettiPaint1 = Paint()..color = const Color(0xFFFFB300)..style = PaintingStyle.fill;
    final confettiPaint2 = Paint()..color = const Color(0xFFE75A1E)..style = PaintingStyle.fill;
    final confettiPaint3 = Paint()..color = const Color(0xFF2E7D32)..style = PaintingStyle.fill;

    // Drawing some flying rectangles and circles
    canvas.drawRect(Rect.fromLTRB(w * 0.2, h * 0.2, w * 0.23, h * 0.25), confettiPaint1);
    canvas.drawCircle(Offset(w * 0.25, h * 0.7), 2.5, confettiPaint2);
    canvas.drawRect(Rect.fromLTRB(w * 0.75, h * 0.3, w * 0.78, h * 0.35), confettiPaint2);
    canvas.drawCircle(Offset(w * 0.82, h * 0.65), 3, confettiPaint3);
    canvas.drawRect(Rect.fromLTRB(w * 0.3, h * 0.8, w * 0.33, h * 0.83), confettiPaint1);

    // 2. Draw Leaves sprouting from sides
    final leafPaint = Paint()..color = const Color(0xFF81C784)..style = PaintingStyle.fill;
    
    // Left Leaves
    final leftLeaf = Path()
      ..moveTo(center.dx - 45, center.dy + 10)
      ..cubicTo(center.dx - 65, center.dy - 5, center.dx - 70, center.dy + 15, center.dx - 45, center.dy + 10)
      ..close();
    final leftLeaf2 = Path()
      ..moveTo(center.dx - 40, center.dy - 10)
      ..cubicTo(center.dx - 60, center.dy - 20, center.dx - 62, center.dy, center.dx - 40, center.dy - 10)
      ..close();
    canvas.drawPath(leftLeaf, leafPaint);
    canvas.drawPath(leftLeaf2, leafPaint);

    // Right Leaves
    final rightLeaf = Path()
      ..moveTo(center.dx + 45, center.dy + 10)
      ..cubicTo(center.dx + 65, center.dy - 5, center.dx + 70, center.dy + 15, center.dx + 45, center.dy + 10)
      ..close();
    final rightLeaf2 = Path()
      ..moveTo(center.dx + 40, center.dy - 10)
      ..cubicTo(center.dx + 60, center.dy - 20, center.dx + 62, center.dy, center.dx + 40, center.dy - 10)
      ..close();
    canvas.drawPath(rightLeaf, leafPaint);
    canvas.drawPath(rightLeaf2, leafPaint);

    // 3. Draw Checkmark Badge (green circle)
    final circlePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
      ).createShader(Rect.fromCircle(center: center, radius: 36))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 36, circlePaint);

    // Soft outer shadow circle
    final outerRingPaint = Paint()
      ..color = const Color(0xFFE8F5E9)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 42, outerRingPaint);

    // 4. White Checkmark inside circle
    final checkPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final checkPath = Path()
      ..moveTo(center.dx - 14, center.dy - 2)
      ..lineTo(center.dx - 3, center.dy + 9)
      ..lineTo(center.dx + 15, center.dy - 9);
    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
