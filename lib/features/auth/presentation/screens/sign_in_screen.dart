import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../onboarding/presentation/widgets/farmgate_logo.dart';
import 'verification_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainTabShell()),
    );
  }

  void _onSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const VerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Curved Header Image
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/splash_bg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Soft overlay
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Logo card overlapping the curved header
                Positioned(
                  bottom: -15,
                  left: 24,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const FarmGateLogo(size: 60),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 36),

            // 2. Welcome Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Welcome ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Text(
                        'Back',
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
                  const SizedBox(height: 6),
                  const Text(
                    'Sign in to continue to your FarmGate Pay account',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Form Inputs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phone Number Field
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Flag & Country Code Selector
                        Row(
                          children: const [
                            Text('🇳🇬', style: TextStyle(fontSize: 20)),
                            SizedBox(width: 6),
                            Text(
                              '+234',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
                          ],
                        ),
                        const SizedBox(width: 12),
                        // Verticle divider line
                        Container(
                          width: 1,
                          height: 24,
                          color: const Color(0xFFE2E2DF),
                        ),
                        const SizedBox(width: 12),
                        // Phone input
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: '803 123 4567',
                              hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Password Field
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 14),
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF666666)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: const Color(0xFF666666),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E2DF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. Remember me & Forgot Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (val) {
                          setState(() {
                            _rememberMe = val ?? false;
                          });
                        },
                        activeColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 5. Sign In Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onSignIn,
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
                        'Sign In',
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
            ),
            const SizedBox(height: 24),

            // 6. Social Login Section
            Row(
              children: [
                const Expanded(child: Divider(indent: 24, endIndent: 12)),
                Text(
                  'or continue with',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Expanded(child: Divider(indent: 12, endIndent: 24)),
              ],
            ),
            const SizedBox(height: 18),

            // Social Buttons Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildSocialButton(
                    icon: Icons.g_mobiledata_rounded,
                    label: 'Google',
                    color: Colors.red[600]!,
                  ),
                  const SizedBox(width: 12),
                  _buildSocialButton(
                    icon: Icons.apple,
                    label: 'Apple',
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  _buildSocialButton(
                    icon: Icons.phone_android,
                    label: 'Phone OTP',
                    color: const Color(0xFF2E7D32),
                    onTap: _onSignUp, // Phone OTP leads to verification
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 7. Security Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF9), // Warm amber background tint
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFBEFD6), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.verified_user,
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
                                'Your data is protected with bank-level security and encryption.',
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
                  const SizedBox(width: 12),
                  // Lock Custom Graphic
                  const PadlockGraphic(),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 8. Footer Link
            Center(
              child: GestureDetector(
                onTap: _onSignUp,
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: 'Create Account',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap ?? _onSignIn,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E2DF)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    // Smooth bezier curve swooping down on left, and up on the right
    path.quadraticBezierTo(
      size.width * 0.35,
      size.height,
      size.width * 0.70,
      size.height - 35,
    );
    path.quadraticBezierTo(
      size.width * 0.88,
      size.height - 50,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// A custom gold padlock graphic matching the mockup
class PadlockGraphic extends StatelessWidget {
  const PadlockGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 55,
      child: CustomPaint(
        painter: _PadlockPainter(),
      ),
    );
  }
}

class _PadlockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    final goldBodyPaint = Paint()
      ..color = const Color(0xFFF5E3B8)
      ..style = PaintingStyle.fill;

    final goldShadowPaint = Paint()
      ..color = const Color(0xFFE5CE93)
      ..style = PaintingStyle.fill;
    
    final shacklePaint = Paint()
      ..color = const Color(0xFFD6C088)
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 1. Draw Shackle (U-shape)
    final shacklePath = Path()
      ..moveTo(w * 0.28, h * 0.40)
      ..lineTo(w * 0.28, h * 0.22)
      ..cubicTo(w * 0.28, h * 0.05, w * 0.72, h * 0.05, w * 0.72, h * 0.22)
      ..lineTo(w * 0.72, h * 0.40);
    canvas.drawPath(shacklePath, shacklePaint);

    // 2. Draw Lock Body (rounded box)
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.1, h * 0.35, w * 0.9, h * 0.95),
      const Radius.circular(12),
    );
    canvas.drawRRect(bodyRect, goldBodyPaint);

    // Lock body shading / shadow details
    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.7, h * 0.35, w * 0.9, h * 0.95),
      const Radius.circular(12),
    );
    canvas.save();
    canvas.clipRRect(bodyRect);
    canvas.drawRRect(shadowRect, goldShadowPaint);
    
    // Draw leaf shape in center of lock
    final leafPaint = Paint()
      ..color = const Color(0xFFD6C088).withOpacity(0.6)
      ..style = PaintingStyle.fill;
    final leafPath = Path();
    leafPath.moveTo(w * 0.5, h * 0.50);
    leafPath.cubicTo(w * 0.38, h * 0.60, w * 0.38, h * 0.75, w * 0.5, h * 0.82);
    leafPath.cubicTo(w * 0.62, h * 0.75, w * 0.62, h * 0.60, w * 0.5, h * 0.50);
    leafPath.close();
    canvas.drawPath(leafPath, leafPaint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
