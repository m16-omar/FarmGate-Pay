import 'package:flutter/material.dart';
import '../widgets/farmgate_logo.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background image with gradient overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Warm cream top, deep dark green bottom gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFBF9F4).withOpacity(0.98), // Cream top
                    const Color(0xFFFBF9F4).withOpacity(0.92), // Cream middle-top
                    const Color(0xFFFBF9F4).withOpacity(0.70), // Transition
                    Colors.transparent,                        // Sunset center
                    const Color(0xFF121B11).withOpacity(0.85), // Dark green transition
                    const Color(0xFF0C120C).withOpacity(0.98), // Deep dark olive bottom
                  ],
                  stops: const [0.0, 0.35, 0.58, 0.70, 0.84, 1.0],
                ),
              ),
            ),
          ),

          // 2. Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                
                // Top floating leaves
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Transform.rotate(
                        angle: -0.5,
                        child: Icon(Icons.eco_outlined, color: const Color(0xFF2E7D32).withOpacity(0.18), size: 45),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      child: Transform.rotate(
                        angle: 0.8,
                        child: Icon(Icons.eco, color: const Color(0xFF2E7D32).withOpacity(0.22), size: 55),
                      ),
                    ),
                  ],
                ),

                // Logo
                const Center(
                  child: FarmGateLogo(size: 80),
                ),
                const SizedBox(height: 10),

                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Welcome to ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'FarmGate ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    Text(
                      'Pay',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE29A26),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Leaf Divider: ——— 🍃 ———
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 1.5,
                      color: const Color(0xFFB5C4BA),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.eco,
                        color: Color(0xFF2E7D32),
                        size: 14,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 1.5,
                      color: const Color(0xFFB5C4BA),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // PageView Slider Content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildSlideOne(),
                      _buildSlideTwo(),
                      _buildSlideThree(),
                    ],
                  ),
                ),

                // 3. Small Capsule Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.shield, color: Color(0xFF81C784), size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Secure. Transparent. Empowering Farmers.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Dot Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) => _buildDot(index)),
                ),
                const SizedBox(height: 24),

                // 5. White Bottom Sheet Controls
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAF8F5), // Light warm cream background
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "Get Started" button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _onGetStarted,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32), // Dark green
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
                                'Get Started',
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

                      // "Already have an account? Sign In" text button
                      GestureDetector(
                        onTap: _onGetStarted,
                        child: RichText(
                          text: const TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign In',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Slide 1 - 4 Step Workflow
  Widget _buildSlideOne() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'The smart way to get paid instantly after delivery at the farm gate.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF556B5C),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // 4 Step workflow card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF9F6).withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWorkflowStep(
                icon: Icons.inventory_2,
                title: 'Deliver',
                desc: 'Produce delivered\nand confirmed',
              ),
              _buildWorkflowDottedLine(),
              _buildWorkflowStep(
                icon: Icons.assignment_turned_in,
                title: 'Verify',
                desc: 'Weight & quality\nverified',
              ),
              _buildWorkflowDottedLine(),
              _buildWorkflowStep(
                icon: Icons.security,
                title: 'Secure',
                desc: 'Payment secured\nwith Monnify',
              ),
              _buildWorkflowDottedLine(),
              _buildWorkflowStep(
                icon: Icons.payments,
                title: 'Get Paid',
                desc: 'Receive money\ninstantly',
                isHighlighted: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Slide 2 - Bank Settlement Details
  Widget _buildSlideTwo() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Instant payouts sent directly to your linked bank account via Monnify webhook integration.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF556B5C),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Monnify receipt card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF9F6).withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFE8F5E9),
                        radius: 16,
                        child: Icon(Icons.check, color: Color(0xFF2E7D32), size: 16),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Monnify Payout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Success', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    '₦145,200',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2E7D32)),
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildReceiptRow('Farmer:', 'Aliyu Ibrahim'),
              _buildReceiptRow('Account:', 'Zenith Bank • ****567'),
              _buildReceiptRow('Reference:', 'FP-48201-MNFY'),
            ],
          ),
        ),
      ],
    );
  }

  // Slide 3 - Digital Ledger
  Widget _buildSlideThree() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Keep transparent digital logs of weight and payment records, avoiding bookkeeping disputes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF556B5C),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Delivery History Card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF9F6).withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              _buildLedgerItem('Maize Delivery', '240 kg', '₦144,000', 'Settled'),
              const Divider(height: 12),
              _buildLedgerItem('Cocoa Delivery', '80 kg', '₦200,000', 'Settled'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkflowStep({
    required IconData icon,
    required String title,
    required String desc,
    bool isHighlighted = false,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: isHighlighted ? const Color(0xFFE29A26) : const Color(0xFFE8F5E9),
            radius: 20,
            child: Icon(
              icon,
              color: isHighlighted ? Colors.white : const Color(0xFF2E7D32),
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              height: 1.2,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowDottedLine() {
    return Text(
      '--',
      style: TextStyle(
        color: const Color(0xFF2E7D32).withOpacity(0.4),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildLedgerItem(String title, String qty, String amount, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.eco, color: Color(0xFF2E7D32), size: 16),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                Text(qty, style: const TextStyle(color: Colors.grey, fontSize: 9)),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF2E7D32))),
            Text(status, style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? const Color(0xFF2E7D32)
            : const Color(0xFFB5C4BA),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
