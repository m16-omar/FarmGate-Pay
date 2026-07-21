import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedCategory = 'All';
  bool _showPushBanner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header (Back Arrow, Title, Subtext, Notification Bell, Avatar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Stay updated on your orders and account',
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

            // 2. Filter Category Chips Scroll Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  _buildCategoryChip('All', null),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Orders', Icons.inventory_2_outlined),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Payments', Icons.credit_card_outlined),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Promotions', Icons.card_giftcard_outlined),
                  const SizedBox(width: 8),
                  _buildCategoryChip('System', Icons.settings_outlined),
                  const SizedBox(width: 8),
                  // Tune adjustment icon
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: const Center(child: Icon(Icons.tune_outlined, color: Colors.grey, size: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 3. Scrollable List of Grouped Notifications
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Push Banner
                  if (_showPushBanner) ...[
                    _buildPushNotificationBanner(),
                    const SizedBox(height: 20),
                  ],

                  // Today Section
                  const Text('Today', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  _buildNotificationTile(
                    title: 'Order Delivered',
                    body: 'Your order #ORD-2024-1057 (Rice 1,200 kg) has been delivered. Please confirm receipt.',
                    time: '8:15 AM',
                    icon: Icons.local_shipping_outlined,
                    iconBg: const Color(0xFFFFF3E0),
                    iconColor: Colors.orange,
                    isUnread: true,
                  ),
                  _buildNotificationTile(
                    title: 'Payment Successful',
                    body: 'Your payment of ₦600,000 to Green Fields Ltd was successful.',
                    time: '7:45 AM',
                    icon: Icons.check,
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: const Color(0xFF2E7D32),
                    isUnread: true,
                  ),
                  _buildNotificationTile(
                    title: 'Order Confirmed by Supplier',
                    body: 'ABC Farms has confirmed your order #ORD-2024-1056 (Maize 2,500 kg).',
                    time: 'Yesterday, 4:30 PM',
                    icon: Icons.assignment_outlined,
                    iconBg: const Color(0xFFE3F2FD),
                    iconColor: Colors.blue,
                    isUnread: true,
                  ),
                  _buildNotificationTile(
                    title: 'Order On The Way',
                    body: 'Your order #ORD-2024-1056 (Maize 2,500 kg) is on the way and will arrive today by 4:30 PM.',
                    time: 'Yesterday, 11:20 AM',
                    icon: Icons.local_shipping_outlined,
                    iconBg: const Color(0xFFFFF3E0),
                    iconColor: Colors.orange,
                    isUnread: true,
                  ),
                  const SizedBox(height: 20),

                  // This Week Section
                  const Text('This Week', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  _buildNotificationTile(
                    title: 'Refund Processed',
                    body: 'Your refund of ₦120,000 has been processed successfully.',
                    time: 'May 8, 2024',
                    icon: Icons.account_balance_wallet_outlined,
                    iconBg: const Color(0xFFEDE7F6),
                    iconColor: Colors.purple,
                    isUnread: true,
                  ),
                  _buildNotificationTile(
                    title: 'Special Offer for Buyers',
                    body: 'Get 5% off on your next order above ₦500,000. Valid till May 15, 2024.',
                    time: 'May 7, 2024',
                    icon: Icons.percent_outlined,
                    iconBg: const Color(0xFFFFF3E0),
                    iconColor: Colors.orange,
                    isUnread: false,
                  ),
                  _buildNotificationTile(
                    title: 'Security Alert',
                    body: 'New login detected on your account from Chrome on Windows.',
                    time: 'May 6, 2024',
                    icon: Icons.security_outlined,
                    iconBg: const Color(0xFFECEFF1),
                    iconColor: Colors.blueGrey,
                    isUnread: false,
                  ),
                  const SizedBox(height: 20),

                  // Earlier Section
                  const Text('Earlier', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 10),
                  _buildNotificationTile(
                    title: 'Money Added',
                    body: '₦500,000 was added to your wallet via GTBank.',
                    time: 'May 5, 2024',
                    icon: Icons.add_card_outlined,
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: const Color(0xFF2E7D32),
                    isUnread: false,
                  ),
                  _buildNotificationTile(
                    title: 'Order Placed',
                    body: 'You placed a new order #ORD-2024-1055 (Tomato 800 kg).',
                    time: 'May 4, 2024',
                    icon: Icons.assignment_outlined,
                    iconBg: const Color(0xFFE3F2FD),
                    iconColor: Colors.blue,
                    isUnread: false,
                  ),
                  const SizedBox(height: 24),

                  // Clear all notifications footer row
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7F0),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.delete_outline, color: Color(0xFF2E7D32), size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Clear all notifications',
                            style: TextStyle(color: Color(0xFF2E7D32), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Color(0xFF2E7D32), size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData? icon) {
    bool isSelected = _selectedCategory == label;
    Color bg = isSelected ? const Color(0xFFE8F5E9) : Colors.white;
    Color textCol = isSelected ? const Color(0xFF2E7D32) : Colors.grey;
    Color borderCol = isSelected ? const Color(0xFF81C784) : const Color(0xFFE2E2DF);

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderCol),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textCol, size: 13),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textCol),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPushNotificationBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                child: const Center(child: Icon(Icons.notifications_active_outlined, color: Color(0xFF2E7D32), size: 18)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enable Push Notifications',
                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Allow push notifications to get real-time updates about your orders and deliveries.',
                      style: TextStyle(fontSize: 9, color: Colors.grey, height: 1.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 0,
                ),
                child: const Text('Enable', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showPushBanner = false;
                });
              },
              child: const Icon(Icons.close, size: 14, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String body,
    required String time,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Center(child: Icon(icon, color: iconColor, size: 16)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                    Text(time, style: const TextStyle(fontSize: 8.5, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(fontSize: 9.8, color: Colors.grey, height: 1.3, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Center(
            child: isUnread
                ? Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
                  )
                : const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
