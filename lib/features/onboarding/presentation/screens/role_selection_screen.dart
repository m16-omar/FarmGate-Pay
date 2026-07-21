import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String _selectedRole = 'Farmer'; // Default selection

  final List<Map<String, dynamic>> _roles = [
    {
      'id': 'Farmer',
      'title': 'Farmer',
      'subtitle': 'Log deliveries, track payments, manage crops & harvest inventory.',
      'icon': Icons.eco_outlined,
      'color': const Color(0xFF2E7D32),
      'bg': const Color(0xFFE8F5E9),
    },
    {
      'id': 'Buyer',
      'title': 'Buyer',
      'subtitle': 'Fund escrow, purchase crops, confirm weight, and track logs.',
      'icon': Icons.business_center_outlined,
      'color': const Color(0xFF1565C0),
      'bg': const Color(0xFFE3F2FD),
    },
    {
      'id': 'Cooperative',
      'title': 'Cooperative',
      'subtitle': 'Manage members, bulk aggregate deliveries, and view joint payout ledgers.',
      'icon': Icons.handshake_outlined,
      'color': const Color(0xFFE29A26),
      'bg': const Color(0xFFFFF8E1),
    },
  ];

  void _onContinue() {
    AppUserSession.activeRole = _selectedRole;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow
              InkWell(
                onTap: () => Navigator.pop(context),
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
              const SizedBox(height: 24),

              // Title and Description
              const Text(
                'Choose Your Role',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Select your persona to access your tailored dashboard. All accounts share the same secure backend.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF666666),
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),

              // Roles List
              Expanded(
                child: ListView.builder(
                  itemCount: _roles.length,
                  itemBuilder: (context, index) {
                    final role = _roles[index];
                    final isSelected = _selectedRole == role['id'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRole = role['id'];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected ? role['color'] : const Color(0xFFE2E2DF),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected ? role['color'].withOpacity(0.04) : Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Role Icon Circle
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: role['bg'],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                role['icon'],
                                color: role['color'],
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // Text contents
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    role['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? role['color'] : const Color(0xFF333333),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    role['subtitle'],
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF777777),
                                      height: 1.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Radio indicator
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? role['color'] : const Color(0xFFBBBBBB),
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: role['color'],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Continue to Login',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
