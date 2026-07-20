import 'package:flutter/material.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> deliveryData;

  const DeliveryDetailsScreen({super.key, required this.deliveryData});

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Pending Confirmation':
      case 'In Transit':
        return const Color(0xFFFFF3E0);
      case 'Paid':
        return const Color(0xFFE8F5E9);
      case 'Cancelled':
        return const Color(0xFFFFEBEE);
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pending Confirmation':
      case 'In Transit':
        return const Color(0xFFE65100);
      case 'Paid':
        return const Color(0xFF2E7D32);
      case 'Cancelled':
        return const Color(0xFFC62828);
      default:
        return Colors.grey[700]!;
    }
  }

  String _getCropEmoji(String crop) {
    switch (crop) {
      case 'Maize':
        return '🌽';
      case 'Rice':
        return '🌾';
      case 'Tomato':
        return '🍅';
      case 'Groundnut':
        return '🥜';
      case 'Yam':
        return '🥔';
      default:
        return '📦';
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = deliveryData['status'] as String;
    final crop = deliveryData['crop'] as String;
    final weight = deliveryData['weight'] as String;
    final buyer = deliveryData['buyer'] as String;
    final date = deliveryData['date'] as String;
    final location = deliveryData['location'] as String;
    final amount = deliveryData['amount'] as String;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Bar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
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
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Delivery Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusBgColor(status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: _getStatusTextColor(status),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // 2. Crop Details Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF9), // Warm tint background
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: Row(
                        children: [
                          // Custom painted crop/maize or emoji visual
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE2E2DF)),
                            ),
                            child: Center(
                              child: Text(
                                _getCropEmoji(crop),
                                style: const TextStyle(fontSize: 36),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      crop,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.eco, color: Color(0xFF2E7D32), size: 16),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    weight,
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildIconDetailRow(Icons.person_outline, 'Buyer', buyer, showPhone: true),
                                const SizedBox(height: 6),
                                _buildIconDetailRow(Icons.calendar_today_outlined, 'Delivery Date', date),
                                const SizedBox(height: 6),
                                _buildIconDetailRow(Icons.location_on_outlined, 'Delivery Location', location),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. Expected Payment Card
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
                              children: [
                                const Text(
                                  'Expected Payment',
                                  style: TextStyle(fontSize: 11, color: Color(0xFF999999), fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  amount,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  '₦450 per kg',
                                  style: TextStyle(fontSize: 10, color: Color(0xFF777777), fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 48,
                            color: const Color(0xFFE2E2DF),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Payment Method',
                                  style: TextStyle(fontSize: 11, color: Color(0xFF999999), fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: const [
                                    Icon(Icons.verified_user, color: Color(0xFF2E7D32), size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Instant Settlement',
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'You will receive payment instantly once delivery is confirmed.',
                                  style: TextStyle(fontSize: 9, color: Color(0xFF888888), height: 1.3, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 4. Delivery Breakdown Section
                    const Text(
                      'Delivery Breakdown',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildBreakdownCol(Icons.balance, 'Weight', weight),
                              _buildBreakdownCol(Icons.tag, 'Price / kg', '₦450'),
                              _buildBreakdownCol(Icons.layers_outlined, 'Subtotal', amount),
                              _buildBreakdownCol(Icons.account_balance_wallet_outlined, 'Fees', 'Free', valueColor: const Color(0xFF2E7D32)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Color(0xFFF1F1EF)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                              ),
                              Text(
                                amount,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 5. Delivery Status Stepper
                    const Text(
                      'Delivery Status',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    const SizedBox(height: 16),

                    _buildStatusStepper(status),
                    const SizedBox(height: 24),

                    // 6. Safe & Secure Banner
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFBEFD6)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.shield_outlined, color: Color(0xFFE65100), size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Safe & Secure',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Your delivery and payment are protected by FarmGate Pay escrow.',
                                  style: TextStyle(fontSize: 10, color: Color(0xFF777777), fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),

            // 7. Bottom Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.forum_outlined, size: 18),
                      label: const Text('Contact Buyer', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF555555),
                        side: const BorderSide(color: Color(0xFFE2E2DF)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: status == 'Paid' || status == 'Cancelled' ? null : () => _showConfirmationDialog(context),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Confirm Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconDetailRow(IconData icon, String label, String value, {bool showPhone = false}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF999999)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label: ',
              style: const TextStyle(fontSize: 11, color: Color(0xFF999999), fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        if (showPhone) ...[
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
            child: const Icon(Icons.phone, color: Color(0xFF2E7D32), size: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildBreakdownCol(IconData icon, String label, String value, {Color? valueColor}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Color(0xFFF7F7F5), shape: BoxShape.circle),
          child: Icon(icon, color: const Color(0xFF777777), size: 16),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 9, color: Color(0xFF999999), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: valueColor ?? const Color(0xFF333333)),
        ),
      ],
    );
  }

  Widget _buildStatusStepper(String status) {
    bool isCompleted = status == 'Paid';
    bool inTransit = status == 'In Transit' || status == 'Pending Confirmation';

    return Column(
      children: [
        _buildStepperItem(
          isActive: true,
          isDone: true,
          title: 'Order Placed',
          dateTime: 'May 19, 2025 • 10:15 AM',
        ),
        _buildStepLineWidget(isDone: true),
        _buildStepperItem(
          isActive: inTransit || isCompleted,
          isDone: isCompleted || status == 'In Transit' || status == 'Pending Confirmation',
          title: 'In Transit',
          dateTime: 'May 20, 2025 • 07:20 AM',
          icon: Icons.local_shipping_outlined,
        ),
        _buildStepLineWidget(isDone: isCompleted),
        _buildStepperItem(
          isActive: isCompleted || status == 'Pending Confirmation',
          isDone: isCompleted,
          title: 'Awaiting Confirmation',
          dateTime: status == 'Pending Confirmation' ? 'Awaiting buyer check' : 'Confirmed',
          icon: Icons.inventory_2_outlined,
        ),
        _buildStepLineWidget(isDone: isCompleted),
        _buildStepperItem(
          isActive: isCompleted,
          isDone: isCompleted,
          title: 'Payment Released',
          dateTime: isCompleted ? 'Settled instantly via Monnify' : 'Escrow held in safety',
          icon: Icons.verified_user_outlined,
        ),
      ],
    );
  }

  Widget _buildStepperItem({
    required bool isActive,
    required bool isDone,
    required String title,
    required String dateTime,
    IconData icon = Icons.check,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stepper Circle
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isDone ? const Color(0xFF2E7D32) : (isActive ? Colors.white : const Color(0xFFF1F1EF)),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDone || isActive ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 14,
              color: isDone ? Colors.white : (isActive ? const Color(0xFF2E7D32) : const Color(0xFF999999)),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isActive ? const Color(0xFF333333) : const Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateTime,
                style: const TextStyle(fontSize: 10, color: Color(0xFF777777), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepLineWidget({required bool isDone}) {
    return Container(
      width: 1.5,
      height: 24,
      margin: const EdgeInsets.only(left: 13), // Aligns with center of 28px circle
      color: isDone ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
            SizedBox(width: 10),
            Text('Confirm Intake'),
          ],
        ),
        content: const Text(
          'Confirming delivery will trigger payment release of the escrow amount instantly to your bank account.',
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
                  content: Text('Delivery confirmed! Payment has been released to your bank.'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
