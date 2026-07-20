import 'package:flutter/material.dart';
import 'success_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController(text: 'Musa Ibrahim');
  String _selectedCrop = 'Maize';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onContinue() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SuccessScreen()),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              
              // 1. Back button & Stepper
              Row(
                children: [
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
                  _buildStepper(),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Header and Avatar Illustration
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tell Us About',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'You',
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
                        SizedBox(height: 8),
                        Text(
                          'Complete your profile to get started with FarmGate Pay',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Avatar Domed Frame with Verified Badge
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFBEFD6),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border.all(color: const Color(0xFFD6C088), width: 1.5),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: CustomPaint(
                                  painter: _FarmerAvatarPainter(),
                                ),
                              ),
                            ),
                            // Verified Farmer Badge
                            Positioned(
                              bottom: -8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFC8E6C9), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.verified, color: Color(0xFF2E7D32), size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      'Verified Farmer',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ],
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
              const SizedBox(height: 28),

              // 3. Profile Fields
              // Full Name Field
              const Text(
                'Full Name',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF666666)),
                  suffixIcon: const Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
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
              const SizedBox(height: 16),

              // Date of Birth Field
              const Text(
                'Date of Birth',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.calendar_today_outlined, color: Color(0xFF666666), size: 20),
                    SizedBox(width: 12),
                    Text(
                      '12 Jan 1990',
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333), fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Location Field
              const Text(
                'Location',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.location_on_outlined, color: Color(0xFF666666), size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Kaduna State, Nigeria',
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333), fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Farm / Cooperative (Optional)
              const Text(
                'Farm / Cooperative (Optional)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.group_outlined, color: Color(0xFF666666), size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Kaduna Farmers Cooperative',
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333), fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 4. Wallet / Bank for Payout Widget
              const Text(
                'Wallet / Bank for Payout',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: [
                    // GTBank custom drawing logo
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE75A1E), // GTBank Orange
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'GTB',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'GTBank',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '**** **** **** 2188',
                            style: TextStyle(fontSize: 12, color: Color(0xFF777777), fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Savings Account',
                            style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 12),
                          SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right, color: Color(0xFF999999)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. What do you primarily grow?
              const Text(
                'What do you primarily grow?',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 12),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCropCard(name: 'Maize', emoji: '🌽'),
                    const SizedBox(width: 10),
                    _buildCropCard(name: 'Rice', emoji: '🌾'),
                    const SizedBox(width: 10),
                    _buildCropCard(name: 'Tomato', emoji: '🍅'),
                    const SizedBox(width: 10),
                    _buildCropCard(name: 'Yam', emoji: '🥔'),
                    const SizedBox(width: 10),
                    _buildCropCard(name: 'Others', emoji: '▫️'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 6. Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onContinue,
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
                        'Continue',
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
              
              // Secure info text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline, color: Color(0xFF999999), size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Your information is secure with us',
                    style: TextStyle(fontSize: 11, color: Color(0xFF999999), fontWeight: FontWeight.w500),
                  ),
                ],
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
        _buildStepCircle(2, 'Verify', isCompleted: true),
        _buildStepLine(isCompleted: true),
        _buildStepCircle(3, 'Profile', isActive: true),
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

  Widget _buildCropCard({required String name, required String emoji}) {
    bool isSelected = _selectedCrop == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCrop = name;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 70,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xFFF7F7F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
                width: isSelected ? 1.8 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E7D32),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A custom painter that draws a happy stylized African farmer smiling in a straw hat
class _FarmerAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background glow
    final bgPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFF2D0), Color(0xFFFBEFD6)],
      ).createShader(Rect.fromLTRB(0, 0, w, h));
    canvas.drawRect(Rect.fromLTRB(0, 0, w, h), bgPaint);

    // 1. Draw Body/Apron
    final apronPaint = Paint()
      ..color = const Color(0xFF33691E) // Green apron
      ..style = PaintingStyle.fill;
    final apronPath = Path()
      ..moveTo(w * 0.2, h * 0.9)
      ..lineTo(w * 0.25, h * 0.68)
      ..lineTo(w * 0.75, h * 0.68)
      ..lineTo(w * 0.8, h * 0.9)
      ..close();
    
    // Shoulders
    final shoulderPaint = Paint()
      ..color = const Color(0xFF4E342E) // Plaid brown shirt
      ..style = PaintingStyle.fill;
    final shoulderPath = Path()
      ..moveTo(0, h)
      ..lineTo(w * 0.15, h * 0.65)
      ..lineTo(w * 0.85, h * 0.65)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(shoulderPath, shoulderPaint);
    canvas.drawPath(apronPath, apronPaint);

    // Apron Straps (cross over shoulders)
    final strapPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(w * 0.25, h * 0.68), Offset(w * 0.18, h * 0.65), strapPaint);
    canvas.drawLine(Offset(w * 0.75, h * 0.68), Offset(w * 0.82, h * 0.65), strapPaint);

    // 2. Draw Head/Face
    final facePaint = Paint()
      ..color = const Color(0xFF5D4037) // Deep brown skin
      ..style = PaintingStyle.fill;
    
    // Neck
    canvas.drawRect(Rect.fromLTRB(w * 0.42, h * 0.5, w * 0.58, h * 0.68), facePaint);
    
    // Head circle
    canvas.drawCircle(Offset(w * 0.5, h * 0.42), 22, facePaint);

    // Beard
    final beardPaint = Paint()
      ..color = const Color(0xFF212121)
      ..style = PaintingStyle.fill;
    final beardPath = Path()
      ..moveTo(w * 0.38, h * 0.44)
      ..lineTo(w * 0.38, h * 0.52)
      ..quadraticBezierTo(w * 0.5, h * 0.60, w * 0.62, h * 0.52)
      ..lineTo(w * 0.62, h * 0.44)
      ..quadraticBezierTo(w * 0.5, h * 0.48, w * 0.38, h * 0.44)
      ..close();
    canvas.drawPath(beardPath, beardPaint);

    // Eyes (Happy arcs)
    final eyePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.43, h * 0.39), width: 6, height: 4),
      3.14, 3.14, false, eyePaint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.57, h * 0.39), width: 6, height: 4),
      3.14, 3.14, false, eyePaint,
    );

    // Smile (mouth)
    final mouthPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final mouthPath = Path()
      ..moveTo(w * 0.43, h * 0.46)
      ..quadraticBezierTo(w * 0.5, h * 0.53, w * 0.57, h * 0.46)
      ..quadraticBezierTo(w * 0.5, h * 0.48, w * 0.43, h * 0.46)
      ..close();
    canvas.drawPath(mouthPath, mouthPaint);

    // Nose
    final nosePaint = Paint()
      ..color = const Color(0xFF4E342E)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.41), Offset(w * 0.5, h * 0.44), nosePaint);

    // 3. Draw Straw Hat
    final hatPaint = Paint()
      ..color = const Color(0xFFE0A96D) // Straw gold
      ..style = PaintingStyle.fill;
    
    final hatOutlinePaint = Paint()
      ..color = const Color(0xFFB57C43)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Hat Top Dome
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.28), width: 44, height: 26),
      3.14, 3.14, true, hatPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.28), width: 44, height: 26),
      3.14, 3.14, false, hatOutlinePaint,
    );

    // Hat Ribbon (brown)
    final ribbonPaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(w * 0.28, h * 0.26, w * 0.72, h * 0.28), ribbonPaint);

    // Hat Brim (Oval flat curve)
    final brimPath = Path()
      ..moveTo(w * 0.2, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.24, w * 0.8, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.36, w * 0.2, h * 0.3)
      ..close();
    canvas.drawPath(brimPath, hatPaint);
    canvas.drawPath(brimPath, hatOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
