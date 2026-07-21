import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'crop_management_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const ProfileScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. App Bar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else if (onBack != null) {
                          onBack!();
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
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Profile',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                    ),
                    // Bell icon
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Color(0xFF333333), size: 26),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                            );
                          },
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, color: Color(0xFF333333), size: 26),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // 2. Profile Details Banner Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Backdrop sunset field
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/splash_bg.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Farmer Avatar with camera edit icon
                            Stack(
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: ClipOval(
                                    child: CustomPaint(
                                      painter: _ProfileFarmerAvatarPainter(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2E7D32),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Musa Haruna',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F5E9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.verified, color: Color(0xFF2E7D32), size: 10),
                                        SizedBox(width: 4),
                                        Text(
                                          'Verified Farmer',
                                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '+234 803 123 4567',
                                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    'musa.haruna@example.com',
                                    style: TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            // Edit Profile Button
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit, color: Color(0xFF333333), size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Color(0xFF333333), fontSize: 10, fontWeight: FontWeight.bold),
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
              ),
              const SizedBox(height: 16),

              // 3. Stats Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildStatMiniCard(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF2E7D32),
                      value: '₦2,450,000',
                      label: 'Total Earnings',
                      subLabel: 'This Month',
                    ),
                    const SizedBox(width: 8),
                    _buildStatMiniCard(
                      icon: Icons.local_shipping_outlined,
                      iconColor: const Color(0xFFE65100),
                      value: '23',
                      label: 'Total Deliveries',
                      subLabel: 'This Month',
                    ),
                    const SizedBox(width: 8),
                    _buildStatMiniCard(
                      icon: Icons.star_border,
                      iconColor: const Color(0xFFF57F17),
                      value: '4.8 ★',
                      label: 'Rating',
                      subLabel: '120 Reviews',
                    ),
                    const SizedBox(width: 8),
                    _buildStatMiniCard(
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF7B1FA2),
                      value: 'Mar 2022',
                      label: 'Member Since',
                      subLabel: '2+ Years',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Settings List Groups
              // Account & Settings
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Account & Settings',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    _buildSettingsRow(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      subtitle: 'Update your personal details',
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.account_balance_outlined,
                      title: 'Bank Details',
                      subtitle: 'Manage your bank account',
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.verified_user_outlined,
                      title: 'Verification',
                      subtitle: 'KYC and account verification',
                      suffixWidget: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(6)),
                        child: const Text('Verified', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.notifications_none,
                      title: 'Notification Settings',
                      subtitle: 'Manage your notifications',
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.lock_outline,
                      title: 'Privacy & Security',
                      subtitle: 'Manage your privacy and security',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // My Business
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My Business',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    _buildSettingsRow(
                      icon: Icons.eco_outlined,
                      title: 'My Crops',
                      subtitle: 'Manage your crops and inventory',
                      suffixText: '5 Crops',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CropManagementScreen()),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Areas',
                      subtitle: 'Manage your delivery locations',
                      suffixText: '3 Areas',
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.description_outlined,
                      title: 'Documents',
                      subtitle: 'Manage your documents and certificates',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Support & Help
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Support & Help',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    _buildSettingsRow(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      subtitle: 'Get help and learn how to use the app',
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.headset_mic_outlined,
                      title: 'Contact Support',
                      subtitle: 'Chat with our support team',
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    _buildSettingsRow(
                      icon: Icons.info_outline,
                      title: 'About FarmGate',
                      subtitle: 'Learn more about us',
                      suffixText: 'v1.0.0',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Log Out Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context), // Go back to onboarding welcome/login
                    icon: const Icon(Icons.logout, color: Color(0xFFC62828), size: 20),
                    label: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC62828))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFFCDD2)),
                      backgroundColor: const Color(0xFFFFEBEE).withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatMiniCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required String subLabel,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 8, color: Color(0xFF888888), fontWeight: FontWeight.w600)),
          Text(subLabel, style: const TextStyle(fontSize: 8, color: Color(0xFFBBBBBB), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? suffixWidget,
    String? suffixText,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF2E7D32), size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 10, color: Color(0xFF888888), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            if (suffixWidget != null) ...[
              suffixWidget,
              const SizedBox(width: 8),
            ] else if (suffixText != null) ...[
              Text(suffixText, style: const TextStyle(color: Color(0xFF999999), fontSize: 10, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
            ],
            const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 18),
          ],
        ),
      ),
    );
  }
}

/// A custom painter that draws a farmer for the profile banner avatar
class _ProfileFarmerAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Face skin
    final facePaint = Paint()..color = const Color(0xFF5D4037)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.28, facePaint);

    // Beard
    final beardPaint = Paint()..color = const Color(0xFF212121)..style = PaintingStyle.fill;
    final beardPath = Path()
      ..moveTo(w * 0.22, h * 0.55)
      ..quadraticBezierTo(w * 0.5, h * 0.78, w * 0.78, h * 0.55)
      ..quadraticBezierTo(w * 0.5, h * 0.52, w * 0.22, h * 0.55)
      ..close();
    canvas.drawPath(beardPath, beardPaint);

    // Smile
    final smilePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.52), width: 10, height: 8),
      0.1, 2.94, false, smilePaint,
    );

    // Hat Top
    final hatPaint = Paint()..color = const Color(0xFFE0A96D)..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.36), width: w * 0.46, height: h * 0.28),
      3.14, 3.14, true, hatPaint,
    );

    // Hat Brim
    final brimPath = Path()
      ..moveTo(w * 0.1, h * 0.36)
      ..quadraticBezierTo(w * 0.5, h * 0.28, w * 0.9, h * 0.36)
      ..quadraticBezierTo(w * 0.5, h * 0.44, w * 0.1, h * 0.36)
      ..close();
    canvas.drawPath(brimPath, hatPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
