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
        selectedItemColor: const Color(0xFF7B1FA2), // Purple theme for cooperative
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
  final List<Map<String, dynamic>> _members = [
    {
      'name': 'Musa Haruna',
      'role': 'Coop Farmer',
      'crop': 'Maize',
      'emoji': '🌽',
      'payouts': '₦2,450,000',
      'status': 'Active',
    },
    {
      'name': 'Ibrahim Bello',
      'role': 'Coop Farmer',
      'crop': 'Rice',
      'emoji': '🌾',
      'payouts': '₦1,850,000',
      'status': 'Active',
    },
    {
      'name': 'Fatima Umar',
      'role': 'Coop Farmer',
      'crop': 'Tomato',
      'emoji': '🍅',
      'payouts': '₦980,000',
      'status': 'Active',
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
                  backgroundColor: Color(0xFF1B5E20),
                ),
              );
            },
            child: const Text('Register', style: TextStyle(color: Color(0xFF7B1FA2), fontWeight: FontWeight.bold)),
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
                          'Kaduna Cooperative 👋',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Agricultural Aggregation & Payouts',
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
                  // Joint Wallet Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E24AA), Color(0xFF7B1FA2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7B1FA2).withOpacity(0.2),
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
                              'Joint Cooperative Payout Balance',
                              style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.diversity_3, color: Colors.white70, size: 16),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '₦12,800,000',
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _showAddMemberDialog,
                              icon: const Icon(Icons.person_add, size: 14),
                              label: const Text('Add Member', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF7B1FA2),
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

                  // Quick Stats Row
                  Row(
                    children: [
                      _buildMiniStat('Aggregated Crops', '18.6 Tons', Icons.agriculture_outlined),
                      const SizedBox(width: 12),
                      _buildMiniStat('Coop Farmers', '42 Active', Icons.group_outlined),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Active Members Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Active Members Directory',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All', style: TextStyle(color: Color(0xFF7B1FA2), fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Members List cards
                  ..._members.map((m) => _buildMemberCard(m)),
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
            Icon(icon, color: const Color(0xFF7B1FA2), size: 18),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 8.5, color: Color(0xFF888888), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> m) {
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
            child: Center(child: Text(m['emoji'], style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('${m['role']} • ${m['crop']}', style: const TextStyle(fontSize: 10, color: Color(0xFF777777))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(m['payouts'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  m['status'],
                  style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                ),
              ),
            ],
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
                backgroundColor: Color(0xFFF3E5F5),
                child: Icon(Icons.handshake, color: Color(0xFF7B1FA2), size: 36),
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
                      leading: const Icon(Icons.swap_horiz, color: Color(0xFF7B1FA2)),
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
                      leading: const Icon(Icons.group_outlined, color: Color(0xFF7B1FA2)),
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
