import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _todayNotifications = [
    {
      'title': 'New Order Received',
      'body': 'You have a new order for Maize (2,500 kg)',
      'orderNo': 'Order #FGT-4587',
      'time': '9:30 AM',
      'category': 'Orders',
      'isRead': false,
      'icon': Icons.shopping_bag_outlined,
      'iconBg': const Color(0xFFE8F5E9),
      'iconColor': const Color(0xFF2E7D32),
    },
    {
      'title': 'Delivery In Transit',
      'body': 'Your delivery of Rice (1,800 kg) is on the way',
      'orderNo': 'Order #FGT-4583',
      'time': '8:15 AM',
      'category': 'Orders',
      'isRead': false,
      'icon': Icons.local_shipping_outlined,
      'iconBg': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF1565C0),
    },
    {
      'title': 'Payment Received',
      'body': 'Payment of ₦864,000 has been received',
      'orderNo': 'Order #FGT-4583',
      'time': '7:45 AM',
      'category': 'Payments',
      'isRead': false,
      'icon': Icons.monetization_on_outlined,
      'iconBg': const Color(0xFFE8F5E9),
      'iconColor': const Color(0xFF2E7D32),
    },
    {
      'title': 'Order Pending Confirmation',
      'body': 'Please confirm the availability of Groundnut (1,200 kg)',
      'orderNo': 'Order #FGT-4586',
      'time': '6:20 AM',
      'category': 'Orders',
      'isRead': false,
      'icon': Icons.warning_amber_rounded,
      'iconBg': const Color(0xFFFFF3E0),
      'iconColor': const Color(0xFFE65100),
    },
  ];

  final List<Map<String, dynamic>> _yesterdayNotifications = [
    {
      'title': 'New Promotion Available',
      'body': 'Check out our latest promotion and boost your sales!',
      'time': 'Yesterday, 10:00 PM',
      'category': 'Promos',
      'isRead': true,
      'icon': Icons.campaign_outlined,
      'iconBg': const Color(0xFFF3E5F5),
      'iconColor': const Color(0xFF7B1FA2),
    },
    {
      'title': 'New Review Received',
      'body': 'ABC Agro Ltd gave you a 5-star review',
      'actionText': 'View Review',
      'time': 'Yesterday, 6:30 PM',
      'category': 'System',
      'isRead': true,
      'icon': Icons.star_border,
      'iconBg': const Color(0xFFFFF8E1),
      'iconColor': const Color(0xFFFFB300),
    },
    {
      'title': 'New Team Member',
      'body': 'Hauwa Isah has been added to your team',
      'time': 'Yesterday, 4:10 PM',
      'category': 'System',
      'isRead': true,
      'icon': Icons.people_outline,
      'iconBg': const Color(0xFFE0F2F1),
      'iconColor': const Color(0xFF00796B),
    },
    {
      'title': 'Account Verified',
      'body': 'Congratulations! Your account has been verified',
      'actionText': 'View Details',
      'time': 'Yesterday, 2:20 PM',
      'category': 'System',
      'isRead': true,
      'icon': Icons.verified_user_outlined,
      'iconBg': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF1565C0),
    },
    {
      'title': 'Welcome to FarmGate!',
      'body': 'Thank you for joining us. Let\'s grow together!',
      'time': 'Yesterday, 9:15 AM',
      'category': 'System',
      'isRead': true,
      'icon': Icons.card_giftcard_outlined,
      'iconBg': const Color(0xFFFCE4EC),
      'iconColor': const Color(0xFFC2185B),
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _todayNotifications) {
        n['isRead'] = true;
      }
      for (var n in _yesterdayNotifications) {
        n['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read!'), backgroundColor: Color(0xFF2E7D32)),
    );
  }

  List<Map<String, dynamic>> _filterList(List<Map<String, dynamic>> list) {
    if (_selectedCategory == 'All') return list;
    return list.where((n) => n['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final todayList = _filterList(_todayNotifications);
    final yesterdayList = _filterList(_yesterdayNotifications);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Notifications',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Stay updated with your activity',
                          style: TextStyle(fontSize: 10, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: const Icon(Icons.search, color: Color(0xFF666666), size: 20),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: const Icon(Icons.tune, color: Color(0xFF666666), size: 20),
                  ),
                ],
              ),
            ),

            // 2. Filter Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  _buildCategoryChip('All', 12),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Orders', 5),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Payments', 3),
                  const SizedBox(width: 8),
                  _buildCategoryChip('System', 4),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Promos', 1),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 3. Scrollable List Grouped by Today / Yesterday
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Today Section
                  if (todayList.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        TextButton.icon(
                          onPressed: _markAllAsRead,
                          icon: const Icon(Icons.check_circle_outline, color: Color(0xFF2E7D32), size: 14),
                          label: const Text(
                            'Mark all as read',
                            style: TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...todayList.map((n) => _buildNotificationCard(n)),
                    const SizedBox(height: 20),
                  ],

                  // Yesterday Section
                  if (yesterdayList.isNotEmpty) ...[
                    const Text(
                      'Yesterday',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    const SizedBox(height: 10),
                    ...yesterdayList.map((n) => _buildNotificationCard(n)),
                    const SizedBox(height: 16),
                  ],

                  // Bottom Promo Bell Banner
                  _buildEnableNotificationsBanner(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, int count) {
    bool isSelected = _selectedCategory == label;
    Color bg;
    Color textColor;
    if (isSelected) {
      bg = const Color(0xFF2E7D32);
      textColor = Colors.white;
    } else {
      textColor = const Color(0xFF555555);
      switch (label) {
        case 'Orders':
          bg = const Color(0xFFFFF3E0);
          break;
        case 'Payments':
          bg = const Color(0xFFE3F2FD);
          break;
        case 'System':
          bg = const Color(0xFFF1F1EF);
          break;
        case 'Promos':
          bg = const Color(0xFFF3E5F5);
          break;
        default:
          bg = Colors.white;
      }
    }

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : const Color(0xFF555555),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> n) {
    bool isRead = n['isRead'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: n['iconBg'],
                shape: BoxShape.circle,
              ),
              child: Icon(n['icon'], color: n['iconColor'], size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        n['title'],
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                      Text(
                        n['time'],
                        style: const TextStyle(fontSize: 9, color: Color(0xFF999999)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n['body'],
                    style: const TextStyle(fontSize: 11, color: Color(0xFF666666), height: 1.3, fontWeight: FontWeight.w500),
                  ),
                  if (n['orderNo'] != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      n['orderNo'],
                      style: const TextStyle(fontSize: 10, color: Color(0xFF999999), fontWeight: FontWeight.bold),
                    ),
                  ],
                  if (n['actionText'] != null) ...[
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        n['actionText'],
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Unread / Read status dot
            Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isRead ? Colors.grey[300] : const Color(0xFF2E7D32),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnableNotificationsBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFBEFD6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Never Miss an Update!',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Enable push notifications to stay updated on orders, payments and more.',
                  style: TextStyle(fontSize: 10, color: Color(0xFF777777), height: 1.3, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward, size: 14),
                  label: const Text('Enable Notifications', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Custom painted notifications bell illustration
          SizedBox(
            width: 70,
            height: 70,
            child: CustomPaint(
              painter: _BellIllustrationPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BellIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Green bell body
    final bellPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill;

    final bellHangerPaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Hanger top loop
    canvas.drawCircle(Offset(w * 0.5, h * 0.2), 6, bellHangerPaint);

    // Bell dome
    final path = Path()
      ..moveTo(w * 0.35, h * 0.7)
      ..cubicTo(w * 0.35, h * 0.3, w * 0.65, h * 0.3, w * 0.65, h * 0.7)
      ..lineTo(w * 0.75, h * 0.75)
      ..lineTo(w * 0.25, h * 0.75)
      ..close();
    canvas.drawPath(path, bellPaint);

    // Bell clapper (bottom circle)
    canvas.drawCircle(Offset(w * 0.5, h * 0.8), 5, Paint()..color = const Color(0xFF1B5E20));

    // Notification badge overlay at top right of the bell
    final badgePaint = Paint()..color = const Color(0xFFC62828)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.75, h * 0.28), 9, badgePaint);

    final textSpan = const TextSpan(
      text: '12',
      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
    );
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
    textPainter.paint(canvas, Offset(w * 0.75 - textPainter.width / 2, h * 0.28 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
