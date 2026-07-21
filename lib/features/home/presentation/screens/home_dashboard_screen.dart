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
          'Your request to withdraw ₦245,000 to GTBank (**** 2188) is processing. Payout will settle instantly.',
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Custom App Bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good Morning 👋',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Musa Ibrahim',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              'Kaduna Farmers Cooperative',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10, color: Colors.grey[500]),
                            const SizedBox(width: 2),
                            Text(
                              'Kaduna, Nigeria',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Notification Bell with Badge
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Color(0xFF1E293B), size: 24),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                            );
                          },
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32), // Green dot indicator
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 2. Today's Earnings Card
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Backdrop dark green container
                      Container(
                        color: const Color(0xFF1B3D22),
                      ),
                      // Rolling hills & Wheat stem Custom Painter
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _WheatCardPainter(),
                        ),
                      ),
                      // Content overlay
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Today\'s Earnings',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Text(
                                  _hideEarnings ? '₦ ••••••' : '₦245,000',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            
                            // Earnings growth indicator pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.arrow_upward, color: Color(0xFF81C784), size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    '+12% vs Yesterday',
                                    style: TextStyle(
                                      color: Color(0xFF81C784),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Stats Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Today\'s Deliveries',
                                        style: TextStyle(color: Colors.white60, fontSize: 8, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _hideEarnings ? '•' : '3',
                                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 25,
                                  color: Colors.white24,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Pending Payment',
                                        style: TextStyle(color: Colors.white60, fontSize: 8, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _hideEarnings ? '₦ •••' : '₦85,000',
                                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Gold Receive Payment CTA button
                            GestureDetector(
                              onTap: _showWithdrawDialog,
                              child: Container(
                                width: double.infinity,
                                height: 42,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFF0C265), Color(0xFFE29A26)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Row(
                                        children: [
                                          Icon(Icons.credit_card, color: Color(0xFF1B3D22), size: 16),
                                          SizedBox(width: 8),
                                          Text(
                                            'Receive Payment',
                                            style: TextStyle(
                                              color: Color(0xFF1B3D22),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.chevron_right, color: Color(0xFF1B3D22), size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // 3. Four Quick Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    icon: Icons.local_shipping,
                    label: 'My Deliveries',
                    iconColor: const Color(0xFF2E7D32),
                    bgColor: const Color(0xFFE8F5E9),
                    onTap: () => widget.onNavigateToTab(1),
                  ),
                  _buildQuickAction(
                    icon: Icons.monetization_on,
                    label: 'Payments',
                    iconColor: const Color(0xFFE29A26),
                    bgColor: const Color(0xFFFFF8E1),
                    onTap: () => widget.onNavigateToTab(2),
                  ),
                  _buildQuickAction(
                    icon: Icons.receipt_long,
                    label: 'Receipts',
                    iconColor: const Color(0xFF2E7D32),
                    bgColor: const Color(0xFFE8F5E9),
                    onTap: () => widget.onNavigateToTab(2),
                  ),
                  _buildQuickAction(
                    icon: Icons.headset_mic,
                    label: 'Support',
                    iconColor: const Color(0xFFE75A1E),
                    bgColor: const Color(0xFFFBE9E7),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 4. Active Delivery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Active Delivery',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                ],
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Maize image (using Graphic custom paint)
                        Container(
                          width: 60,
                          height: 60,
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
                        const SizedBox(width: 12),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '🌽 Maize',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Buyer: ABC Agro Ltd',
                                style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 1),
                              Row(
                                children: [
                                  Text(
                                    'Weight: 2,500 kg',
                                    style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Price: ₦450/kg',
                                    style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Expected Payment',
                                style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '₦1,125,000',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Awaiting Buyer Confirmation',
                            style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE65100),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F1EF)),

                    // Step Tracker
                    Row(
                      children: [
                        _buildTrackerStep('Harvested', true, Icons.check_circle),
                        _buildTrackerLine(true),
                        _buildTrackerStep('Delivered', true, Icons.local_shipping),
                        _buildTrackerLine(true),
                        _buildTrackerStep('Confirmed', false, Icons.hourglass_top, isAmber: true),
                        _buildTrackerLine(false),
                        _buildTrackerStep('Paid', false, Icons.account_balance_wallet),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward, size: 12),
                        label: const Text('Track Delivery', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B3D22),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. Two-column dashboard row 1 (Recent Payments + Produce Summary)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Recent Payments
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Recent Payments',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text('View All', style: TextStyle(fontSize: 9, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E2DF)),
                          ),
                          child: Column(
                            children: [
                              _buildMiniPaymentItem(
                                title: 'Payment Received',
                                sub: 'Completed • Today',
                                ref: 'Ref: FGP293923',
                                amount: '+₦145,000',
                                isCompleted: true,
                              ),
                              const Divider(height: 16),
                              _buildMiniPaymentItem(
                                title: 'Settlement Pending',
                                sub: 'Buyer Confirmation Pending',
                                ref: '',
                                amount: '₦85,000',
                                isCompleted: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Right: Produce Summary
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Produce Summary',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text('View All', style: TextStyle(fontSize: 9, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildProduceItemCard('🌽 Maize', '5.2 Tons'),
                              const SizedBox(width: 8),
                              _buildProduceItemCard('🌾 Rice', '3.6 Tons'),
                              const SizedBox(width: 8),
                              _buildProduceItemCard('🥜 Groundnut', '1.4 Tons'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 6. Two-column dashboard row 2 (This Month Performance + Notifications)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: This Month Performance
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'This Month Performance',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E2DF)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildPerformanceStat('Total Earnings', '₦2.45M'),
                                  _buildPerformanceStat('Deliveries', '24'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildPerformanceStat('Buyers', '6'),
                                  _buildPerformanceStat('Success Rate', '100%'),
                                ],
                              ),
                              const Divider(height: 16),
                              SizedBox(
                                height: 75,
                                width: double.infinity,
                                child: CustomPaint(
                                  painter: _LineChartPainter(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Right: Notifications
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Notifications',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text('View All', style: TextStyle(fontSize: 9, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E2DF)),
                          ),
                          child: Column(
                            children: [
                              _buildNotificationItem('Payment Received', 'ABC Agro paid ₦145,000', '2m ago', Icons.check_circle_outline, const Color(0xFF2E7D32)),
                              const Divider(height: 12),
                              _buildNotificationItem('Delivery Confirmed', 'Maize Delivery, Buyer confirmed.', '15m ago', Icons.local_shipping_outlined, const Color(0xFF1565C0)),
                              const Divider(height: 12),
                              _buildNotificationItem('Cooperative Notice', 'Meeting Tomorrow', '1h ago', Icons.campaign_outlined, const Color(0xFFE29A26)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 7. Bottom Promotional Row (Harvest Tip + Financing)
              Row(
                children: [
                  // Left Promo: Harvest Tip
                  Expanded(
                    child: Container(
                      height: 125,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFC8E6C9)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            bottom: -10,
                            width: 65,
                            height: 65,
                            child: CustomPaint(
                              painter: _SiloIllustrationPainter(),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E7D32),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Harvest Tip',
                                  style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Store maize in dry conditions to prevent mold.',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B3D22),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Right Promo: Financing
                  Expanded(
                    child: Container(
                      height: 125,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFFECB3)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            bottom: -15,
                            width: 65,
                            height: 65,
                            child: CustomPaint(
                              painter: _TractorIllustrationPainter(),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Need Farm Financing?',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE65100),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'You qualify for\n₦500,000',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3E2723),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  minimumSize: Size.zero,
                                  elevation: 0,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text(
                                  'Apply Now →',
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Action card builder
  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E2DF)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step Tracker builder elements
  Widget _buildTrackerStep(String label, bool isDone, IconData icon, {bool isAmber = false}) {
    Color col = isDone
        ? const Color(0xFF2E7D32)
        : isAmber
            ? const Color(0xFFE29A26)
            : const Color(0xFFBBBBBB);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: col.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(color: col, width: 1.5),
          ),
          child: Icon(icon, color: col, size: 10),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 7.5,
            fontWeight: isDone || isAmber ? FontWeight.bold : FontWeight.normal,
            color: col,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackerLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? const Color(0xFF2E7D32) : const Color(0xFFEDE8E0),
      ),
    );
  }

  // Mini Payment Item card builder
  Widget _buildMiniPaymentItem({
    required String title,
    required String sub,
    required String ref,
    required String amount,
    required bool isCompleted,
  }) {
    Color statusCol = isCompleted ? const Color(0xFF2E7D32) : const Color(0xFFE65100);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: statusCol.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.arrow_downward : Icons.access_time,
            color: statusCol,
            size: 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 1),
              Text(
                sub,
                style: const TextStyle(fontSize: 7.5, color: Colors.grey),
              ),
              if (ref.isNotEmpty) ...[
                const SizedBox(height: 1),
                Text(
                  ref,
                  style: const TextStyle(fontSize: 7.5, color: Colors.grey, fontFamily: 'monospace'),
                ),
              ]
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isCompleted ? const Color(0xFF2E7D32) : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: statusCol.withOpacity(0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isCompleted ? 'Completed' : 'Pending',
                style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold, color: statusCol),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Produce Summary card builder
  Widget _buildProduceItemCard(String crop, String weight) {
    return Container(
      width: 76,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crop thumbnail graphic representation
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                crop.split(' ').first,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            crop,
            style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Delivered',
            style: TextStyle(fontSize: 7, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            weight,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
          ),
        ],
      ),
    );
  }

  // Performance stats element builder
  Widget _buildPerformanceStat(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 7.5, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 1),
        Text(
          val,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
        ),
      ],
    );
  }

  // Notification item builder
  Widget _buildNotificationItem(String title, String desc, String time, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 12),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 1),
              Text(
                desc,
                style: const TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(fontSize: 7, color: Colors.grey),
        ),
      ],
    );
  }
}

// Custom painter for rolling hills and wheat graphic on hero card
class _WheatCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    // Rolling hills path 1 (lighter/background hill)
    final hillPaint1 = Paint()
      ..color = const Color(0xFF14301B)
      ..style = PaintingStyle.fill;
      
    final hillPath1 = Path()
      ..moveTo(0, h)
      ..quadraticBezierTo(w * 0.25, h * 0.55, w * 0.55, h * 0.7)
      ..quadraticBezierTo(w * 0.8, h * 0.82, w, h * 0.65)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(hillPath1, hillPaint1);
    
    // Rolling hills path 2 (darker/foreground hill)
    final hillPaint2 = Paint()
      ..color = const Color(0xFF0F2615)
      ..style = PaintingStyle.fill;
      
    final hillPath2 = Path()
      ..moveTo(0, h)
      ..quadraticBezierTo(w * 0.35, h * 0.72, w * 0.68, h * 0.6)
      ..quadraticBezierTo(w * 0.85, h * 0.52, w, h * 0.5)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(hillPath2, hillPaint2);

    // Gold Wheat Stem on the right side
    final wheatPaint = Paint()
      ..color = const Color(0xFFF0C265)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
      
    // Primary stem
    final stem = Path()
      ..moveTo(w * 0.82, h)
      ..cubicTo(w * 0.80, h * 0.65, w * 0.78, h * 0.35, w * 0.70, h * 0.15);
    canvas.drawPath(stem, wheatPaint);
    
    // Secondary stem
    final stem2 = Path()
      ..moveTo(w * 0.88, h)
      ..cubicTo(w * 0.87, h * 0.7, w * 0.86, h * 0.45, w * 0.83, h * 0.25);
    canvas.drawPath(stem2, wheatPaint);
    
    final kernelPaint = Paint()
      ..color = const Color(0xFFF0C265)
      ..style = PaintingStyle.fill;
      
    // Kernel drawing helper
    void drawKernel(double cx, double cy, double angle) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angle);
      
      // Draw oval kernel
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 6, height: 12),
        kernelPaint,
      );
      
      // Draw kernel hair/beard
      final beardPaint = Paint()
        ..color = const Color(0xFFF0C265)
        ..strokeWidth = 0.6
        ..style = PaintingStyle.stroke;
      canvas.drawLine(const Offset(0, -6), const Offset(0, -16), beardPaint);
      
      canvas.restore();
    }
    
    // Kernels for primary stem
    drawKernel(w * 0.70, h * 0.16, 0.1);
    drawKernel(w * 0.71, h * 0.21, -0.4);
    drawKernel(w * 0.72, h * 0.25, 0.4);
    drawKernel(w * 0.73, h * 0.29, -0.4);
    drawKernel(w * 0.74, h * 0.33, 0.4);
    drawKernel(w * 0.75, h * 0.37, -0.4);
    drawKernel(w * 0.76, h * 0.41, 0.4);
    drawKernel(w * 0.77, h * 0.45, -0.4);
    
    // Kernels for secondary stem
    drawKernel(w * 0.83, h * 0.26, 0.15);
    drawKernel(w * 0.84, h * 0.30, -0.35);
    drawKernel(w * 0.85, h * 0.34, 0.35);
    drawKernel(w * 0.86, h * 0.38, -0.35);
    drawKernel(w * 0.87, h * 0.42, 0.35);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for line performance graph
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Horizontal grid line
    final gridPaint = Paint()
      ..color = const Color(0xFFEDE8E0)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), gridPaint);

    final points = [
      Offset(w * 0.05, h * 0.85),
      Offset(w * 0.20, h * 0.75),
      Offset(w * 0.35, h * 0.78),
      Offset(w * 0.50, h * 0.62),
      Offset(w * 0.65, h * 0.68),
      Offset(w * 0.80, h * 0.44),
      Offset(w * 0.95, h * 0.30),
    ];

    // Connect line
    final linePaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);

    // Gradient below performance line
    final areaPath = Path()
      ..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      areaPath.lineTo(points[i].dx, points[i].dy);
    }
    areaPath.lineTo(points.last.dx, h);
    areaPath.lineTo(points.first.dx, h);
    areaPath.close();

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF2E7D32).withOpacity(0.18),
          const Color(0xFF2E7D32).withOpacity(0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, w, h))
      ..style = PaintingStyle.fill;

    canvas.drawPath(areaPath, gradientPaint);

    // Interactive circular nodes
    final dotPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
    final dotOutlinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (var pt in points) {
      canvas.drawCircle(pt, 3.2, dotPaint);
      canvas.drawCircle(pt, 3.2, dotOutlinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for vector grain silo illustration
class _SiloIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Dome roof (red)
    final domePaint = Paint()..color = const Color(0xFFD84315)..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromLTRB(w * 0.2, h * 0.25, w * 0.7, h * 0.55),
      3.14, 3.14, true, domePaint,
    );

    // Silo tower body
    final siloPaint = Paint()..color = const Color(0xFFBCAAA4)..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(w * 0.22, h * 0.4, w * 0.68, h * 0.85), siloPaint);

    // Silo base
    final basePaint = Paint()..color = const Color(0xFF795548)..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(w * 0.18, h * 0.85, w * 0.72, h * 0.95), basePaint);

    // Little round window
    final windowPaint = Paint()..color = const Color(0xFF3E2723)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.45, h * 0.52), 4, windowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for vector tractor illustration
class _TractorIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Field line
    final fieldPaint = Paint()
      ..color = const Color(0xFFC8E6C9)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, h * 0.88), Offset(w, h * 0.88), fieldPaint);

    // Tractor body (Green)
    final tractorPaint = Paint()..color = const Color(0xFF2E7D32)..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(w * 0.3, h * 0.45, w * 0.7, h * 0.75), tractorPaint);

    // Cabin frame
    final cabinPaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTRB(w * 0.4, h * 0.25, w * 0.65, h * 0.45), cabinPaint);

    // Exhaust pipe stack
    final exhaustPaint = Paint()..color = Colors.black87..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(w * 0.68, h * 0.32, w * 0.70, h * 0.45), exhaustPaint);

    // Big Rear Wheel (black)
    final wheelPaint = Paint()..color = Colors.black87..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.38, h * 0.76), 14, wheelPaint);

    // Small Front Wheel
    canvas.drawCircle(Offset(w * 0.68, h * 0.79), 8, wheelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for vector corn icon
class _MaizeGraphicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.5);

    // Yellow Cob body
    final cobPaint = Paint()..color = const Color(0xFFFFD54F)..style = PaintingStyle.fill;
    final cobRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 16, height: 35),
      const Radius.circular(8),
    );
    canvas.drawRRect(cobRect, cobPaint);

    // Draw little kernels details
    final kernelPaint = Paint()..color = const Color(0xFFFFB300)..style = PaintingStyle.fill;
    for (double y = h * 0.28; y < h * 0.72; y += 6) {
      canvas.drawCircle(Offset(w * 0.44, y), 1.5, kernelPaint);
      canvas.drawCircle(Offset(w * 0.50, y), 2.0, kernelPaint);
      canvas.drawCircle(Offset(w * 0.56, y), 1.5, kernelPaint);
    }

    // Left Leaf (green wrapper)
    final leafPaint = Paint()..color = const Color(0xFF4CAF50)..style = PaintingStyle.fill;
    final leftLeaf = Path()
      ..moveTo(w * 0.36, h * 0.75)
      ..cubicTo(w * 0.22, h * 0.58, w * 0.32, h * 0.32, w * 0.46, h * 0.42)
      ..quadraticBezierTo(w * 0.42, h * 0.6, w * 0.46, h * 0.75)
      ..close();
    canvas.drawPath(leftLeaf, leafPaint);

    // Right Leaf
    final rightLeaf = Path()
      ..moveTo(w * 0.64, h * 0.75)
      ..cubicTo(w * 0.78, h * 0.58, w * 0.68, h * 0.32, w * 0.54, h * 0.42)
      ..quadraticBezierTo(w * 0.58, h * 0.6, w * 0.54, h * 0.75)
      ..close();
    canvas.drawPath(rightLeaf, leafPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
