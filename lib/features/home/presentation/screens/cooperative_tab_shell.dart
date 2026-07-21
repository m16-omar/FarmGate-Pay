import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'dashboard_screen.dart'; // Import real-time payout ledger screen
import '../../../onboarding/presentation/screens/welcome_screen.dart';
import '../../../onboarding/presentation/screens/role_selection_screen.dart';

class CooperativeTabShell extends StatefulWidget {
  const CooperativeTabShell({super.key});

  @override
  State<CooperativeTabShell> createState() => _CooperativeTabShellState();
}

class _CooperativeTabShellState extends State<CooperativeTabShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      CooperativeDashboardScreen(onNavigate: (index) {
        setState(() {
          _currentIndex = index;
        });
      }),
      const CooperativeMembersScreen(),
      const CooperativeDeliveriesScreen(),
      const CooperativeReportsScreen(),
      const CooperativeProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E7D32), // Highlight active tab in green
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Farmers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping),
            label: 'Deliveries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// 1. Cooperative Dashboard Screen
class CooperativeDashboardScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const CooperativeDashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0), // Soft Cream background
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Top Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Good Morning 👋',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Kaduna Farmers Cooperative',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Manager: Ibrahim Musa',
                          style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '📍 Kaduna, Nigeria',
                          style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none, color: Color(0xFF222222)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Hero Card
              Container(
                width: double.infinity,
                height: 220,
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
                      Container(color: const Color(0xFF1B3D22)), // Primary dark green base
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _CoopHeroPainter(), // Illustrates warehouse & farmers
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Today\'s Settlements',
                                  style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '₦8,450,000',
                                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Today\'s Deliveries', style: TextStyle(color: Colors.white60, fontSize: 9)),
                                    SizedBox(height: 2),
                                    Text('42', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Active Farmers', style: TextStyle(color: Colors.white60, fontSize: 9)),
                                    SizedBox(height: 2),
                                    Text('286', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () => onNavigate(3), // Swaps to Reports tab
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD4A017), // Gold accent
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    elevation: 0,
                                  ),
                                  child: const Text('View Reports', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(
                                  onPressed: () => onNavigate(1), // Swaps to Farmers tab
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.white60),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text('Manage Farmers', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickActionCard('👨🏾🌾', 'Farmers', () => onNavigate(1)),
                  _buildQuickActionCard('🚚', 'Deliveries', () => onNavigate(2)),
                  _buildQuickActionCard('💰', 'Settlements', () => onNavigate(3)),
                  _buildQuickActionCard('📊', 'Reports', () => onNavigate(3)),
                ],
              ),
              const SizedBox(height: 24),

              // Today's Overview
              const Text(
                'Today\'s Overview',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.2,
                children: [
                  _buildOverviewCard('Total Farmers', '286', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                  _buildOverviewCard('Active Today', '134', const Color(0xFFE3F2FD), const Color(0xFF1565C0)),
                  _buildOverviewCard('Paid Today', '119', const Color(0xFFFFF8E1), const Color(0xFFD4A017)),
                  _buildOverviewCard('Pending Payments', '15', const Color(0xFFFBE9E7), const Color(0xFFE75A1E)),
                ],
              ),
              const SizedBox(height: 24),

              // Deliveries Requiring Attention
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Deliveries Requiring Attention',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                ],
              ),
              const SizedBox(height: 12),
              _buildAttentionDeliveryCard(
                farmer: 'Musa Ibrahim',
                crop: 'Maize',
                cropEmoji: '🌽',
                weight: '2,500 kg',
                buyer: 'ABC Agro Ltd',
                value: '₦1,125,000',
                status: 'Awaiting Buyer Confirmation',
                statusColor: const Color(0xFFE29A26),
                progress: 0.75,
              ),
              const SizedBox(height: 12),
              _buildAttentionDeliveryCard(
                farmer: 'Amina Yusuf',
                crop: 'Rice',
                cropEmoji: '🌾',
                weight: '1,800 kg',
                buyer: 'Northern Foods Ltd',
                value: '₦810,000',
                status: 'Settlement Processing',
                statusColor: const Color(0xFF1565C0),
                progress: 0.50,
              ),
              const SizedBox(height: 24),

              // Settlement Summary
              const Text(
                'Settlement Summary',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Today\'s Payments', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text('₦8,450,000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF222222))),
                          const SizedBox(height: 16),
                          _buildSummaryRow('Completed', '₦7,980,000', const Color(0xFF2E7D32)),
                          const SizedBox(height: 8),
                          _buildSummaryRow('Pending', '₦470,000', const Color(0xFFE75A1E)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: CustomPaint(
                        painter: _DoughnutChartPainter(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Top Performing Farmers
              const Text(
                'Top Performing Farmers',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPerformerCard('👨🏾🌾', 'Musa Ibrahim', '₦2.4M Earned', '12 Deliveries', '4.9 ⭐', 'Rank #1'),
                    const SizedBox(width: 10),
                    _buildPerformerCard('👩🏾🌾', 'Amina Yusuf', '₦1.8M Earned', '9 Deliveries', '4.8 ⭐', 'Rank #2'),
                    const SizedBox(width: 10),
                    _buildPerformerCard('👨🏾🌾', 'Abdullahi Bello', '₦1.5M Earned', '8 Deliveries', '4.7 ⭐', 'Rank #3'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Produce Summary
              const Text(
                'Produce Summary',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildProduceSummaryCard('🌽', 'Maize', '32 Tons'),
                    const SizedBox(width: 10),
                    _buildProduceSummaryCard('🌾', 'Rice', '18 Tons'),
                    const SizedBox(width: 10),
                    _buildProduceSummaryCard('🍅', 'Tomatoes', '10 Tons'),
                    const SizedBox(width: 10),
                    _buildProduceSummaryCard('🥜', 'Groundnut', '8 Tons'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Cooperative Performance
              const Text(
                'Cooperative Performance',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPerformanceKPI('Monthly Settlement', '₦185M'),
                        _buildPerformanceKPI('Deliveries Logged', '680'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPerformanceKPI('Avg. Settlement', '1m 38s'),
                        _buildPerformanceKPI('Farmer Satisfaction', '98%'),
                      ],
                    ),
                    const Divider(height: 24),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _PerformanceLineChartPainter(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recent Activities
              const Text(
                'Recent Activities',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    _buildActivityTimelineItem('✅', 'Musa Ibrahim received ₦450,000', '10 mins ago'),
                    const Divider(height: 16),
                    _buildActivityTimelineItem('🚚', 'Delivery Confirmed - Rice Delivery', '30 mins ago'),
                    const Divider(height: 16),
                    _buildActivityTimelineItem('👨🏾🌾', 'New Farmer Registered: Abu Sani', '1 hour ago'),
                    const Divider(height: 16),
                    _buildActivityTimelineItem('🏦', 'Buyer Funded Escrow Wallet (₦5M)', '2 hours ago'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Notifications
              const Text(
                'Cooperative Notices',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
              ),
              const SizedBox(height: 12),
              _buildNotificationBanner('📢', 'Meeting Reminder', 'Monthly cooperative meeting tomorrow at 10 AM.'),
              const SizedBox(height: 10),
              _buildNotificationBanner('⚠', 'Confirmation Pending', '15 Deliveries Awaiting Confirmation from Buyers.'),
              const SizedBox(height: 10),
              _buildNotificationBanner('💰', 'Settlement Completed', 'ABC Agro paid 12 farmers successfully.'),
              const SizedBox(height: 24),

              // Insights Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFBBDEFB)),
                ),
                child: Row(
                  children: [
                    const Text('📈', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Performance Insight', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                          SizedBox(height: 4),
                          Text(
                            'This cooperative increased settlements by 24% compared to last week.',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Promotional Banner
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grow Your Cooperative',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Access financing, bulk purchasing, and digital tools to support more farmers.',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A017),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: const Text('Learn More →', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                    )
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

  Widget _buildQuickActionCard(String emoji, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFF222222))),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String label, String value, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textCol),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildAttentionDeliveryCard({
    required String farmer,
    required String crop,
    required String cropEmoji,
    required String weight,
    required String buyer,
    required String value,
    required String status,
    required Color statusColor,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(color: Color(0xFFFAF7F0), shape: BoxShape.circle),
                child: const Center(child: Text('👨🏾🌾', style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(farmer, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('$cropEmoji $crop • Weight: $weight', style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
                    const SizedBox(height: 1),
                    Text('Buyer: $buyer', style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: statusColor),
                    ),
                  ),
                ],
              )
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Settlement Progress: ', style: TextStyle(fontSize: 8.5, color: Colors.grey)),
                  Text('${(progress * 100).toInt()}%', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: statusColor)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: Size.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('View →', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String val, Color dotCol) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: dotCol, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF222222))),
      ],
    );
  }

  Widget _buildPerformerCard(String emoji, String name, String earned, String deliveries, String rating, String rank) {
    return Container(
      width: 125,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(rank, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFFD4A017))),
              Text(rating, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 6),
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(earned, style: const TextStyle(fontSize: 10, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
          Text(deliveries, style: const TextStyle(fontSize: 8, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildProduceSummaryCard(String emoji, String crop, String weight) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(crop, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(weight, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
        ],
      ),
    );
  }

  Widget _buildPerformanceKPI(String label, String val) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(val, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
        ],
      ),
    );
  }

  Widget _buildActivityTimelineItem(String iconEmoji, String detail, String time) {
    return Row(
      children: [
        Text(iconEmoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(detail, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF222222)))),
        Text(time, style: const TextStyle(fontSize: 8.5, color: Colors.grey)),
      ],
    );
  }

  Widget _buildNotificationBanner(String emoji, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF222222))),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 9, color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 2. Cooperative Members Directory Screen
class CooperativeMembersScreen extends StatelessWidget {
  const CooperativeMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Members Directory', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Complete list of cooperative crop growers', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildMemberListItem('Musa Ibrahim', 'Maize', '2.5 Acres', 'Active', 'Kaduna'),
                    _buildMemberListItem('Amina Yusuf', 'Rice', '1.8 Acres', 'Active', 'Kaduna'),
                    _buildMemberListItem('Abdullahi Bello', 'Tomato', '0.5 Acres', 'Active', 'Kaduna'),
                    _buildMemberListItem('Abubakar Sani', 'Soybeans', '3.0 Acres', 'Pending', 'Zaria'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberListItem(String name, String crop, String acreage, String status, String region) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 2),
              Text('Crop: $crop • Area: $acreage • Region: $region', style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Active' ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: status == 'Active' ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 3. Cooperative Deliveries Screen (Monnify Ledger integrations)
class CooperativeDeliveriesScreen extends StatelessWidget {
  const CooperativeDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen(); // Connects directly to real-time Monnify payout ledger!
  }
}

// 4. Cooperative Reports Screen
class CooperativeReportsScreen extends StatelessWidget {
  const CooperativeReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Cooperative Analytics & Reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Track settlement volumes and farmer performance metrics', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 20),
              
              // Settlement Summary Doughnut Chart
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Completed Volume', style: TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
                          Text('₦7,980,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12),
                          Text('Pending Volume', style: TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
                          Text('₦470,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CustomPaint(painter: _DoughnutChartPainter()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Performance Line Graph Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Settled Volume Trend', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: CustomPaint(painter: _PerformanceLineChartPainter()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. Cooperative Profile Screen
class CooperativeProfileScreen extends StatelessWidget {
  const CooperativeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(
                radius: 36,
                backgroundColor: Color(0xFFFFF8E1),
                child: Icon(Icons.handshake, color: Color(0xFFE29A26), size: 36),
              ),
              const SizedBox(height: 12),
              const Text('Kaduna Farmers Cooperative', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('cooperative@kadunafarmers.org', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 24),
              
              // Settings list
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.swap_horiz, color: Color(0xFF2E7D32)),
                      title: const Text('Switch Active Role', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Swap to Farmer or Buyer persona', style: TextStyle(fontSize: 10)),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                          (route) => false,
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    ListTile(
                      leading: const Icon(Icons.group_outlined, color: Color(0xFF2E7D32)),
                      title: const Text('Manage Joint Sub-Ledgers', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Verify farmer payout Monnify contracts', style: TextStyle(fontSize: 10)),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Cooperative warehouse & farmers illustration on the hero card
class _CoopHeroPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw background hills
    final hillPaint = Paint()
      ..color = const Color(0xFF14301B)
      ..style = PaintingStyle.fill;
    
    final path1 = Path()
      ..moveTo(0, h)
      ..quadraticBezierTo(w * 0.3, h * 0.6, w * 0.6, h * 0.8)
      ..quadraticBezierTo(w * 0.8, h * 0.9, w, h * 0.7)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(path1, hillPaint);

    final hillPaint2 = Paint()
      ..color = const Color(0xFF0F2615)
      ..style = PaintingStyle.fill;
    final path2 = Path()
      ..moveTo(0, h)
      ..quadraticBezierTo(w * 0.4, h * 0.75, w * 0.7, h * 0.65)
      ..quadraticBezierTo(w * 0.85, h * 0.6, w, h * 0.5)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(path2, hillPaint2);

    // Draw a premium warehouse/grain silo dome illustration in gold on the right
    final warehousePaint = Paint()
      ..color = const Color(0xFFD4A017).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    // Warehouse base dome
    canvas.drawRect(Rect.fromLTRB(w * 0.72, h * 0.45, w * 0.92, h * 0.78), warehousePaint);
    
    final roofPaint = Paint()
      ..color = const Color(0xFFD4A017).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromLTRB(w * 0.70, h * 0.32, w * 0.94, h * 0.58),
      3.14, 3.14, true, roofPaint,
    );

    // Wheat stems in foreground
    final wheatPaint = Paint()
      ..color = const Color(0xFFD4A017)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(Offset(w * 0.75, h), Offset(w * 0.72, h * 0.75), wheatPaint);
    canvas.drawLine(Offset(w * 0.78, h), Offset(w * 0.76, h * 0.72), wheatPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for clean Settlement Doughnut Chart
class _DoughnutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.22;
    
    final rect = Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2));
    
    // Completed arc (Gold/Green representation)
    final completedPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Completed: 94.4% (completed: ₦7.98M / total: ₦8.45M)
    const completedAngle = 3.14 * 2 * 0.944;
    canvas.drawArc(rect, -3.14 / 2, completedAngle, false, completedPaint);
    
    // Pending arc (Orange)
    final pendingPaint = Paint()
      ..color = const Color(0xFFE75A1E)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
      
    canvas.drawArc(rect, -3.14 / 2 + completedAngle, 3.14 * 2 - completedAngle, false, pendingPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Cooperative analytics line graph
class _PerformanceLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Horizontal guide line
    final gridPaint = Paint()
      ..color = const Color(0xFFEDE8E0)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), gridPaint);

    final points = [
      Offset(w * 0.05, h * 0.8),
      Offset(w * 0.20, h * 0.65),
      Offset(w * 0.35, h * 0.7),
      Offset(w * 0.50, h * 0.5),
      Offset(w * 0.65, h * 0.55),
      Offset(w * 0.80, h * 0.35),
      Offset(w * 0.95, h * 0.25),
    ];

    // Chart line
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

    // Gradient fill under chart line
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

    // Nodes
    final dotPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
    final dotOutlinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (var pt in points) {
      canvas.drawCircle(pt, 3.0, dotPaint);
      canvas.drawCircle(pt, 3.0, dotOutlinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
