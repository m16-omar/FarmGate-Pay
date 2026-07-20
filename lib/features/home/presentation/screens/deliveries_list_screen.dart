import 'package:flutter/material.dart';
import 'delivery_details_screen.dart';
import 'delivery_screen.dart';

class DeliveriesListScreen extends StatefulWidget {
  const DeliveriesListScreen({super.key});

  @override
  State<DeliveriesListScreen> createState() => _DeliveriesListScreenState();
}

class _DeliveriesListScreenState extends State<DeliveriesListScreen> {
  String _selectedStatus = 'All';
  final _searchController = TextEditingController();
  
  final List<Map<String, dynamic>> _allDeliveries = [
    {
      'crop': 'Maize',
      'weight': '2,500 kg',
      'buyer': 'ABC Agro Ltd',
      'date': 'May 20, 2025 • 08:30 AM',
      'location': 'Kaduna, Kaduna State',
      'status': 'Pending Confirmation',
      'amount': '₦1,125,000',
    },
    {
      'crop': 'Rice',
      'weight': '1,800 kg',
      'buyer': 'Greenfield Farms',
      'date': 'May 18, 2025 • 10:15 AM',
      'location': 'Zaria, Kaduna State',
      'status': 'Paid',
      'amount': '₦864,000',
    },
    {
      'crop': 'Tomato',
      'weight': '600 kg',
      'buyer': 'FreshMart Ltd',
      'date': 'May 17, 2025 • 02:45 PM',
      'location': 'Kano, Kano State',
      'status': 'Paid',
      'amount': '₦312,000',
    },
    {
      'crop': 'Groundnut',
      'weight': '1,200 kg',
      'buyer': 'Niger Foods',
      'date': 'May 16, 2025 • 09:20 AM',
      'location': 'Minna, Niger State',
      'status': 'In Transit',
      'amount': '₦540,000',
    },
    {
      'crop': 'Yam',
      'weight': '900 kg',
      'buyer': 'Royal Agro Ltd',
      'date': 'May 15, 2025 • 11:05 AM',
      'location': 'Jos, Plateau State',
      'status': 'Cancelled',
      'amount': '₦405,000',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredDeliveries {
    return _allDeliveries.where((d) {
      // 1. Status Filter
      if (_selectedStatus != 'All') {
        if (_selectedStatus == 'Pending' && d['status'] != 'Pending Confirmation') return false;
        if (_selectedStatus == 'Confirmed' && d['status'] != 'In Transit') return false;
        if (_selectedStatus == 'Paid' && d['status'] != 'Paid') return false;
        if (_selectedStatus == 'Cancelled' && d['status'] != 'Cancelled') return false;
      }
      // 2. Search Filter
      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        final crop = d['crop'].toString().toLowerCase();
        final buyer = d['buyer'].toString().toLowerCase();
        if (!crop.contains(query) && !buyer.contains(query)) return false;
      }
      return true;
    }).toList();
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Pending Confirmation':
        return const Color(0xFFFFF3E0);
      case 'Paid':
        return const Color(0xFFE8F5E9);
      case 'In Transit':
        return const Color(0xFFE3F2FD);
      case 'Cancelled':
        return const Color(0xFFFFEBEE);
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pending Confirmation':
        return const Color(0xFFE65100);
      case 'Paid':
        return const Color(0xFF2E7D32);
      case 'In Transit':
        return const Color(0xFF1565C0);
      case 'Cancelled':
        return const Color(0xFFC62828);
      default:
        return Colors.grey[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deliveries = _filteredDeliveries;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  // Optional back button
                  InkWell(
                    onTap: () {},
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
                          'Deliveries',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Track and manage all your deliveries',
                          style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // Filter icon
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
                  const SizedBox(width: 8),
                  // + New Delivery Button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DeliveryScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'New Delivery',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pending'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Confirmed'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Paid'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Cancelled'),
                ],
              ),
            ),
            const SizedBox(height: 6),

            // 3. Search and Sort Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFF999999), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (_) => setState(() {}),
                              decoration: const InputDecoration(
                                hintText: 'Search deliveries...',
                                hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 13),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E2DF)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.swap_vert, color: Color(0xFF333333), size: 18),
                        SizedBox(width: 4),
                        Text(
                          'Sort',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. Deliveries List
            Expanded(
              child: deliveries.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.assignment_late_outlined, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'No deliveries found matching filters.',
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: deliveries.length + 1, // Add space at bottom or promo banner
                      itemBuilder: (ctx, idx) {
                        if (idx == deliveries.length) {
                          // Bottom Promo Banner
                          return _buildBottomPromo();
                        }
                        
                        final d = deliveries[idx];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E2DF)),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeliveryDetailsScreen(deliveryData: d),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Crop Image Circle
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F7F5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getCropEmoji(d['crop']),
                                        style: const TextStyle(fontSize: 28),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              d['crop'],
                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE8F5E9),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                d['weight'],
                                                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        _buildRowDetail(Icons.person_outline, d['buyer']),
                                        const SizedBox(height: 4),
                                        _buildRowDetail(Icons.calendar_today_outlined, d['date']),
                                        const SizedBox(height: 4),
                                        _buildRowDetail(Icons.location_on_outlined, d['location']),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getStatusBgColor(d['status']),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          d['status'] == 'Pending Confirmation' ? 'Pending' : d['status'],
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: _getStatusTextColor(d['status']),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Total Amount',
                                        style: TextStyle(fontSize: 8, color: Color(0xFF999999), fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        d['amount'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: d['status'] == 'Paid' ? const Color(0xFF2E7D32) : const Color(0xFF333333),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 18),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedStatus == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF555555),
          ),
        ),
      ),
    );
  }

  Widget _buildRowDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: const Color(0xFF999999)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: Color(0xFF777777), fontWeight: FontWeight.w500),
        ),
      ],
    );
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

  Widget _buildBottomPromo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
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
                  'Instant Payments for Every Delivery',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Confirm deliveries and get paid instantly once the buyer releases payment.',
                  style: TextStyle(fontSize: 10, color: Color(0xFF777777), height: 1.3, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2E7D32)),
                    ),
                    child: const Text(
                      'Learn More',
                      style: TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Custom check shield drawing
          SizedBox(
            width: 60,
            height: 70,
            child: CustomPaint(
              painter: _ShieldIllustrationPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShieldIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Green shield shape
    final shieldPaint = Paint()
      ..color = const Color(0xFFE8F5E9)
      ..style = PaintingStyle.fill;

    final shieldBorderPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(w * 0.2, h * 0.25)
      ..lineTo(w * 0.8, h * 0.25)
      ..quadraticBezierTo(w * 0.8, h * 0.55, w * 0.5, h * 0.85)
      ..quadraticBezierTo(w * 0.2, h * 0.55, w * 0.2, h * 0.25)
      ..close();

    canvas.drawPath(path, shieldPaint);
    canvas.drawPath(path, shieldBorderPaint);

    // Checkmark inside shield
    final checkPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final checkPath = Path()
      ..moveTo(w * 0.38, h * 0.45)
      ..lineTo(w * 0.48, h * 0.55)
      ..lineTo(w * 0.65, h * 0.38);
    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
