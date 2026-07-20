import 'dart:async';
import 'package:flutter/material.dart';
import 'profile_setup_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  
  int _secondsRemaining = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 45;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onVerify() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    String timerText = '00:${_secondsRemaining.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              
              // 1. Back button & Stepper
              Row(
                children: [
                  // Back button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: const Icon(Icons.chevron_left, color: Color(0xFF333333)),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  
                  // Linear Stepper (4 steps)
                  _buildStepper(),
                  
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Title Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Verify Your',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32)),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.eco, color: Color(0xFF2E7D32), size: 24),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Description
              RichText(
                text: const TextSpan(
                  text: 'Enter the 6-digit code sent to\n',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 13, height: 1.4, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: '+234 803 123 4567 ',
                      style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Edit',
                      style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Central Phone & Wheat Illustration
              Center(
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _VerificationIllustrationPainter(),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 4. OTP Inputs (6 individual digit boxes)
              const Text(
                'Enter 6-digit code',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 12),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOtpBox(index)),
              ),
              const SizedBox(height: 16),

              // Resend code timer text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Resend code in ',
                    style: TextStyle(fontSize: 13, color: Color(0xFF666666), fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: _secondsRemaining == 0 ? _startTimer : null,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: Text(
                      timerText,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _secondsRemaining == 0 ? const Color(0xFF2E7D32) : const Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 5. Verify & Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onVerify,
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
                        'Verify & Continue',
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
              const SizedBox(height: 24),

              // 6. Secure & Trusted Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFC8E6C9).withOpacity(0.5), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lock,
                      color: Color(0xFF2E7D32),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Secure & Trusted',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'We take your security seriously. Your data is always protected.',
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.3,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStepCircle(1, 'Phone', isCompleted: true),
        _buildStepLine(isCompleted: true),
        _buildStepCircle(2, 'Verify', isActive: true),
        _buildStepLine(isCompleted: false),
        _buildStepCircle(3, 'Profile'),
        _buildStepLine(isCompleted: false),
        _buildStepCircle(4, 'Complete'),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label, {bool isCompleted = false, bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color(0xFF2E7D32)
                : (isActive ? Colors.white : Colors.transparent),
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted || isActive ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
              width: 1.5,
            ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Text(
                    step.toString(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isActive ? const Color(0xFF2E7D32) : const Color(0xFF999999),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: isCompleted || isActive ? FontWeight.bold : FontWeight.normal,
            color: isCompleted || isActive ? const Color(0xFF333333) : const Color(0xFF999999),
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine({required bool isCompleted}) {
    return Container(
      width: 20,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 46,
      height: 56,
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        decoration: InputDecoration(
          counterText: '',
          hintText: '-',
          hintStyle: const TextStyle(color: Color(0xFFB5C4BA)),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E2DF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.8),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          }
        },
      ),
    );
  }
}

/// A custom painter that draws a phone mockup displaying SMS code and wheat stalks under a warm sunset
class _VerificationIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    // Draw background warm glow circle
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFF8E1).withOpacity(0.95),
          const Color(0xFFFBFBF9).withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(w * 0.5, h * 0.45), radius: w * 0.35))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.45), w * 0.35, glowPaint);

    // 1. Draw Wheat Stalks (on the left and back)
    final wheatPaint = Paint()
      ..color = const Color(0xFFE8C88B)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final wheatFillPaint = Paint()
      ..color = const Color(0xFFE8C88B)
      ..style = PaintingStyle.fill;

    // Drawing a few wheat stems
    _drawWheat(canvas, Offset(w * 0.4, h * 0.9), Offset(w * 0.38, h * 0.35), wheatPaint, wheatFillPaint);
    _drawWheat(canvas, Offset(w * 0.44, h * 0.9), Offset(w * 0.45, h * 0.3), wheatPaint, wheatFillPaint);

    // 2. Draw Phone Mockup
    final phoneFramePaint = Paint()
      ..color = const Color(0xFF2E7D32) // Forest green phone frame
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final phoneBodyPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w * 0.65, h * 0.5), width: 75, height: 130),
      const Radius.circular(16),
    );
    canvas.drawRRect(phoneRect, phoneBodyPaint);
    canvas.drawRRect(phoneRect, phoneFramePaint);

    // Phone Notch/Speaker
    final notchPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
    final notchRect = RRect.fromRectAndCorners(
      Rect.fromLTRB(w * 0.65 - 15, h * 0.5 - 65, w * 0.65 + 15, h * 0.5 - 59),
      bottomLeft: const Radius.circular(4),
      bottomRight: const Radius.circular(4),
    );
    canvas.drawRRect(notchRect, notchPaint);

    // Inside phone: Speech bubble representing SMS
    final smsBubblePaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..style = PaintingStyle.fill;
    final smsBubblePath = Path()
      ..moveTo(w * 0.58, h * 0.4)
      ..quadraticBezierTo(w * 0.58, h * 0.32, w * 0.66, h * 0.32)
      ..quadraticBezierTo(w * 0.74, h * 0.32, w * 0.74, h * 0.4)
      ..quadraticBezierTo(w * 0.74, h * 0.48, w * 0.68, h * 0.48)
      ..lineTo(w * 0.63, h * 0.53)
      ..lineTo(w * 0.63, h * 0.48)
      ..quadraticBezierTo(w * 0.58, h * 0.48, w * 0.58, h * 0.4)
      ..close();
    canvas.drawPath(smsBubblePath, smsBubblePaint);

    // Bubble Text Lines (white strokes)
    final smsTextLinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.62, h * 0.37), Offset(w * 0.70, h * 0.37), smsTextLinePaint);
    canvas.drawLine(Offset(w * 0.62, h * 0.41), Offset(w * 0.67, h * 0.41), smsTextLinePaint);
    canvas.drawLine(Offset(w * 0.62, h * 0.45), Offset(w * 0.72, h * 0.45), smsTextLinePaint);

    // Golden "6" Badge
    final badgePaint = Paint()
      ..color = const Color(0xFFE29A26)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.73, h * 0.31), 9, badgePaint);

    // Number '6' on badge (drawn with white lines)
    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(Offset(w * 0.73, h * 0.31 + 1), 2.5, textPaint);
    canvas.drawLine(Offset(w * 0.71, h * 0.31 + 1), Offset(w * 0.73, h * 0.28), textPaint);

    // Small Phone Screen Content Details
    final detailsPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(w * 0.65, h * 0.68), width: 45, height: 10),
        const Radius.circular(4),
      ),
      detailsPaint,
    );

    // Progress Dots on Phone Screen
    final dotPaint = Paint()
      ..color = const Color(0xFF2E7D32).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(Offset(w * 0.58 + (i * 7), h * 0.78), 2.5, dotPaint);
    }
  }

  void _drawWheat(Canvas canvas, Offset start, Offset end, Paint paint, Paint fillPaint) {
    canvas.drawLine(start, end, paint);
    
    // Draw wheat grains along the top third of the stem
    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    
    for (double i = 0.4; i <= 1.0; i += 0.1) {
      final double x = start.dx + dx * i;
      final double y = start.dy + dy * i;
      
      // Draw grains left and right
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x - 5, y - 2), width: 7, height: 4),
        fillPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x + 5, y - 2), width: 7, height: 4),
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
