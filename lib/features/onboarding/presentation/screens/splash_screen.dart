import 'package:flutter/material.dart';
import '../widgets/farmgate_logo.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();

    // 3 seconds animation for the progress bar
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressController.addListener(() {
      setState(() {
        _progressValue = _progressController.value;
      });
    });

    _progressController.forward().then((_) {
      // Navigate to WelcomeScreen with a smooth transition
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image with Gradients
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlays to match the mockup (light warm cream top, deep dark olive at bottom)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFBF9F4).withOpacity(0.98), // Cream top for status bar
                    const Color(0xFFFBF9F4).withOpacity(0.95), // Cream background for text readability
                    const Color(0xFFFBF9F4).withOpacity(0.65), // Soft transition
                    Colors.transparent,                        // Let warm sunset background show in the middle
                    const Color(0xFF121B11).withOpacity(0.85), // Dark green transition before features
                    const Color(0xFF0C120C).withOpacity(0.98), // Deep dark olive bottom
                  ],
                  stops: const [0.0, 0.35, 0.58, 0.70, 0.84, 1.0],
                ),
              ),
            ),
          ),

          // 2. Main Content Scrollable / Column
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                
                // Top floating leaves effect (mocked visually via Icons/Decorations)
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
                      padding: const EdgeInsets.only(right: 30, top: 40),
                      child: Transform.rotate(
                        angle: 0.8,
                        child: Icon(Icons.eco, color: const Color(0xFF2E7D32).withOpacity(0.22), size: 55),
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Logo Container
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: const FarmGateLogo(size: 110),
                  ),
                ),
                const SizedBox(height: 18),

                // Brand Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'FarmGate ',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20), // Premium Dark Green
                      ),
                    ),
                    Text(
                      'Pay',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE29A26), // Amber-orange
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Tagline
                const Text(
                  'Post-Harvest Instant Settlement',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF556B5C), // Greenish Grey
                  ),
                ),
                const SizedBox(height: 16),

                // Leaf Divider: ——— 🍃 ———
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 1.5,
                      color: const Color(0xFFB5C4BA),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.eco,
                        color: Color(0xFF2E7D32),
                        size: 16,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 1.5,
                      color: const Color(0xFFB5C4BA),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Descriptive Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'Instant payment after delivery confirmation at the farm gate.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Color(0xFF3E4D42), // Premium dark greyish green
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const Spacer(flex: 5),

                // 3. Features Row (placed above the bottom sheet)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureItem(
                        icon: Icons.flash_on,
                        title: 'Instant\nSettlement',
                      ),
                      _buildFeatureDivider(),
                      _buildFeatureItem(
                        icon: Icons.shield_outlined,
                        title: 'Secure &\nReliable',
                      ),
                      _buildFeatureDivider(),
                      _buildFeatureItem(
                        icon: Icons.local_florist_outlined,
                        title: 'Empowering\nFarmers',
                      ),
                    ],
                  ),
                ),

                // 4. White Bottom Sheet
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAF8F5), // Light warm cream background
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "Powered by monnify" row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shield,
                            color: Color(0xFF1B5E20),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Powered by ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'monnify',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Container(
                              height: 6,
                              width: double.infinity,
                              color: const Color(0xFFEDE8E0), // Light cream progress track
                            ),
                            FractionallySizedBox(
                              widthFactor: _progressValue,
                              child: Container(
                                height: 6,
                                color: const Color(0xFF2E7D32), // Dark green progress bar
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
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

  Widget _buildFeatureItem({required IconData icon, required String title}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
              border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF388E3C).withOpacity(0.85), // Soft green circular badge
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.15),
    );
  }
}
