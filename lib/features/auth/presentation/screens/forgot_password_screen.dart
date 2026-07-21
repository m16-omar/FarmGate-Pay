import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _currentStep = 1; // 1: Request, 2: OTP, 3: Reset, 4: Success
  String _resetMethod = 'email'; // 'email' or 'sms'

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  int _timerSeconds = 45;
  Timer? _timer;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timerSeconds = 45;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onSendReset() {
    if (_resetMethod == 'email' && _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_resetMethod == 'sms' && _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _currentStep = 2;
    });
    _startTimer();
  }

  void _onVerifyOTP() {
    // Check if OTP is complete
    String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete 6-digit OTP code'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _currentStep = 3;
    });
  }

  void _onResetPassword() {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your new password'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters long'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _currentStep = 4;
    });
  }

  void _onProceedToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              
              // 1. App Bar Back Button & Step Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep < 4)
                    InkWell(
                      onTap: () {
                        if (_currentStep > 1) {
                          setState(() {
                            _currentStep--;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
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
                    )
                  else
                    const SizedBox(width: 40, height: 40),
                  
                  _buildStepper(),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Illustration Header
              Center(
                child: SizedBox(
                  height: 140,
                  width: 200,
                  child: CustomPaint(
                    painter: _ResetIllustrationPainter(step: _currentStep),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Conditional Step Views
              if (_currentStep == 1) _buildRequestView(),
              if (_currentStep == 2) _buildOTPView(),
              if (_currentStep == 3) _buildResetView(),
              if (_currentStep == 4) _buildSuccessView(),
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
        _buildStepCircle(1, 'Request'),
        _buildStepLine(1),
        _buildStepCircle(2, 'Verify'),
        _buildStepLine(2),
        _buildStepCircle(3, 'Reset'),
        _buildStepLine(3),
        _buildStepCircle(4, 'Success'),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label) {
    bool isCompleted = _currentStep > step;
    bool isActive = _currentStep == step;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color(0xFF2E7D32)
                : isActive
                    ? const Color(0xFFE75A1E)
                    : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted || isActive ? Colors.transparent : const Color(0xFFE2E2DF),
            ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 10, color: Colors.white)
                : Text(
                    step.toString(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : const Color(0xFF888888),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.bold,
            color: isActive
                ? const Color(0xFFE75A1E)
                : isCompleted
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFF888888),
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int afterStep) {
    bool isColored = _currentStep > afterStep;
    return Container(
      width: 22,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      color: isColored ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
    );
  }

  Widget _buildRequestView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Forgot Password?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 6),
        const Text(
          'Choose how you want to receive your reset link or code to regain access to your account.',
          style: TextStyle(fontSize: 12, color: Color(0xFF777777), height: 1.4, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),

        // Reset Method Toggle Buttons
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _resetMethod = 'email'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _resetMethod == 'email' ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _resetMethod == 'email' ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
                      width: _resetMethod == 'email' ? 1.5 : 1,
                    ),
                    boxShadow: _resetMethod == 'email'
                        ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 3))]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.mail_outline_rounded,
                        color: _resetMethod == 'email' ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                        size: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _resetMethod == 'email' ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _resetMethod = 'sms'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _resetMethod == 'sms' ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _resetMethod == 'sms' ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
                      width: _resetMethod == 'sms' ? 1.5 : 1,
                    ),
                    boxShadow: _resetMethod == 'sms'
                        ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 3))]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.sms_outlined,
                        color: _resetMethod == 'sms' ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                        size: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'SMS Code',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _resetMethod == 'sms' ? const Color(0xFF2E7D32) : const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Input Field
        if (_resetMethod == 'email') ...[
          const Text(
            'Email Address',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E2DF)),
            ),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline_rounded, color: Color(0xFF2E7D32), size: 20),
                hintText: 'e.g., mail@example.com',
                hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ] else ...[
          const Text(
            'Phone Number',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E2DF)),
            ),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF2E7D32), size: 20),
                hintText: 'e.g., +234 80 1234 5678',
                hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),

        // Action Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _onSendReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Send Verification', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPView() {
    String destination = _resetMethod == 'email' ? _emailController.text : _phoneController.text;
    String timerText = '00:${_timerSeconds.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter Verification Code',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 6),
        Text(
          'We\'ve sent a 6-digit OTP code to $destination. Please type it in below.',
          style: const TextStyle(fontSize: 12, color: Color(0xFF777777), height: 1.4, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24),

        // OTP inputs row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 44,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  controller: _otpControllers[index],
                  focusNode: _otpFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 5) {
                        FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
                      } else {
                        _otpFocusNodes[index].unfocus();
                      }
                    } else {
                      if (index > 0) {
                        FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
                      }
                    }
                  },
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),

        // Timer & Resend
        Center(
          child: Column(
            children: [
              if (_timerSeconds > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined, size: 14, color: Color(0xFF777777)),
                    const SizedBox(width: 4),
                    Text(
                      'Code expires in: $timerText',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF777777), fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              else
                TextButton(
                  onPressed: _startTimer,
                  child: const Text(
                    'Resend Verification Code',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE75A1E),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Action Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _onVerifyOTP,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Verify Code', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildResetView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reset Password',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 6),
        const Text(
          'Enter a new secure password. Make sure it has at least 6 characters with mixed symbols.',
          style: TextStyle(fontSize: 12, color: Color(0xFF777777), height: 1.4, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),

        // Password Input
        const Text(
          'New Password',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E2DF)),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF2E7D32), size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF777777),
                  size: 20,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              hintText: 'Minimum 6 characters',
              hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Confirm Password Input
        const Text(
          'Confirm Password',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E2DF)),
          ),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF2E7D32), size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF777777),
                  size: 20,
                ),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
              hintText: 'Re-enter your password',
              hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Action Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _onResetPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Save New Password', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Password Reset',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Successfully!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
            ),
            SizedBox(width: 4),
            Icon(Icons.eco, color: Color(0xFF2E7D32), size: 24),
          ],
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Your password has been successfully updated. You can now sign in with your new password.',
            style: TextStyle(fontSize: 13, color: Color(0xFF666666), height: 1.4, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 36),

        // Proceed Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _onProceedToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Back to Sign In', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class _ResetIllustrationPainter extends CustomPainter {
  final int step;
  _ResetIllustrationPainter({required this.step});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.5);

    final greenPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
    
    final orangePaint = Paint()
      ..color = const Color(0xFFE75A1E)
      ..style = PaintingStyle.fill;

    final lightBgPaint = Paint()
      ..color = const Color(0xFFE8F5E9)
      ..style = PaintingStyle.fill;

    // Outer circle
    canvas.drawCircle(center, 44, lightBgPaint);

    if (step == 1) {
      // Padlock Body
      final padPaint = Paint()
        ..color = const Color(0xFF2E7D32)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.4, h * 0.45, w * 0.6, h * 0.75), const Radius.circular(8)),
        padPaint,
      );

      // Padlock Shackle
      final shacklePaint = Paint()
        ..color = const Color(0xFF555555)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromLTRB(w * 0.43, h * 0.32, w * 0.57, h * 0.52),
        3.14, 3.14, false, shacklePaint,
      );

      // Keyhole
      final keyholePaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(w * 0.5, h * 0.55), 3, keyholePaint);
      canvas.drawRect(Rect.fromLTRB(w * 0.49, h * 0.55, w * 0.51, h * 0.65), keyholePaint);

      // A small flying key outline
      final keyPaint = Paint()
        ..color = const Color(0xFFE75A1E)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(w * 0.72, h * 0.38), 4, keyPaint);
      canvas.drawLine(Offset(w * 0.72, h * 0.42), Offset(w * 0.72, h * 0.52), keyPaint);
      canvas.drawLine(Offset(w * 0.72, h * 0.47), Offset(w * 0.76, h * 0.47), keyPaint);
      canvas.drawLine(Offset(w * 0.72, h * 0.51), Offset(w * 0.76, h * 0.51), keyPaint);

    } else if (step == 2) {
      // Phone / SMS Code representation
      final phonePaint = Paint()
        ..color = const Color(0xFF333333)
        ..style = PaintingStyle.fill;
      
      // Phone body
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.42, h * 0.3, w * 0.58, h * 0.7), const Radius.circular(6)),
        phonePaint,
      );

      // Screen
      final screenPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
      canvas.drawRect(Rect.fromLTRB(w * 0.44, h * 0.35, w * 0.56, h * 0.63), screenPaint);

      // Home button
      final homePaint = Paint()..color = const Color(0xFF888888)..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(w * 0.5, h * 0.66), 2, homePaint);

      // Flying message bubbles
      final bubblePaint = Paint()
        ..color = const Color(0xFF2E7D32)
        ..style = PaintingStyle.fill;
      
      final bubblePath = Path()
        ..moveTo(w * 0.6, h * 0.28)
        ..lineTo(w * 0.74, h * 0.28)
        ..quadraticBezierTo(w * 0.78, h * 0.28, w * 0.78, h * 0.34)
        ..quadraticBezierTo(w * 0.78, h * 0.4, w * 0.74, h * 0.4)
        ..lineTo(w * 0.65, h * 0.4)
        ..lineTo(w * 0.6, h * 0.44)
        ..close();
      canvas.drawPath(bubblePath, bubblePaint);

      // Small dots inside message bubble
      final dotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(w * 0.66, h * 0.34), 1.5, dotPaint);
      canvas.drawCircle(Offset(w * 0.70, h * 0.34), 1.5, dotPaint);
      canvas.drawCircle(Offset(w * 0.74, h * 0.34), 1.5, dotPaint);

    } else if (step == 3) {
      // Key unlocking the pad lock
      final shacklePaint = Paint()
        ..color = const Color(0xFFE75A1E)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      
      // Unlocked shackle (slightly offset rotated)
      final shacklePath = Path()
        ..moveTo(w * 0.43, h * 0.48)
        ..lineTo(w * 0.43, h * 0.36)
        ..cubicTo(w * 0.43, h * 0.28, w * 0.57, h * 0.28, w * 0.57, h * 0.36);
      canvas.drawPath(shacklePath, shacklePaint);

      // Padlock Body
      final padPaint = Paint()
        ..color = const Color(0xFF2E7D32)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.4, h * 0.45, w * 0.6, h * 0.75), const Radius.circular(8)),
        padPaint,
      );

      // White Key entering/turning
      final keyPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(w * 0.5, h * 0.54), 3, keyPaint);
      canvas.drawLine(Offset(w * 0.5, h * 0.57), Offset(w * 0.5, h * 0.67), keyPaint);
      canvas.drawLine(Offset(w * 0.5, h * 0.63), Offset(w * 0.54, h * 0.63), keyPaint);

    } else {
      // Confetti & Sprouting checkmark (Success)
      final circlePaint = Paint()
        ..color = const Color(0xFF2E7D32)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, 30, circlePaint);

      final checkPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      
      final checkPath = Path()
        ..moveTo(center.dx - 11, center.dy - 1)
        ..lineTo(center.dx - 2, center.dy + 8)
        ..lineTo(center.dx + 12, center.dy - 6);
      canvas.drawPath(checkPath, checkPaint);

      // Colorful confetti dots
      canvas.drawCircle(Offset(w * 0.28, h * 0.25), 3, greenPaint);
      canvas.drawCircle(Offset(w * 0.74, h * 0.22), 3, orangePaint);
      canvas.drawCircle(Offset(w * 0.22, h * 0.7), 2.5, orangePaint);
      canvas.drawCircle(Offset(w * 0.78, h * 0.72), 3.5, greenPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ResetIllustrationPainter oldDelegate) {
    return oldDelegate.step != step;
  }
}
