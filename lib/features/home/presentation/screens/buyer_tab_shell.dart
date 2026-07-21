import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import '../../../onboarding/presentation/screens/welcome_screen.dart';
import '../../../onboarding/presentation/screens/role_selection_screen.dart';

class BuyerTabShell extends StatefulWidget {
  const BuyerTabShell({super.key});

  @override
  State<BuyerTabShell> createState() => _BuyerTabShellState();
}

class _BuyerTabShellState extends State<BuyerTabShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BuyerDashboardScreen(
        onNavigate: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      const BuyerOrdersScreen(),
      const BuyerConfirmationsScreen(),
      const BuyerWalletScreen(),
      const BuyerProfileScreen(),
    ];
  }

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFBFBF9),
      width: MediaQuery.of(context).size.width * 0.85,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header (Avatar, Name, Verified, Close Cross Button)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFFC8E6C9),
                    child: Text('👨🏾', style: TextStyle(fontSize: 34)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Musa Abdullahi',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Buyer',
                            style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'musa.abdullahi@greenmart.com',
                          style: TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: const [
                            Icon(Icons.check_circle, size: 10, color: Color(0xFF2E7D32)),
                            SizedBox(width: 4),
                            Text('Verified Account', style: TextStyle(fontSize: 9.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F1EF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE2E2DF)),

            // Drawer Items Scroll Feed
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  // MAIN
                  const Text('MAIN', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  _buildDrawerItem(Icons.home_filled, 'Home', 0),
                  _buildDrawerItem(Icons.inventory_2_outlined, 'Orders', 1),
                  _buildDrawerItem(Icons.assignment_turned_in_outlined, 'Confirm Deliveries', 2),
                  _buildDrawerItem(Icons.account_balance_wallet_outlined, 'Wallet', 3),
                  _buildDrawerItem(Icons.grass_outlined, 'Browse Crops', null, subtitle: 'Crops browse screen coming soon'),
                  _buildDrawerItem(Icons.people_outline, 'Suppliers', null, subtitle: 'Suppliers directory coming soon'),
                  _buildDrawerItem(
                    Icons.chat_bubble_outline,
                    'Messages',
                    null,
                    subtitle: 'Direct messaging coming soon',
                    rightWidget: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
                    ),
                  ),
                  _buildDrawerItem(
                    Icons.notifications_none_outlined,
                    'Notifications',
                    null,
                    onTap: () {
                      Navigator.pop(context); // Close Drawer
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                    },
                    rightWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                      child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  _buildDrawerItem(Icons.bookmark_outline, 'Saved Items', null, subtitle: 'Bookmarks coming soon'),

                  const SizedBox(height: 20),
                  // QUICK ACCESS
                  const Text('QUICK ACCESS', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildQuickAccessCard(Icons.add_circle_outline, 'New Order', 'Place a new order', () => _navigateToTab(1))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildQuickAccessCard(Icons.local_shipping_outlined, 'Track Order', 'Track your delivery', null)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildQuickAccessCard(Icons.payment_outlined, 'Payment History', 'View your payments', () => _navigateToTab(3))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildQuickAccessCard(Icons.help_outline, 'Help Center', 'Get help & support', null)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // SUPPORT
                  const Text('SUPPORT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  _buildSupportRow(Icons.person_add_alt_1_outlined, 'Invite Team Member', 'Add your team to collaborate'),
                  _buildSupportRow(Icons.star_border_outlined, 'Rate Our App', 'Your feedback helps us improve'),
                  _buildSupportRow(Icons.share_outlined, 'Share GreenMart', 'Invite others and grow together'),

                  const SizedBox(height: 20),
                  // Upgrade to Premium Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9F2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFFE0B2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.workspace_premium, color: Colors.orange, size: 20),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Upgrade to Premium', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFE65100))),
                              SizedBox(height: 2),
                              Text('Unlock exclusive benefits and higher limits', style: TextStyle(fontSize: 8.5, color: Colors.grey)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.orange, size: 16),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Log Out
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                        (route) => false,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5F5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFFD1D1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.logout, color: Colors.red, size: 16),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Log Out', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red)),
                                SizedBox(height: 2),
                                Text('Sign out from your account', style: TextStyle(fontSize: 8.5, color: Colors.grey)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.red, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'GreenMart Buyer v1.2.0',
                      style: TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String label,
    int? targetIndex, {
    String? subtitle,
    Widget? rightWidget,
    VoidCallback? onTap,
  }) {
    bool isSelected = targetIndex != null && _currentIndex == targetIndex;
    Color bg = isSelected ? const Color(0xFFE8F5E9) : Colors.transparent;
    Color color = isSelected ? const Color(0xFF2E7D32) : const Color(0xFF333333);

    return GestureDetector(
      onTap: onTap ?? () {
        if (targetIndex != null) {
          _navigateToTab(targetIndex);
        } else if (subtitle != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(subtitle), backgroundColor: const Color(0xFF2E7D32)),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: color),
              ),
            ),
            if (rightWidget != null) rightWidget,
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 14, color: isSelected ? const Color(0xFF2E7D32) : Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(IconData icon, String title, String sub, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title details coming soon!'), backgroundColor: const Color(0xFF2E7D32)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: Center(child: Icon(icon, color: const Color(0xFF2E7D32), size: 13)),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            const SizedBox(height: 1),
            Text(sub, style: const TextStyle(fontSize: 8, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportRow(IconData icon, String title, String sub) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(color: Color(0xFFF1F1EF), shape: BoxShape.circle),
        child: Icon(icon, color: const Color(0xFF333333), size: 14),
      ),
      title: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
      subtitle: Text(sub, style: const TextStyle(fontSize: 8.5, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title clicked!'), backgroundColor: const Color(0xFF2E7D32)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildAppDrawer(context),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E7D32), // Green highlight to match bottom bar mockup screen
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
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            activeIcon: Icon(Icons.check_circle),
            label: 'Confirm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
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


// 1. Buyer Dashboard Screen (Redesigned matching mockup)
class BuyerDashboardScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const BuyerDashboardScreen({super.key, required this.onNavigate});

  @override
  State<BuyerDashboardScreen> createState() => _BuyerDashboardScreenState();
}

class _BuyerDashboardScreenState extends State<BuyerDashboardScreen> {
  double _escrowBalance = 18500000;
  double _todayPurchases = 325000;

  final List<Map<String, dynamic>> _farmerOffers = [
    {
      'crop': 'White Maize',
      'emoji': '🌽',
      'farmer': 'Musa Haruna',
      'available': 5000,
      'price': 450,
      'rating': '4.9 ⭐',
    },
    {
      'crop': 'Parboiled Rice',
      'emoji': '🌾',
      'farmer': 'Amina Yusuf',
      'available': 3500,
      'price': 480,
      'rating': '4.8 ⭐',
    },
    {
      'crop': 'Raw Groundnuts',
      'emoji': '🥜',
      'farmer': 'Fatima Umar',
      'available': 2000,
      'price': 600,
      'rating': '4.7 ⭐',
    },
  ];

  void _showPurchaseOfferDialog(Map<String, dynamic> offer) {
    final qtyController = TextEditingController(text: offer['available'].toString());
    double totalCost = ((offer['available'] as num).toDouble() * (offer['price'] as num).toDouble());

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Text('${offer['emoji']} Purchase ${offer['crop']}'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Farmer: ${offer['farmer']} • ${offer['rating']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 12),
              Text('Unit Price: ₦${offer['price']}/kg', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Sourcing Quantity (kg)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  double qty = double.tryParse(val) ?? 0.0;
                  setDialogState(() {
                    totalCost = qty * (offer['price'] as num).toDouble();
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Calculated Settlement Cost:', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
              Text(
                '₦${totalCost.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1565C0)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                double qty = double.tryParse(qtyController.text) ?? 0.0;
                if (qty <= 0) return;
                
                if (totalCost > _escrowBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient wallet balance to place purchase escrow!'), backgroundColor: Colors.red),
                  );
                  Navigator.pop(context);
                  return;
                }

                Navigator.pop(context);
                setState(() {
                  _todayPurchases += totalCost;
                  _escrowBalance -= totalCost;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sourcing contract created! ₦${totalCost.toStringAsFixed(0)} placed in Escrow.'),
                    backgroundColor: const Color(0xFF2E7D32),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
              child: const Text('Fund Escrow & Purchase', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Bar Header (Musa, Hamburger, Notification Badge, Avatar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Musa 👋',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Good morning! Ready to source fresh produce.',
                          style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                        },
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Text('👨🏾', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            // Main Content Scroll Area
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // 2. Hero Card ("Today's Purchases" with truck/produce graphic painter)
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            Container(color: const Color(0xFF1B3D22)), // Forest Green background base
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _BuyerDashboardHeroPainter(), // Illustrates vegetable baskets & truck
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
                                    children: [
                                      Row(
                                        children: const [
                                          Text(
                                            'Today\'s Purchases',
                                            style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 6),
                                          Icon(Icons.visibility_outlined, color: Colors.white70, size: 14),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₦${_todayPurchases.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: const [
                                          Icon(Icons.arrow_upward, color: Color(0xFF81C784), size: 12),
                                          SizedBox(width: 4),
                                          Text(
                                            '8% from yesterday',
                                            style: TextStyle(color: Color(0xFF81C784), fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          _showPurchaseOfferDialog(_farmerOffers[0]);
                                        },
                                        icon: const Icon(Icons.shopping_cart, size: 14),
                                        label: const Text('Place New Order', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF2E7D32),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                          elevation: 0,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.arrow_forward, color: Color(0xFF2E7D32), size: 18),
                                        ),
                                      )
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

                    // 3. Overview KPI Stats Bar
                    Row(
                      children: [
                        _buildOverviewCard('₦8,450,000', 'Total Spent', 'This Month', Icons.shopping_bag_outlined, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                        const SizedBox(width: 6),
                        _buildOverviewCard('42', 'Orders', 'This Month', Icons.inventory_2_outlined, const Color(0xFFFFF3E0), const Color(0xFFE65100)),
                        const SizedBox(width: 6),
                        _buildOverviewCard('6', 'Awaiting Delivery', 'Orders', Icons.local_shipping_outlined, const Color(0xFFFFFDE7), const Color(0xFFF57F17)),
                        const SizedBox(width: 6),
                        _buildOverviewCard('36', 'Completed', 'Orders', Icons.check_circle_outlined, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 4. Quick Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Quick Actions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        Text('See All >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuickAction('New Order', Icons.shopping_cart_outlined, () => widget.onNavigate(1)),
                        _buildQuickAction('My Orders', Icons.inventory_2_outlined, () => widget.onNavigate(1)),
                        _buildQuickAction('Browse Crops', Icons.search_outlined, () => widget.onNavigate(1)),
                        _buildQuickAction('Wallet', Icons.account_balance_wallet_outlined, () => widget.onNavigate(3)),
                        _buildQuickAction('Transactions', Icons.receipt_long_outlined, () => widget.onNavigate(3)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 5. Frequently Purchased
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Frequently Purchased', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        Text('Browse More >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFreqCropItem('🌽', 'Maize'),
                          const SizedBox(width: 12),
                          _buildFreqCropItem('🌾', 'Rice'),
                          const SizedBox(width: 12),
                          _buildFreqCropItem('🍅', 'Tomato'),
                          const SizedBox(width: 12),
                          _buildFreqCropItem('🥔', 'Yam'),
                          const SizedBox(width: 12),
                          _buildFreqCropItem('🥜', 'Groundnut'),
                          const SizedBox(width: 12),
                          _buildMoreItem(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 6. Current Order
                    const Text('Current Order', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAF7F0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CustomPaint(
                                    painter: _MaizeCardPainter(), // Paints custom maize graphics
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF3E0),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('🚚 ', style: TextStyle(fontSize: 10)),
                                          Text('On the Way', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.orange)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text('Maize', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    const Text('2,500 kg', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                height: 50,
                                child: CustomPaint(
                                  painter: _RouteMapPainter(), // Paints dotted routing track
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildMetaColumn('Supplier', 'ABC Farms'),
                              _buildMetaColumn('Price / kg', '₦450'),
                              _buildMetaColumn('Total Amount', '₦1,125,000', color: const Color(0xFF2E7D32)),
                              _buildMetaColumn('Estimated Arrival', 'Today • 4:30 PM'),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 7. Pending Confirmations
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Pending Confirmations', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        Text('View All', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFAF7F0),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CustomPaint(
                                painter: _RiceThumbnailPainter(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Rice', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                SizedBox(height: 2),
                                Text('1,200 kg • Delivered Today, 8:15 AM', style: TextStyle(fontSize: 9.5, color: Colors.grey)),
                                Text('From ABC Agro Ltd', style: TextStyle(fontSize: 9.5, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('₦540,000', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                              const SizedBox(height: 6),
                              ElevatedButton(
                                onPressed: () {
                                  widget.onNavigate(2); // Swaps to Confirm tab
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  minimumSize: Size.zero,
                                ),
                                child: const Text('Confirm Receipt', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.more_vert, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 8. Recent Payments
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Recent Payments', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        Text('View All', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8F5E9),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.check, color: Color(0xFF2E7D32), size: 16),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Payment Sent', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                SizedBox(height: 1),
                                Text('ABC Agro Ltd', style: TextStyle(fontSize: 9.5, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text('₦145,000', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                              SizedBox(height: 1),
                              Text('Today, 8:45 AM', style: TextStyle(fontSize: 8.5, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.more_vert, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String val, String title, String subtitle, IconData icon, Color bg, Color iconCol) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    val,
                    style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Center(child: Icon(icon, color: iconCol, size: 10)),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Colors.black54)),
                Text(subtitle, style: const TextStyle(fontSize: 6.5, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF2E7D32), size: 20),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 7.8, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
          ],
        ),
      ),
    );
  }

  Widget _buildFreqCropItem(String emoji, String crop) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E2DF)),
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
        ),
        const SizedBox(height: 6),
        Text(crop, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
      ],
    );
  }

  Widget _buildMoreItem() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E2DF), style: BorderStyle.solid),
          ),
          child: const Center(child: Icon(Icons.add, color: Colors.grey, size: 22)),
        ),
        const SizedBox(height: 6),
        const Text('More', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMetaColumn(String title, String val, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(
          val,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color ?? const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}

// 2. Buyer Orders Screen (Redesigned matching mockup)
class BuyerOrdersScreen extends StatefulWidget {
  const BuyerOrdersScreen({super.key});

  @override
  State<BuyerOrdersScreen> createState() => _BuyerOrdersScreenState();
}

class _BuyerOrdersScreenState extends State<BuyerOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Header (My Orders, Hamburger, Search, Bell, Avatar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Orders',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Track and manage all your orders',
                          style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Color(0xFF333333)),
                    onPressed: () {},
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Text('👨🏾', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            // TabBar Row
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF2E7D32),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF2E7D32),
                indicatorWeight: 3,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                tabs: [
                  const Tab(text: 'All Orders'),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Active'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)),
                          child: const Text('6', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Pending'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)),
                          child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  const Tab(text: 'Completed'),
                ],
              ),
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAllOrdersView(),
                  _buildAllOrdersView(), // Active Filter placeholder
                  _buildAllOrdersView(), // Pending Filter placeholder
                  _buildAllOrdersView(), // Completed Filter placeholder
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAllOrdersView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // KPI Stats row
        Row(
          children: [
            _buildStatCard('42', 'Total Orders', 'This Month', Icons.shopping_bag_outlined, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
            const SizedBox(width: 6),
            _buildStatCard('6', 'Active Orders', 'In Progress', Icons.local_shipping_outlined, const Color(0xFFFFF3E0), const Color(0xFFE65100)),
            const SizedBox(width: 6),
            _buildStatCard('3', 'Pending Orders', 'Awaiting Action', Icons.hourglass_top_outlined, const Color(0xFFFFFDE7), const Color(0xFFF57F17)),
            const SizedBox(width: 6),
            _buildStatCard('36', 'Completed', 'This Month', Icons.check_circle_outline, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
          ],
        ),
        const SizedBox(height: 24),

        // Active Orders Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Active Orders', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            Text('See All >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
          ],
        ),
        const SizedBox(height: 12),

        // Card 1: Maize
        _buildActiveOrderCard(
          crop: 'Maize',
          weight: '2,500 kg',
          value: '₦1,125,000',
          orderId: '#ORD-2024-1056',
          supplier: 'ABC Farms',
          orderDate: 'May 10, 2024',
          eta: 'Today, 4:30 PM',
          statusText: 'On the Way',
          statusColor: const Color(0xFF2E7D32),
          statusBg: const Color(0xFFE8F5E9),
          isMaize: true,
          timelineSteps: const ['Ordered', 'Confirmed', 'On the Way', 'Delivered'],
          activeStepIdx: 2,
          stepDates: const ['May 10', 'May 10', 'May 12', ''],
        ),
        const SizedBox(height: 16),

        // Card 2: Rice
        _buildActiveOrderCard(
          crop: 'Rice',
          weight: '1,200 kg',
          value: '₦600,000',
          orderId: '#ORD-2024-1057',
          supplier: 'Green Fields Ltd',
          orderDate: 'May 11, 2024',
          eta: 'Tomorrow, 10:00 AM',
          statusText: 'Preparing',
          statusColor: Colors.orange,
          statusBg: const Color(0xFFFFF3E0),
          isMaize: false,
          timelineSteps: const ['Ordered', 'Confirmed', 'Preparing', 'On the Way'],
          activeStepIdx: 2,
          stepDates: const ['May 11', 'May 11', 'May 12', ''],
        ),
        const SizedBox(height: 24),

        // Order History Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Order History', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            Text('See All >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
          ],
        ),
        const SizedBox(height: 12),

        // History items
        _buildHistoryListItem('Tomato', '800 kg • ₦560/kg', 'Supplier: Fresh Harvests', 'Delivered on May 8, 2024', 'Delivered', const Color(0xFF2E7D32), const Color(0xFFE8F5E9), '₦448,000', const Color(0xFFFBE9E7)),
        const SizedBox(height: 12),
        _buildHistoryListItem('Yam', '1,000 kg • ₦700/kg', 'Supplier: ABC Farms', 'Delivered on May 5, 2024', 'Delivered', const Color(0xFF2E7D32), const Color(0xFFE8F5E9), '₦700,000', const Color(0xFFFAF7F0)),
        const SizedBox(height: 12),
        _buildHistoryListItem('Groundnut', '500 kg • ₦650/kg', 'Supplier: Green Fields Ltd', 'Cancelled on May 3, 2024', 'Cancelled', Colors.red, const Color(0xFFFBE9E7), '₦325,000', const Color(0xFFFFF8E1)),
      ],
    );
  }

  Widget _buildStatCard(String val, String title, String subtitle, IconData icon, Color bg, Color iconCol) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(val, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Center(child: Icon(icon, color: iconCol, size: 10)),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Colors.black54)),
                Text(subtitle, style: const TextStyle(fontSize: 6.5, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrderCard({
    required String crop,
    required String weight,
    required String value,
    required String orderId,
    required String supplier,
    required String orderDate,
    required String eta,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
    required bool isMaize,
    required List<String> timelineSteps,
    required int activeStepIdx,
    required List<String> stepDates,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomPaint(
                    painter: isMaize ? _MaizeCardPainter() : _RiceThumbnailPainter(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🚚 ', style: TextStyle(fontSize: 10)),
                              Text(statusText, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: statusColor)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(orderId, style: const TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(crop, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text('2,500 kg', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetaCol('Supplier', supplier),
              _buildMetaCol('Order Date', orderDate),
              _buildMetaCol('ETA', eta, color: statusColor, bg: statusBg),
            ],
          ),
          const Divider(height: 24),
          _buildTimelineTracker(timelineSteps, activeStepIdx, stepDates),
        ],
      ),
    );
  }

  Widget _buildMetaCol(String title, String val, {Color? color, Color? bg}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Container(
          padding: bg != null ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2) : EdgeInsets.zero,
          decoration: bg != null ? BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)) : null,
          child: Text(
            val,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color ?? const Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineTracker(List<String> steps, int activeIdx, List<String> dates) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (idx) {
        bool isDone = idx < activeIdx;
        bool isActive = idx == activeIdx;
        Color stepColor = isDone
            ? const Color(0xFF2E7D32)
            : isActive
                ? Colors.orange
                : Colors.grey.shade300;

        return Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: stepColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        isDone
                            ? Icons.check
                            : isActive
                                ? Icons.local_shipping
                                : Icons.circle,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(steps[idx], style: TextStyle(fontSize: 7.8, fontWeight: FontWeight.bold, color: stepColor)),
                  if (dates[idx].isNotEmpty)
                    Text(dates[idx], style: const TextStyle(fontSize: 6.8, color: Colors.grey)),
                ],
              ),
              if (idx < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color: idx < activeIdx ? const Color(0xFF2E7D32) : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHistoryListItem(String crop, String details, String supplier, String date, String status, Color statusCol, Color statusBg, String amt, Color itemBg) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: itemBg,
              shape: BoxShape.circle,
            ),
            child: const Center(child: Text('🌽', style: TextStyle(fontSize: 18))), // Emoji fallback
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(crop, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(details, style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
                Text(supplier, style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
                Text(date, style: const TextStyle(fontSize: 8.5, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                child: Text(status, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: statusCol)),
              ),
              const SizedBox(height: 6),
              Text(amt, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            ],
          ),
          const SizedBox(width: 6),
          const Icon(Icons.more_vert, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

// 3. Buyer Confirmations Screen (Redesigned matching mockup)
class BuyerConfirmationsScreen extends StatelessWidget {
  const BuyerConfirmationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Header (Confirm Deliveries, Hamburger, Bell, Avatar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Deliveries',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Review and confirm your received orders',
                          style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Text('👨🏾', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // KPI Stats row
                  Row(
                    children: [
                      _buildStatCard('4', 'Pending Confirmation', 'Orders', Icons.hourglass_top_outlined, const Color(0xFFFFF3E0), const Color(0xFFE65100)),
                      const SizedBox(width: 6),
                      _buildStatCard('34', 'Confirmed', 'This Month', Icons.check_circle_outline, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                      const SizedBox(width: 6),
                      _buildStatCard('42', 'Total Orders', 'This Month', Icons.assignment_outlined, const Color(0xFFE3F2FD), const Color(0xFF1565C0)),
                      const SizedBox(width: 6),
                      _buildStatCard('₦8,450,000', 'Total Spent', 'This Month', Icons.payments_outlined, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Pending Confirmations Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Pending Confirmations', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                      Text('View All (4) >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Rice Card
                  _buildPendingCard(
                    context: context,
                    crop: 'Rice',
                    weight: '1,200 kg • ₦500/kg',
                    supplier: 'Green Fields Ltd',
                    dateText: 'Delivered Today',
                    timeText: 'May 12, 2024 • 8:15 AM',
                    orderId: '#ORD-2024-1057',
                    amount: '₦600,000',
                    isMaize: false,
                    isRice: true,
                    isTomato: false,
                  ),
                  const SizedBox(height: 16),

                  // Maize Card
                  _buildPendingCard(
                    context: context,
                    crop: 'Maize',
                    weight: '2,500 kg • ₦450/kg',
                    supplier: 'ABC Farms',
                    dateText: 'Delivered Yesterday',
                    timeText: 'May 11, 2024 • 4:30 PM',
                    orderId: '#ORD-2024-1056',
                    amount: '₦1,125,000',
                    isMaize: true,
                    isRice: false,
                    isTomato: false,
                  ),
                  const SizedBox(height: 16),

                  // Tomato Card
                  _buildPendingCard(
                    context: context,
                    crop: 'Tomato',
                    weight: '800 kg • ₦580/kg',
                    supplier: 'Fresh Harvests',
                    dateText: 'Delivered Yesterday',
                    timeText: 'May 11, 2024 • 12:10 PM',
                    orderId: '#ORD-2024-1053',
                    amount: '₦448,000',
                    isMaize: false,
                    isRice: false,
                    isTomato: true,
                  ),
                  const SizedBox(height: 16),

                  // Yam Card
                  _buildPendingCard(
                    context: context,
                    crop: 'Yam',
                    weight: '1,000 kg • ₦700/kg',
                    supplier: 'ABC Farms',
                    dateText: 'Delivered May 9',
                    timeText: 'May 9, 2024 • 3:20 PM',
                    orderId: '#ORD-2024-1049',
                    amount: '₦700,000',
                    isMaize: false,
                    isRice: false,
                    isTomato: false,
                  ),
                  const SizedBox(height: 24),

                  // Recently Confirmed Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Recently Confirmed', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                      Text('View All >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Recently Confirmed Items
                  _buildRecentlyConfirmedItem('Groundnut', '500 kg • ₦650/kg', 'From Green Fields Ltd', 'Confirmed\nMay 8, 2024 • 9:20 AM', '₦325,000'),
                  const SizedBox(height: 12),
                  _buildRecentlyConfirmedItem('Rice', '1,500 kg • ₦500/kg', 'From Green Fields Ltd', 'Confirmed\nMay 7, 2024 • 5:45 PM', '₦750,000'),
                  const SizedBox(height: 12),
                  _buildRecentlyConfirmedItem('Maize', '2,000 kg • ₦450/kg', 'From ABC Farms', 'Confirmed\nMay 6, 2024 • 10:15 AM', '₦900,000'),
                  const SizedBox(height: 24),

                  // Guidelines Info Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F8E9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFDCEDC8)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.security, color: Color(0xFF2E7D32), size: 20),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Confirmation Guidelines',
                                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Please inspect your delivery before confirming. Once confirmed, the payment will be released to the supplier.',
                                style: TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                          child: const Text('Learn More >', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String val, String title, String subtitle, IconData icon, Color bg, Color iconCol) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    val,
                    style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Center(child: Icon(icon, color: iconCol, size: 10)),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Colors.black54)),
                Text(subtitle, style: const TextStyle(fontSize: 6.5, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPendingCard({
    required BuildContext context,
    required String crop,
    required String weight,
    required String supplier,
    required String dateText,
    required String timeText,
    required String orderId,
    required String amount,
    required bool isMaize,
    required bool isRice,
    required bool isTomato,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7F0),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CustomPaint(
                painter: isMaize
                    ? _MaizeCardPainter()
                    : isRice
                        ? _RiceThumbnailPainter()
                        : isTomato
                            ? _TomatoCardPainter()
                            : _YamCardPainter(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(crop, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                Text(weight, style: const TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w600)),
                Text(supplier, style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🚚 ', style: TextStyle(fontSize: 9)),
                      Text(dateText, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.orange)),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(timeText, style: const TextStyle(fontSize: 7.8, color: Colors.grey)),
                Text('Order ID: $orderId', style: const TextStyle(fontSize: 7.8, color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total Amount', style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
              Text(amount, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$crop delivery verification success! Escrow released.'), backgroundColor: const Color(0xFF2E7D32)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                ),
                child: const Text('Confirm Receipt', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 4),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Color(0xFFE2E2DF)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  minimumSize: Size.zero,
                ),
                child: const Text('Report Issue', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRecentlyConfirmedItem(String crop, String qty, String supplier, String date, String amt) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(color: Color(0xFFFAF7F0), shape: BoxShape.circle),
            child: const Center(child: Text('🌾', style: TextStyle(fontSize: 16))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(crop, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text('$qty • $supplier', style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 14),
              const SizedBox(width: 4),
              Text(date, style: const TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(width: 16),
          Text(amt, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

// 4. Buyer Wallet Screen (Redesigned matching mockup)
class BuyerWalletScreen extends StatefulWidget {
  const BuyerWalletScreen({super.key});

  @override
  State<BuyerWalletScreen> createState() => _BuyerWalletScreenState();
}

class _BuyerWalletScreenState extends State<BuyerWalletScreen> {
  double _availableBalance = 1250000;
  double _ledgerBalance = 1320000;
  bool _obscureBalance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Header (My Wallet, Hamburger, Bell, Avatar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Wallet',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Manage your balance and payments',
                          style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Text('👨🏾', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            // Wallet content area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Available Balance + Auxiliary Balances Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left available card
                      Expanded(
                        flex: 11,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          height: 180,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 6),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureBalance = !_obscureBalance;
                                          });
                                        },
                                        child: Icon(
                                          _obscureBalance ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                          color: Colors.white70,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _obscureBalance
                                        ? '₦•••••••'
                                        : '₦${_availableBalance.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                    style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Ledger Balance: ₦${_ledgerBalance.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                        style: const TextStyle(color: Colors.white70, fontSize: 8.5),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.info_outline, color: Colors.white70, size: 10),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _availableBalance += 500000;
                                          _ledgerBalance += 500000;
                                        });
                                      },
                                      icon: const Icon(Icons.add, size: 12),
                                      label: const Text('Add Money', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(0xFF1B5E20),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.send_outlined, size: 12, color: Colors.white),
                                      label: const Text('Send Money', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.white)),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: Colors.white60),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Right column balances
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            _buildMiniBalanceCard('On Hold', '₦70,000.00', Icons.access_time_outlined, const Color(0xFFFFF3E0), const Color(0xFFE65100)),
                            const SizedBox(height: 6),
                            _buildMiniBalanceCard('Pending Refunds', '₦45,000.00', Icons.sync_outlined, const Color(0xFFE3F2FD), const Color(0xFF1565C0)),
                            const SizedBox(height: 6),
                            _buildMiniBalanceCard('Credit Limit', '₦500,000.00', Icons.credit_card_outlined, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Quick Actions Row
                  const Text('Quick Actions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuickActionTile('Add Money', Icons.account_balance_wallet_outlined),
                      _buildQuickActionTile('Send Money', Icons.send_outlined),
                      _buildQuickActionTile('Bank Transfer', Icons.account_balance_outlined),
                      _buildQuickActionTile('Pay Supplier', Icons.assignment_outlined),
                      _buildQuickActionTile('Withdrawal', Icons.download_outlined),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // My Cards Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('My Cards', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                      Text('Manage Cards >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // VISA Debit Card Widget
                      Expanded(
                        child: Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF122C19), Color(0xFF1E4627)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Chip illustration
                                  Container(
                                    width: 24,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD54F).withValues(alpha: 0.8),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                ],
                              ),
                              const Text(
                                '**** **** **** 4242',
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Abdullahi Musa', style: TextStyle(color: Colors.white70, fontSize: 9.5, fontWeight: FontWeight.bold)),
                                  Text('Exp 12/26', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Add New Card Card
                      Expanded(
                        child: Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E2DF), style: BorderStyle.solid),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                                child: const Center(child: Icon(Icons.add, color: Color(0xFF2E7D32), size: 16)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('Add New Card', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                                    SizedBox(height: 2),
                                    Text('Add a new card for faster payments', style: TextStyle(fontSize: 8, color: Colors.grey)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Recent Transactions Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Recent Transactions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                      Text('View All >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Transactions list
                  _buildTxListItem('Payment Sent', 'To ABC Agro Ltd', 'May 11, 2024 • 4:30 PM', '-₦1,125,000.00', 'Debit', Colors.red, const Color(0xFFFBE9E7), Icons.arrow_downward_outlined, const Color(0xFFE8F5E9)),
                  const SizedBox(height: 12),
                  _buildTxListItem('Money Added', 'From GTBank • • • • 1234', 'May 10, 2024 • 10:15 AM', '+₦500,000.00', 'Credit', const Color(0xFF2E7D32), const Color(0xFFE8F5E9), Icons.arrow_upward_outlined, const Color(0xFFE8F5E9)),
                  const SizedBox(height: 12),
                  _buildTxListItem('Payment Sent', 'To Green Fields Ltd', 'May 9, 2024 • 2:20 PM', '-₦600,000.00', 'Debit', Colors.red, const Color(0xFFFBE9E7), Icons.arrow_downward_outlined, const Color(0xFFFFF3E0)),
                  const SizedBox(height: 12),
                  _buildTxListItem('Refund Received', 'From ABC Farms', 'May 8, 2024 • 9:45 AM', '+₦120,000.00', 'Credit', const Color(0xFF2E7D32), const Color(0xFFE8F5E9), Icons.arrow_upward_outlined, const Color(0xFFE8F5E9)),
                  const SizedBox(height: 12),
                  _buildTxListItem('Bank Transfer', 'To Access Bank • • • • 5678', 'May 7, 2024 • 1:30 PM', '-₦300,000.00', 'Debit', Colors.red, const Color(0xFFFBE9E7), Icons.account_balance_outlined, const Color(0xFFE3F2FD)),
                  const SizedBox(height: 24),

                  // Spending Summary Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7F0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: CustomPaint(
                              painter: _WalletCardIllustrationPainter(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Spending Summary', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold)),
                              SizedBox(height: 2),
                              Text(
                                'You have spent ₦3,450,000.00 this month\n₦250,000.00 more than last month ↑',
                                style: TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF2E7D32),
                            side: const BorderSide(color: Color(0xFFE2E2DF)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          child: const Text('View Report', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBalanceCard(String title, String val, IconData icon, Color bg, Color iconCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Center(child: Icon(icon, color: iconCol, size: 12)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 7.5, color: Colors.grey, fontWeight: FontWeight.bold)),
                Text(val, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile(String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E2DF)),
          ),
          child: Center(child: Icon(icon, color: const Color(0xFF2E7D32), size: 18)),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 7.8, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
      ],
    );
  }

  Widget _buildTxListItem(
    String title,
    String detail,
    String time,
    String amount,
    String badgeText,
    Color statusCol,
    Color statusBg,
    IconData icon,
    Color circleBg,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: circleBg, shape: BoxShape.circle),
            child: Center(child: Icon(icon, color: statusCol, size: 16)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                Text(detail, style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
                Text(time, style: const TextStyle(fontSize: 8.5, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                child: Text(badgeText, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: statusCol)),
              ),
              const SizedBox(height: 6),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: amount.startsWith('+') ? const Color(0xFF2E7D32) : const Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

// 5. Buyer Profile Screen
class BuyerProfileScreen extends StatelessWidget {
  const BuyerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Header Row (Hamburger, My Profile, Notification Bell, Avatar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Profile',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Manage your account and preferences',
                          style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Text('👨🏾', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            // Profile scrollable body
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Top Profile Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Row(
                      children: [
                        // Left Avatar with camera overlay
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFFC8E6C9),
                              child: Text('👨🏾', style: TextStyle(fontSize: 42)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: const Icon(Icons.camera_alt, size: 14, color: Color(0xFF2E7D32)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 14),
                        // Profile Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Musa Abdullahi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(6)),
                                    child: const Text('Buyer', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                                  )
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: const [
                                  Icon(Icons.email_outlined, size: 12, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text('musa.abdullahi@greenmart.com', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Icon(Icons.phone_outlined, size: 12, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text('+234 803 123 4567', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text('Kano, Kano State, Nigeria', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category 1: Account & Business
                  const Text('Account & Business', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Column(
                      children: [
                        _buildMenuRow(Icons.storefront_outlined, 'Business Information', 'View and update your business details'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.people_outline, 'Team Members', 'Manage your team and permissions', rightBadge: '5 Members'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.location_on_outlined, 'Addresses', 'Manage your delivery and billing addresses', rightBadge: '3 Addresses'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(
                          Icons.badge_outlined,
                          'KYC Verification',
                          'Verify your account to increase limits',
                          rightWidget: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Verified', style: TextStyle(fontSize: 9.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                              SizedBox(width: 4),
                              Icon(Icons.check_circle, size: 12, color: Color(0xFF2E7D32)),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(
                          Icons.swap_horiz_outlined,
                          'Switch Persona',
                          'Swap to Farmer or Cooperative role',
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category 2: Preferences
                  const Text('Preferences', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Column(
                      children: [
                        _buildMenuRow(Icons.notifications_none_outlined, 'Notification Settings', 'Manage your notification preferences'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.security_outlined, 'Payment & Security', 'Change PIN, manage security and 2FA'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.language_outlined, 'Language', 'Choose your preferred language', rightBadge: 'English'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.monetization_on_outlined, 'Currency', 'Select your preferred currency', rightBadge: 'NGN (₦)'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category 3: Support & Legal
                  const Text('Support & Legal', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Column(
                      children: [
                        _buildMenuRow(Icons.help_outline, 'Help Center', 'Get help and find answers'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.headset_mic_outlined, 'Contact Support', 'Chat or call our support team'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.description_outlined, 'Terms & Conditions', 'Read our terms and conditions'),
                        const Divider(height: 1, color: Color(0xFFF1F1EF)),
                        _buildMenuRow(Icons.lock_outline, 'Privacy Policy', 'Read our privacy policy'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Log Out Card
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                        (route) => false,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5F5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFFD1D1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(color: Color(0xFFFFEAEA), shape: BoxShape.circle),
                            child: const Center(child: Icon(Icons.logout, color: Colors.red, size: 16)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Log Out', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.red)),
                                SizedBox(height: 2),
                                Text('Sign out from your account', style: TextStyle(fontSize: 9.5, color: Colors.grey)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.red, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow(
    IconData icon,
    String title,
    String subtitle, {
    String? rightBadge,
    Widget? rightWidget,
    VoidCallback? onTap,
  }) {
    return ListTile(
      dense: true,
      onTap: onTap ?? () {},
      leading: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
        child: Icon(icon, color: const Color(0xFF2E7D32), size: 16),
      ),
      title: Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (rightWidget != null) rightWidget,
          if (rightBadge != null && rightWidget == null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFFFAF7F0), borderRadius: BorderRadius.circular(6)),
              child: Text(rightBadge, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}


// Custom Painter to illustrate baskets of fresh produce (tomatoes, greens) with logistics truck on the hero card
class _BuyerDashboardHeroPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw background hills/fields
    final fieldPaint = Paint()
      ..color = const Color(0xFF14301B)
      ..style = PaintingStyle.fill;
    
    final path = Path()
      ..moveTo(w * 0.4, h)
      ..quadraticBezierTo(w * 0.6, h * 0.5, w, h * 0.65)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(path, fieldPaint);

    final fieldPaint2 = Paint()
      ..color = const Color(0xFF0F2615)
      ..style = PaintingStyle.fill;
    
    final path2 = Path()
      ..moveTo(w * 0.55, h)
      ..quadraticBezierTo(w * 0.75, h * 0.45, w, h * 0.35)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(path2, fieldPaint2);

    // Draw vegetable crates & logistics truck silhouettes in gold
    final goldPaint = Paint()
      ..color = const Color(0xFFD4A017).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    // Crate silhouettes
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.68, h * 0.72, w * 0.76, h * 0.88), const Radius.circular(4)), goldPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.78, h * 0.65, w * 0.88, h * 0.85), const Radius.circular(4)), goldPaint);

    // Truck silhouette on the far right
    final truckPaint = Paint()
      ..color = const Color(0xFFD4A017).withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    // Truck cargo box
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.84, h * 0.42, w * 0.96, h * 0.64), const Radius.circular(3)), truckPaint);
    // Truck cabin
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.79, h * 0.50, w * 0.835, h * 0.64), const Radius.circular(2)), truckPaint);
    
    // Truck wheels
    final wheelPaint = Paint()..color = const Color(0xFF0F2615);
    canvas.drawCircle(Offset(w * 0.82, h * 0.66), 4, wheelPaint);
    canvas.drawCircle(Offset(w * 0.87, h * 0.66), 4, wheelPaint);
    canvas.drawCircle(Offset(w * 0.93, h * 0.66), 4, wheelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter to draw fresh maize corn thumbnail
class _MaizeCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    // Draw green husk backing
    final leafPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
    
    final path = Path()
      ..moveTo(w * 0.2, h * 0.8)
      ..quadraticBezierTo(w * 0.1, h * 0.3, w * 0.5, h * 0.1)
      ..quadraticBezierTo(w * 0.9, h * 0.3, w * 0.8, h * 0.8)
      ..close();
    canvas.drawPath(path, leafPaint);

    // Draw yellow kernel core
    final cornPaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTRB(w * 0.32, h * 0.25, w * 0.68, h * 0.85), cornPaint);

    // Draw individual kernels lines for premium aesthetic
    final linePaint = Paint()
      ..color = const Color(0xFFFF8F00)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(Offset(w * 0.42, h * 0.3), Offset(w * 0.42, h * 0.8), linePaint);
    canvas.drawLine(Offset(w * 0.50, h * 0.26), Offset(w * 0.50, h * 0.84), linePaint);
    canvas.drawLine(Offset(w * 0.58, h * 0.3), Offset(w * 0.58, h * 0.8), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter to draw Rice stalk thumbnail
class _RiceThumbnailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    // Stem line
    final stemPaint = Paint()
      ..color = const Color(0xFF81C784)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
      
    final path = Path()
      ..moveTo(w * 0.2, h * 0.9)
      ..quadraticBezierTo(w * 0.5, h * 0.5, w * 0.8, h * 0.2);
    canvas.drawPath(path, stemPaint);

    // Draw grains hanging off
    final grainPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;
      
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.8, h * 0.2), width: 6, height: 10), grainPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.72, h * 0.28), width: 5, height: 9), grainPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.63, h * 0.36), width: 5, height: 9), grainPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.54, h * 0.45), width: 5, height: 8), grainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter to draw dotted logistics tracking route map
class _RouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Green dotted path line connecting point A to B
    final pathPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(w * 0.15, h * 0.6)
      ..quadraticBezierTo(w * 0.5, h * 0.2, w * 0.85, h * 0.5);

    // Draw dotted path segments manually
    final pms = path.computeMetrics();
    for (var pm in pms) {
      double len = pm.length;
      double current = 0.0;
      while (current < len) {
        final extract = pm.extractPath(current, current + 3.0);
        canvas.drawPath(extract, pathPaint);
        current += 7.0;
      }
    }

    // Start location green pin
    final greenPin = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.15, h * 0.6), 5, greenPin);

    // End location orange truck
    final orangePin = Paint()
      ..color = Colors.orange;
    canvas.drawCircle(Offset(w * 0.85, h * 0.5), 6, orangePin);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter to draw fresh tomato illustration
class _TomatoCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw red glossy body 1
    final redPaint = Paint()
      ..color = const Color(0xFFD32F2F)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.4, h * 0.55), 22, redPaint);

    // Draw red glossy body 2
    canvas.drawCircle(Offset(w * 0.65, h * 0.52), 18, redPaint);

    // Draw green leaf/stem crown on top 1
    final leafPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;
      
    final leaf1 = Path()
      ..moveTo(w * 0.4, h * 0.25)
      ..quadraticBezierTo(w * 0.35, h * 0.15, w * 0.42, h * 0.1)
      ..quadraticBezierTo(w * 0.48, h * 0.2, w * 0.4, h * 0.25)
      ..close();
    canvas.drawPath(leaf1, leafPaint);

    // Draw green leaf/stem crown on top 2
    final leaf2 = Path()
      ..moveTo(w * 0.65, h * 0.28)
      ..quadraticBezierTo(w * 0.6, h * 0.2, w * 0.67, h * 0.15)
      ..quadraticBezierTo(w * 0.72, h * 0.24, w * 0.65, h * 0.28)
      ..close();
    canvas.drawPath(leaf2, leafPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter to draw fresh cut-open yam root illustration
class _YamCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Outer brown root skin
    final brownPaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.fill;
      
    canvas.drawOval(Rect.fromLTRB(w * 0.15, h * 0.3, w * 0.85, h * 0.7), brownPaint);

    // Cut open face inside (creamy starch center)
    final creamPaint = Paint()
      ..color = const Color(0xFFFFF9C4)
      ..style = PaintingStyle.fill;

    canvas.drawOval(Rect.fromLTRB(w * 0.45, h * 0.32, w * 0.82, h * 0.68), creamPaint);

    // Details/cracks on skin
    final crackPaint = Paint()
      ..color = const Color(0xFF3E2723)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
      
    canvas.drawLine(Offset(w * 0.2, h * 0.45), Offset(w * 0.35, h * 0.55), crackPaint);
    canvas.drawLine(Offset(w * 0.25, h * 0.58), Offset(w * 0.38, h * 0.48), crackPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter to draw a wallet with gold coins illustration
class _WalletCardIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw dark green wallet base
    final walletPaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.15, h * 0.35, w * 0.85, h * 0.85), const Radius.circular(8)), walletPaint);

    // Draw gold coin circle 1
    final coinPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.38, h * 0.28), 6, coinPaint);

    // Draw gold coin circle 2
    canvas.drawCircle(Offset(w * 0.58, h * 0.22), 7, coinPaint);

    // Draw wallet clasp flap in gold
    final claspPaint = Paint()
      ..color = const Color(0xFFFFC107)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.72, h * 0.52, w * 0.90, h * 0.68), const Radius.circular(4)), claspPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




