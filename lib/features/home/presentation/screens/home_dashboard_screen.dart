import 'package:flutter/material.dart';
import 'notifications_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  final Function(int) onNavigateToTab;

  const HomeDashboardScreen({super.key, required this.onNavigateToTab});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  bool _hideEarnings = false;
  String _selectedCrop = 'Maize';

  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.account_balance_wallet, color: Color(0xFF2E7D32)),
            SizedBox(width: 10),
            Text('Withdraw Funds'),
          ],
        ),
        content: const Text(
          'Your request to withdraw ₦145,000 to GTBank (**** 2188) is processing. Payout will settle instantly.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Hamburger Menu
                    IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF333333), size: 28),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 4),
                    // Greetings Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Text(
                                'Hello, Musa ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              Text('👋', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Good morning! Let\'s grow together.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF888888),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Notification Bell with Badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Color(0xFF333333), size: 28),
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
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE75A1E), // Orange badge
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // User Profile Circular Avatar
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2E7D32), width: 1.5),
                      ),
                      child: ClipOval(
                        child: CustomPaint(
                          painter: _MiniFarmerAvatarPainter(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Today's Earnings Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Backdrop sunset field image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/splash_bg.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Gradient overlay for text contrast
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.15),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Today\'s Earnings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _hideEarnings = !_hideEarnings;
                                    });
                                  },
                                  child: Icon(
                                    _hideEarnings ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _hideEarnings ? '₦ ••••••' : '₦145,000',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Icon(Icons.arrow_upward, color: Color(0xFF81C784), size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      '12% from yesterday',
                                      style: TextStyle(
                                        color: Color(0xFF81C784),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // Receive Payment CTA
                                InkWell(
                                  onTap: _showWithdrawDialog,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E7D32),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.account_balance_wallet, color: Colors.white, size: 16),
                                        SizedBox(width: 8),
                                        Text(
                                          'Receive Payment',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Circular Arrow Button
                                InkWell(
                                  onTap: () => widget.onNavigateToTab(2), // Switches to Ledger tab
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.arrow_forward, color: Color(0xFF2E7D32), size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildStatCard(
                      icon: Icons.local_shipping,
                      iconBg: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                      value: '2',
                      label: 'Today\'s Deliveries',
                      subLabel: 'Active shipments',
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      icon: Icons.hourglass_empty,
                      iconBg: const Color(0xFFFFF3E0),
                      iconColor: const Color(0xFFE65100),
                      value: '₦80,000',
                      label: 'Pending Payment',
                      subLabel: 'In Escrow',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Quick Actions
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
              ),
              const SizedBox(height: 12),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      icon: Icons.local_shipping_outlined,
                      label: 'Deliveries',
                      onTap: () => widget.onNavigateToTab(1), // Navigates to Deliveries Tab
                    ),
                    _buildActionButton(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Payments',
                      onTap: () => widget.onNavigateToTab(2), // Navigates to Payments Tab
                    ),
                    _buildActionButton(
                      icon: Icons.trending_up_outlined,
                      label: 'Analytics',
                      onTap: () => widget.onNavigateToTab(3), // Navigates to Analytics Tab
                    ),
                    _buildActionButton(
                      icon: Icons.help_outline,
                      label: 'Support',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('FarmGate Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                const Text('Need help with a delivery, escrow payout, or scale verification? Contact our support line.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                const SizedBox(height: 16),
                                ListTile(
                                  leading: const Icon(Icons.phone, color: Color(0xFF2E7D32)),
                                  title: const Text('Call Agent (+234 800 FARMGATE)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.chat_bubble_outline, color: Color(0xFF2E7D32)),
                                  title: const Text('WhatsApp Support Chat', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. My Deliveries (Crops)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My Deliveries',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
              ),
              const SizedBox(height: 12),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildCropCircle(name: 'Maize', emoji: '🌽'),
                    const SizedBox(width: 12),
                    _buildCropCircle(name: 'Rice', emoji: '🌾'),
                    const SizedBox(width: 12),
                    _buildCropCircle(name: 'Groundnut', emoji: '🥜'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 6. Active Delivery Card
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Active Delivery',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: [
                    // Maize Circular Visual
                    Container(
                      width: 76,
                      height: 76,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFFDE7),
                      ),
                      child: ClipOval(
                        child: CustomPaint(
                          painter: _MaizeGraphicPainter(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3E0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.hourglass_empty, color: Color(0xFFE65100), size: 10),
                                    SizedBox(width: 4),
                                    Text(
                                      'Pending Confirmation',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFE65100),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Maize',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          const Text(
                            '2,500 kg',
                            style: TextStyle(fontSize: 12, color: Color(0xFF777777), fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildMiniDetail(label: 'Buyer', value: 'ABC Agro Ltd'),
                              _buildMiniDetail(label: 'Price / kg', value: '₦450'),
                              _buildMiniDetail(
                                label: 'Expected Payment',
                                value: '₦1,125,000',
                                valueColor: const Color(0xFF2E7D32),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 7. Recent Transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    // Item 1
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_downward, color: Color(0xFF2E7D32), size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Payment Received',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'From ABC Agro Ltd • Today, 8:45 AM',
                                style: TextStyle(fontSize: 9, color: Color(0xFF777777)),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '+₦145,000',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: Color(0xFFF1F1EF)),
                    // Item 2
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_downward, color: Color(0xFF2E7D32), size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Payment Received',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'From Kaduna Coop • Yesterday, 4:15 PM',
                                style: TextStyle(fontSize: 9, color: Color(0xFF777777)),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '+₦320,000',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
    required String subLabel,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 9, color: Color(0xFF888888), fontWeight: FontWeight.w600),
          ),
          Text(
            subLabel,
            style: const TextStyle(fontSize: 8, color: Color(0xFFBBBBBB), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 72,
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF2E7D32), size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF333333), height: 1.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCropCircle({required String name, required String emoji, bool isAddButton = false}) {
    bool isSelected = _selectedCrop == name;
    return GestureDetector(
      onTap: isAddButton
          ? null
          : () {
              setState(() {
                _selectedCrop = name;
              });
            },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFFF7F7F5),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: isAddButton ? 20 : 24, color: isAddButton ? const Color(0xFF2E7D32) : null),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniDetail({required String label, required String value, Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 8, color: Color(0xFF999999), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: valueColor ?? const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}

/// A mini painter that draws the smiling farmer in a hat for the circular profile avatar
class _MiniFarmerAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Face skin
    final facePaint = Paint()..color = const Color(0xFF5D4037)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.24, facePaint);

    // Beard
    final beardPaint = Paint()..color = const Color(0xFF212121)..style = PaintingStyle.fill;
    final beardPath = Path()
      ..moveTo(w * 0.3, h * 0.55)
      ..quadraticBezierTo(w * 0.5, h * 0.76, w * 0.7, h * 0.55)
      ..quadraticBezierTo(w * 0.5, h * 0.52, w * 0.3, h * 0.55)
      ..close();
    canvas.drawPath(beardPath, beardPaint);

    // Smile
    final smilePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.52), width: 8, height: 6),
      0.1, 2.94, false, smilePaint,
    );

    // Hat Top
    final hatPaint = Paint()..color = const Color(0xFFE0A96D)..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.38), width: w * 0.44, height: h * 0.26),
      3.14, 3.14, true, hatPaint,
    );

    // Hat Brim
    final brimPath = Path()
      ..moveTo(w * 0.15, h * 0.38)
      ..quadraticBezierTo(w * 0.5, h * 0.32, w * 0.85, h * 0.38)
      ..quadraticBezierTo(w * 0.5, h * 0.44, w * 0.15, h * 0.38)
      ..close();
    canvas.drawPath(brimPath, hatPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A custom painter that draws a vector corn graphic
class _MaizeGraphicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.5);

    // Yellow Cob body
    final cobPaint = Paint()..color = const Color(0xFFFFD54F)..style = PaintingStyle.fill;
    final cobRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 20, height: 45),
      const Radius.circular(10),
    );
    canvas.drawRRect(cobRect, cobPaint);

    // Draw little kernels details
    final kernelPaint = Paint()..color = const Color(0xFFFFB300)..style = PaintingStyle.fill;
    for (double y = h * 0.25; y < h * 0.75; y += 8) {
      canvas.drawCircle(Offset(w * 0.42, y), 2, kernelPaint);
      canvas.drawCircle(Offset(w * 0.50, y), 2.5, kernelPaint);
      canvas.drawCircle(Offset(w * 0.58, y), 2, kernelPaint);
    }

    // Left Leaf (green wrapper)
    final leafPaint = Paint()..color = const Color(0xFF4CAF50)..style = PaintingStyle.fill;
    final leftLeaf = Path()
      ..moveTo(w * 0.35, h * 0.75)
      ..cubicTo(w * 0.2, h * 0.55, w * 0.3, h * 0.3, w * 0.45, h * 0.4)
      ..quadraticBezierTo(w * 0.42, h * 0.6, w * 0.45, h * 0.75)
      ..close();
    canvas.drawPath(leftLeaf, leafPaint);

    // Right Leaf
    final rightLeaf = Path()
      ..moveTo(w * 0.65, h * 0.75)
      ..cubicTo(w * 0.8, h * 0.55, w * 0.7, h * 0.3, w * 0.55, h * 0.4)
      ..quadraticBezierTo(w * 0.58, h * 0.6, w * 0.55, h * 0.75)
      ..close();
    canvas.drawPath(rightLeaf, leafPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
