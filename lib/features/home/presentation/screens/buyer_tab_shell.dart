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
      const BuyerDashboardScreen(),
      const BuyerPurchasesScreen(),
      const BuyerAnalyticsScreen(),
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
        selectedItemColor: const Color(0xFF1565C0), // Blue theme for buyer
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
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Purchases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
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

// 1. Buyer Dashboard Screen
class BuyerDashboardScreen extends StatefulWidget {
  const BuyerDashboardScreen({super.key});

  @override
  State<BuyerDashboardScreen> createState() => _BuyerDashboardScreenState();
}

class _BuyerDashboardScreenState extends State<BuyerDashboardScreen> {
  double _escrowBalance = 18500000;
  
  final List<Map<String, dynamic>> _deliveries = [
    {
      'id': 1,
      'crop': 'Maize',
      'emoji': '🌽',
      'farmer': 'Musa',
      'weight': '2500kg',
      'amount': 875000,
      'status': 'ESCROW',
      'date': 'Today, 08:30 AM',
    },
    {
      'id': 2,
      'crop': 'Rice',
      'emoji': '🌾',
      'farmer': 'Ngozi',
      'weight': '1800kg',
      'amount': 630000,
      'status': 'ESCROW',
      'date': 'Today, 09:15 AM',
    },
  ];

  void _confirmDeliveryPayment(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Confirm Delivery & Release Escrow?'),
        content: Text(
          'Confirming will release ₦${_deliveries[index]['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} to ${_deliveries[index]['farmer']} and finalize this transaction.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _deliveries[index]['status'] = 'SUCCESS';
                _escrowBalance -= _deliveries[index]['amount'];
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Delivery confirmed! Payment released to ${_deliveries[index]['farmer']}.'),
                  backgroundColor: const Color(0xFF2E7D32),
                ),
              );
            },
            child: const Text('Confirm Delivery', style: TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.bold)),
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
        child: Column(
          children: [
            // App Bar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Buyer (ABC Agro) 👋',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Buyer Procurement Office',
                          style: TextStyle(fontSize: 10, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Color(0xFF333333)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                    },
                  ),
                ],
              ),
            ),

            // Content scroll
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Escrow Account Card (Wallet Balance Hero)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF1565C0)], // Green + Blue gradient for Buyer role!
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1565C0).withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Wallet Balance',
                              style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.account_balance_wallet, color: Colors.white70, size: 18),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '₦${_escrowBalance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _escrowBalance += 1000000;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Wallet successfully funded with ₦1,000,000!'),
                                    backgroundColor: Color(0xFF2E7D32),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_circle_outline, size: 14),
                              label: const Text('Fund Wallet', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF2E7D32),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Three mini stats row (Awaiting Confirmation: 12, Pending Payments: 5, Completed Today: 28)
                  Row(
                    children: [
                      _buildMiniStat('Awaiting Confirmation', '12', Icons.pending_actions_outlined),
                      const SizedBox(width: 8),
                      _buildMiniStat('Pending Payments', '5', Icons.hourglass_top_outlined),
                      const SizedBox(width: 8),
                      _buildMiniStat('Completed Today', '28', Icons.check_circle_outline),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Pending Deliveries Header
                  const Text(
                    'Pending Deliveries',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 12),

                  // Active Deliveries List
                  ...List.generate(_deliveries.length, (index) {
                    final d = _deliveries[index];
                    return _buildProcurementCard(d, index);
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String val, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF1565C0), size: 18),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 8.5, color: Color(0xFF888888), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildProcurementCard(Map<String, dynamic> d, int index) {
    bool isPending = d['status'] == 'ESCROW' || d['status'] == 'PENDING';
    Color statusCol = d['status'] == 'SUCCESS'
        ? const Color(0xFF2E7D32)
        : d['status'] == 'ESCROW'
            ? Colors.deepPurple
            : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F5),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(d['emoji'], style: const TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${d['crop']} Delivery', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('Farmer: ${d['farmer']}', style: const TextStyle(fontSize: 10, color: Color(0xFF777777))),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₦${d['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1565C0)),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusCol.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      d['status'],
                      style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: statusCol),
                    ),
                  ),
                ],
              )
            ],
          ),
          if (isPending) ...[
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(d['weight'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                ElevatedButton(
                  onPressed: () => _confirmDeliveryPayment(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32), // Green color to match "Confirm" action!
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: const Text('Confirm Delivery', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}

// 2. Buyer Purchases Screen
class BuyerPurchasesScreen extends StatelessWidget {
  const BuyerPurchasesScreen({super.key});

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
              const Text('Purchases Ledger', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Audit trail of completed grain procurement transactions', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildRowItem('Maize Delivery', '2,500 kg', '₦875,000', 'Success', 'Musa Haruna', 'Ref: FP-83749'),
                    _buildRowItem('Rice Delivery', '5,000 kg', '₦1,950,000', 'Success', 'Kaduna Cooperative', 'Ref: FP-92847'),
                    _buildRowItem('Soybeans Delivery', '1,200 kg', '₦480,000', 'Success', 'Ibrahim Bello', 'Ref: FP-18274'),
                    _buildRowItem('Cassava Delivery', '8,000 kg', '₦2,400,000', 'Success', 'Fatima Umar', 'Ref: FP-02847'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowItem(String title, String qty, String amt, String status, String source, String ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(amt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1565C0))),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Seller: $source • Qty: $qty', style: const TextStyle(color: Colors.grey, fontSize: 10)),
              Text(ref, style: const TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}

// 3. Buyer Analytics Screen
class BuyerAnalyticsScreen extends StatelessWidget {
  const BuyerAnalyticsScreen({super.key});

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
              const Text('Market Intelligence', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Crop supply trends & pricing charts', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildChartCard('Procurement Volume (Tons)', ['May', 'Jun', 'Jul', 'Aug'], [8.2, 12.5, 18.5, 24.0]),
                    const SizedBox(height: 16),
                    _buildChartCard('Grain Average Cost Index (₦/kg)', ['Maize', 'Rice', 'Soybeans'], [350, 390, 400]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, List<String> labels, List<double> values) {
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
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(labels.length, (idx) {
                double val = values[idx];
                double max = values.reduce((curr, next) => curr > next ? curr : next);
                double pct = val / max;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 28,
                      height: 80 * pct,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(labels[idx], style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

// 4. Buyer Profile Screen
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
                      leading: const Icon(Icons.swap_horiz, color: Color(0xFF1565C0)),
                      title: const Text('Switch Active Role', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Swap to Farmer or Cooperative persona', style: TextStyle(fontSize: 10)),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () {
                        // Switch role selection
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                          (route) => false,
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F1EF)),
                    ListTile(
                      leading: const Icon(Icons.lock_outline, color: Color(0xFF1565C0)),
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
