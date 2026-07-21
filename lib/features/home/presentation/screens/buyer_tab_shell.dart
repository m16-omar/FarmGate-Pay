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
                  IconButton(
                    icon: const Icon(Icons.menu, color: Color(0xFF333333)),
                    onPressed: () {},
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
                            color: Colors.black.withOpacity(0.04),
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

// 2. Buyer Orders Screen
class BuyerOrdersScreen extends StatelessWidget {
  const BuyerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBF9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('My Sourcing Orders', style: TextStyle(color: Color(0xFF333333), fontSize: 16, fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelColor: Color(0xFF2E7D32),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF2E7D32),
            tabs: [
              Tab(text: 'Active Escrow'),
              Tab(text: 'Completed Transactions'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSourcingOrderCard('Maize Procurement', '2,500 kg', '₦1,125,000', 'ESCROW', 'ABC Farms', 'Estimated Arrival: Today • 4:30 PM'),
                _buildSourcingOrderCard('Rice Contract', '1,200 kg', '₦540,000', 'AWAITING_CONFIRMATION', 'Northern Rice Mills', 'Delivered: Today • 8:15 AM'),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSourcingOrderCard('Soybeans Sourcing', '5,000 kg', '₦2,000,000', 'PAID', 'Zaria Growers Coop', 'Settled: July 20, 2026'),
                _buildSourcingOrderCard('Tomato Sourcing', '3,000 kg', '₦900,000', 'PAID', 'Kano Farmers Union', 'Settled: July 19, 2026'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourcingOrderCard(String title, String qty, String amt, String status, String supplier, String dateInfo) {
    Color statusBg = status == 'PAID' ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0);
    Color statusColor = status == 'PAID' ? const Color(0xFF2E7D32) : const Color(0xFFE65100);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                child: Text(status, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: statusColor)),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text('Supplier: $supplier • Quantity: $qty', style: const TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(height: 2),
          Text('Total Cost: $amt', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF2E7D32))),
          const Divider(height: 20),
          Text(dateInfo, style: const TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// 3. Buyer Confirmations Screen
class BuyerConfirmationsScreen extends StatelessWidget {
  const BuyerConfirmationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Confirm Receipts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Verify delivered quantities before releasing escrow funds', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildPendingConfirmCard(context, 'Rice Crop Sourcing', '1,200 kg', '₦540,000', 'Northern Rice Mills', 'Delivered Today, 8:15 AM'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPendingConfirmCard(BuildContext context, String crop, String weight, String value, String supplier, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(crop, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
            ],
          ),
          const SizedBox(height: 4),
          Text('Supplier: $supplier • Quantity: $weight', style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text('Status: $time', style: const TextStyle(fontSize: 9.5, color: Colors.orange, fontWeight: FontWeight.bold)),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Contract ID: SOURCING-9284', style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.grey)),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Delivery verification success! Escrow released.'), backgroundColor: Color(0xFF2E7D32)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                child: const Text('Confirm & Release Payout', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }
}

// 4. Buyer Wallet Screen
class BuyerWalletScreen extends StatefulWidget {
  const BuyerWalletScreen({super.key});

  @override
  State<BuyerWalletScreen> createState() => _BuyerWalletScreenState();
}

class _BuyerWalletScreenState extends State<BuyerWalletScreen> {
  double _walletBalance = 18500000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Escrow Procurement Wallet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Fund contracts and track settlements in escrow', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF1565C0)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Wallet Balance', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    const SizedBox(height: 6),
                    Text(
                      '₦${_walletBalance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _walletBalance += 5000000;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Successfully funded ₦5,000,000!'), backgroundColor: Color(0xFF2E7D32)),
                        );
                      },
                      icon: const Icon(Icons.add, size: 14),
                      label: const Text('Fund Escrow Wallet', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Transaction Activity', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    _buildTxRow('Payment Sent', 'Northern Foods Ltd', '-₦540,000', 'Success', 'Today'),
                    const Divider(height: 1),
                    _buildTxRow('Escrow Funded', 'Monnify Payout Node', '+₦5,000,000', 'Success', 'Yesterday'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTxRow(String title, String details, String amt, String status, String date) {
    Color valColor = amt.startsWith('+') ? const Color(0xFF2E7D32) : Colors.red;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: amt.startsWith('+') ? const Color(0xFFE8F5E9) : const Color(0xFFFBE9E7),
        child: Icon(amt.startsWith('+') ? Icons.add : Icons.remove, color: valColor, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      subtitle: Text('$details • $date', style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
      trailing: Text(amt, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: valColor)),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(
                radius: 36,
                backgroundColor: Color(0xFFE3F2FD),
                child: Icon(Icons.business, color: Color(0xFF1565C0), size: 36),
              ),
              const SizedBox(height: 12),
              const Text('ABC Agro-Processors Ltd', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('buyer@abcagro.com', style: TextStyle(fontSize: 11, color: Colors.grey)),
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
                      subtitle: const Text('Swap to Farmer or Cooperative persona', style: TextStyle(fontSize: 10)),
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
                      leading: const Icon(Icons.lock_outline, color: Color(0xFF2E7D32)),
                      title: const Text('Escrow Settings', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Manage linked bank keys & Monnify contracts', style: TextStyle(fontSize: 10)),
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
      ..color = const Color(0xFFD4A017).withOpacity(0.35)
      ..style = PaintingStyle.fill;

    // Crate silhouettes
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.68, h * 0.72, w * 0.76, h * 0.88), const Radius.circular(4)), goldPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.78, h * 0.65, w * 0.88, h * 0.85), const Radius.circular(4)), goldPaint);

    // Truck silhouette on the far right
    final truckPaint = Paint()
      ..color = const Color(0xFFD4A017).withOpacity(0.5)
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
