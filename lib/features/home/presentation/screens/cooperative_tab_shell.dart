import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Reuses the existing real-time cooperative joint ledger screen!
import 'notifications_screen.dart';
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
      const CooperativeDashboardScreen(),
      const CooperativeMembersScreen(),
      const DashboardScreen(), // The real-time Monnify payout ledger screen!
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
        selectedItemColor: const Color(0xFFE29A26), // Gold theme for cooperative
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
            icon: Icon(Icons.group_work_outlined),
            activeIcon: Icon(Icons.group_work),
            label: 'Coop Hub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Payout Ledger',
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
class CooperativeDashboardScreen extends StatefulWidget {
  const CooperativeDashboardScreen({super.key});

  @override
  State<CooperativeDashboardScreen> createState() => _CooperativeDashboardScreenState();
}

class _CooperativeDashboardScreenState extends State<CooperativeDashboardScreen> {
  final List<Map<String, dynamic>> _topFarmers = [
    {
      'name': 'Musa',
      'emoji': '👨🏾🌾',
      'crop': 'Maize',
      'performance': '₦2.4M Settled',
      'status': 'Top Grower',
    },
    {
      'name': 'Ngozi',
      'emoji': '👩🏾🌾',
      'crop': 'Rice',
      'performance': '₦1.8M Settled',
      'status': 'Top Grower',
    },
    {
      'name': 'Abdullahi',
      'emoji': '👨🏾🌾',
      'crop': 'Groundnut',
      'performance': '₦1.2M Settled',
      'status': 'Active',
    },
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Farmer Registered',
      'desc': 'Abu Sani joined Kaduna Coop',
      'time': '10 mins ago',
      'icon': Icons.person_add_alt_1_outlined,
      'color': const Color(0xFF2E7D32),
    },
    {
      'title': 'Settlement Completed',
      'desc': '₦145,000 paid to Musa Haruna',
      'time': '1 hour ago',
      'icon': Icons.check_circle_outline,
      'color': const Color(0xFFE29A26),
    },
    {
      'title': 'Delivery Recorded',
      'desc': '2.5 Tons of Maize logged',
      'time': '2 hours ago',
      'icon': Icons.local_shipping_outlined,
      'color': const Color(0xFF2E7D32),
    },
  ];

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Register Cooperative Farmer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'e.g., Abubakar Sani',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Active Crop Type',
                hintText: 'e.g., Soybeans',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Farmer successfully registered into Kaduna Cooperative!'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
            child: const Text('Register', style: TextStyle(color: Color(0xFFE29A26), fontWeight: FontWeight.bold)),
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
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kaduna Farmers Cooperative',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Cooperative Manager Hub',
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

            // Main Body
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Joint Wallet Card (Hero: Today's Settlements)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFFE29A26)], // Green + Gold gradient for Coop role!
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE29A26).withOpacity(0.2),
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
                              'Today\'s Settlements',
                              style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.diversity_3, color: Colors.white70, size: 18),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '₦4.2M',
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _showAddMemberDialog,
                              icon: const Icon(Icons.person_add, size: 14),
                              label: const Text('Register Farmer', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
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

                  // Three mini stats row (Active Farmers: 286, Today's Deliveries: 42, Pending: 6)
                  Row(
                    children: [
                      _buildMiniStat('Active Farmers', '286', Icons.people_outline),
                      const SizedBox(width: 8),
                      _buildMiniStat('Today\'s Deliveries', '42', Icons.inventory_2_outlined),
                      const SizedBox(width: 8),
                      _buildMiniStat('Pending', '6', Icons.hourglass_empty_outlined),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Top Performing Farmers Header
                  const Text(
                    'Top Performing Farmers',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 12),

                  // Top Performing Farmers List
                  ..._topFarmers.map((f) => _buildFarmerCard(f)),
                  const SizedBox(height: 24),

                  // Recent Activities Header
                  const Text(
                    'Recent Activities',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 12),

                  // Recent Activities Column
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Column(
                      children: List.generate(_activities.length, (idx) {
                        final act = _activities[idx];
                        return Padding(
                          padding: EdgeInsets.only(bottom: idx == _activities.length - 1 ? 0 : 16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: act['color'].withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(act['icon'], color: act['color'], size: 18),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(act['title'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 2),
                                    Text(act['desc'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Text(act['time'], style: const TextStyle(fontSize: 8.5, color: Colors.grey)),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Monthly Earnings Header
                  const Text(
                    'Monthly Earnings',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 12),

                  // Custom performance chart
                  _buildPerformanceChart(),
                  const SizedBox(height: 24),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E2DF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFFE29A26), size: 18), // Gold color for icons
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 8, color: Color(0xFF888888), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerCard(Map<String, dynamic> f) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F5),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(f['emoji'], style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('Crop: ${f['crop']}', style: const TextStyle(fontSize: 10, color: Color(0xFF777777))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(f['performance'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  f['status'],
                  style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    final months = ['May', 'Jun', 'Jul', 'Aug'];
    final settlements = [1.8, 2.9, 4.2, 5.5];

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
          const Text('Total Settlements Logged (₦ Millions)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(months.length, (idx) {
                double val = settlements[idx];
                double max = settlements.reduce((curr, next) => curr > next ? curr : next);
                double pct = val / max;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('₦${val}M', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    const SizedBox(height: 6),
                    Container(
                      width: 32,
                      height: 80 * pct,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2E7D32), Color(0xFFE29A26)], // Green + Gold theme bars!
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(months[idx], style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
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

// 2. Cooperative Members Directory Screen
class CooperativeMembersScreen extends StatelessWidget {
  const CooperativeMembersScreen({super.key});

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
              const Text('Members Directory', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              const Text('Complete list of cooperative crop growers', style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildMemberListItem('Musa Haruna', 'Maize', '2.5 Acres', 'Active', 'Kaduna'),
                    _buildMemberListItem('Ibrahim Bello', 'Rice', '1.8 Acres', 'Active', 'Kaduna'),
                    _buildMemberListItem('Fatima Umar', 'Tomato', '0.5 Acres', 'Active', 'Kaduna'),
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

// 4. Cooperative Profile Screen
class CooperativeProfileScreen extends StatelessWidget {
  const CooperativeProfileScreen({super.key});

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
                backgroundColor: Color(0xFFFFF8E1), // Light gold/amber background
                child: Icon(Icons.handshake, color: Color(0xFFE29A26), size: 36), // Gold icon
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
                      leading: const Icon(Icons.swap_horiz, color: Color(0xFFE29A26)),
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
                      leading: const Icon(Icons.group_outlined, color: Color(0xFFE29A26)),
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
