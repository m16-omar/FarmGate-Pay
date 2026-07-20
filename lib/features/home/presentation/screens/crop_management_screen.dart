import 'package:flutter/material.dart';

class CropManagementScreen extends StatefulWidget {
  const CropManagementScreen({super.key});

  @override
  State<CropManagementScreen> createState() => _CropManagementScreenState();
}

class _CropManagementScreenState extends State<CropManagementScreen> {
  String _selectedFilter = 'All Crops';

  final List<Map<String, dynamic>> _allCrops = [
    {
      'name': 'Maize',
      'emoji': '🌽',
      'plantedDate': 'Planted on May 10, 2025',
      'area': '2.5 Acres',
      'harvestDate': 'Estimated Harvest: Aug 15, 2025',
      'status': 'Growing',
      'progress': 0.65,
      'statusColor': const Color(0xFF2E7D32),
      'statusBg': const Color(0xFFE8F5E9),
    },
    {
      'name': 'Rice',
      'emoji': '🌾',
      'plantedDate': 'Planted on Apr 22, 2025',
      'area': '1.8 Acres',
      'harvestDate': 'Estimated Harvest: Jul 28, 2025',
      'status': 'Growing',
      'progress': 0.40,
      'statusColor': const Color(0xFF2E7D32),
      'statusBg': const Color(0xFFE8F5E9),
    },
    {
      'name': 'Groundnut',
      'emoji': '🥜',
      'plantedDate': 'Planted on Mar 15, 2025',
      'area': '2.0 Acres',
      'harvestDate': 'Estimated Harvest: Jun 25, 2025',
      'status': 'Harvest Ready',
      'progress': 0.90,
      'statusColor': const Color(0xFFE65100),
      'statusBg': const Color(0xFFFFF3E0),
    },
    {
      'name': 'Tomato',
      'emoji': '🍅',
      'plantedDate': 'Planted on Feb 10, 2025',
      'area': '0.5 Acres',
      'harvestDate': 'Last Harvest: May 20, 2025',
      'status': 'Harvested',
      'totalHarvest': '320 kg',
      'statusColor': const Color(0xFF7B1FA2),
      'statusBg': const Color(0xFFF3E5F5),
    },
    {
      'name': 'Pepper',
      'emoji': '🫑',
      'plantedDate': 'Planted on Jan 18, 2025',
      'area': '0.6 Acres',
      'harvestDate': 'Last Harvest: Apr 30, 2025',
      'status': 'Harvested',
      'totalHarvest': '210 kg',
      'statusColor': const Color(0xFF7B1FA2),
      'statusBg': const Color(0xFFF3E5F5),
    },
  ];

  List<Map<String, dynamic>> get _filteredCrops {
    if (_selectedFilter == 'All Crops') return _allCrops;
    return _allCrops.where((c) => c['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final crops = _filteredCrops;

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Crop Management',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Manage your crops and inventory',
                          style: TextStyle(fontSize: 10, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // + Add Crop Button
                  InkWell(
                    onTap: () => _showAddCropDialog(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Add Crop',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
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
                  _buildFilterChip('All Crops', Icons.eco_outlined),
                  const SizedBox(width: 8),
                  _buildFilterChip('Growing', Icons.spa_outlined),
                  const SizedBox(width: 8),
                  _buildFilterChip('Harvest Ready', Icons.grass),
                  const SizedBox(width: 8),
                  _buildFilterChip('Harvested', Icons.inventory_2_outlined),
                  const SizedBox(width: 8),
                  _buildFilterChip('Archived', Icons.archive_outlined),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 3. Scrollable Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Overview stats
                  _buildOverviewSection(),
                  const SizedBox(height: 20),

                  // Your Crops Title with Sort Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Crops',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E2DF)),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Sort by: Newest',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF555555)),
                            ),
                            Icon(Icons.arrow_drop_down, color: Color(0xFF555555), size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Crops list
                  ...crops.map((c) => _buildCropCard(c)),
                  const SizedBox(height: 16),

                  // Bottom Insights Banner
                  _buildInsightsBanner(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = _selectedFilter == label;
    IconData displayIcon = icon;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE2E2DF),
          ),
        ),
        child: Row(
          children: [
            Icon(displayIcon, size: 14, color: isSelected ? Colors.white : const Color(0xFF555555)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overview',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Text(
                      'This Season',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF555555)),
                    ),
                    Icon(Icons.arrow_drop_down, color: Color(0xFF555555), size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOverviewCard(
                icon: Icons.eco_outlined,
                iconColor: const Color(0xFF2E7D32),
                title: 'Total Crops',
                value: '5',
                subtext: 'All time',
              ),
              _buildOverviewCard(
                icon: Icons.spa_outlined,
                iconColor: const Color(0xFF2E7D32),
                title: 'Growing',
                value: '3',
                subtext: 'Active crops',
              ),
              _buildOverviewCard(
                icon: Icons.grass,
                iconColor: const Color(0xFFE65100),
                title: 'Harvest Ready',
                value: '1',
                subtext: 'Ready to harvest',
              ),
              _buildOverviewCard(
                icon: Icons.inventory_2_outlined,
                iconColor: const Color(0xFF7B1FA2),
                title: 'Total Inventory',
                value: '2,450 kg',
                subtext: 'Across all crops',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtext,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 8, color: Color(0xFF888888), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 1),
          Text(
            subtext,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 7, color: Color(0xFFBBBBBB), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCropCard(Map<String, dynamic> c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Emoji Circle
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Center(
                  child: Text(
                    c['emoji'],
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
                          c['name'],
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.eco, color: Color(0xFF2E7D32), size: 14),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildRowDetail(Icons.calendar_today_outlined, c['plantedDate']),
                    const SizedBox(height: 4),
                    _buildRowDetail(Icons.grid_view_outlined, c['area']),
                    const SizedBox(height: 4),
                    _buildRowDetail(Icons.history_toggle_off_outlined, c['harvestDate']),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status & Progress / Harvest details
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: c['statusBg'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      c['status'],
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: c['statusColor'],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (c['totalHarvest'] != null) ...[
                    const Text(
                      'Total Harvest',
                      style: TextStyle(fontSize: 8, color: Color(0xFF999999), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      c['totalHarvest'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: c['statusColor'],
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Progress',
                      style: TextStyle(fontSize: 8, color: Color(0xFF999999), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${(c['progress'] * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: c['statusColor'],
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: c['progress'],
                          backgroundColor: const Color(0xFFF1F1EF),
                          valueColor: AlwaysStoppedAnimation<Color>(c['statusColor']),
                          minHeight: 3,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 11, color: const Color(0xFF999999)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: Color(0xFF777777), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildInsightsBanner() {
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
                  'Track Better. Grow Better.',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Monitor crop health, get smart insights and increase your yield.',
                  style: TextStyle(fontSize: 10, color: Color(0xFF777777), height: 1.3, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Text('View Crop Insights', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Custom painted clipboard check illustration
          SizedBox(
            width: 60,
            height: 70,
            child: CustomPaint(
              painter: _ClipboardIllustrationPainter(),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCropDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Crop Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              decoration: InputDecoration(
                labelText: 'Crop Name',
                hintText: 'e.g., Cassava, Cocoa',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Acreage',
                hintText: 'e.g., 2.5',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                  content: Text('Crop added successfully to tracking!'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClipboardIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Clipboard background
    final boardPaint = Paint()
      ..color = const Color(0xFFF1F1EF)
      ..style = PaintingStyle.fill;
    
    final boardBorderPaint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.15, h * 0.15, w * 0.85, h * 0.85),
      const Radius.circular(8),
    );
    canvas.drawRRect(rect, boardPaint);
    canvas.drawRRect(rect, boardBorderPaint);

    // Clipboard top binder clip
    final clipPaint = Paint()
      ..color = const Color(0xFF333333)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(w * 0.35, h * 0.08, w * 0.65, h * 0.2),
        const Radius.circular(4),
      ),
      clipPaint,
    );

    // Green check circle on page
    final checkBgPaint = Paint()
      ..color = const Color(0xFFE8F5E9)
      ..style = PaintingStyle.fill;
    
    final checkBorderPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(w * 0.5, h * 0.5), 14, checkBgPaint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), 14, checkBorderPaint);

    // Checkmark inside circle
    final checkPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final checkPath = Path()
      ..moveTo(w * 0.42, h * 0.5)
      ..lineTo(w * 0.48, h * 0.56)
      ..lineTo(w * 0.58, h * 0.44);
    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
