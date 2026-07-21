import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AnalyticsScreen({super.key, this.onBack});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedCategory = 'Overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else if (widget.onBack != null) {
                          widget.onBack!();
                        }
                      },
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
                            'Analytics',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Track your performance and grow more',
                            style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    // Month Selector Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.calendar_today_outlined, color: Color(0xFF666666), size: 14),
                          SizedBox(width: 6),
                          Text(
                            'This Month',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Category Chips Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    _buildCategoryChip('Overview'),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Deliveries'),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Earnings'),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Crops'),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Customers'),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 3. Grid Metrics Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.45,
                  children: [
                    _buildMetricCard(
                      title: 'Total Earnings',
                      value: '₦2,450,000',
                      trend: '18.5%',
                      isUp: true,
                      color: const Color(0xFF2E7D32),
                    ),
                    _buildMetricCard(
                      title: 'Total Deliveries',
                      value: '23',
                      trend: '15.0%',
                      isUp: true,
                      color: const Color(0xFFE65100),
                    ),
                    _buildMetricCard(
                      title: 'New Customers',
                      value: '12',
                      trend: '9.1%',
                      isUp: true,
                      color: const Color(0xFF1565C0),
                    ),
                    _buildMetricCard(
                      title: 'Completion Rate',
                      value: '95%',
                      trend: '4.6%',
                      isUp: true,
                      color: const Color(0xFF7B1FA2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 4. Earnings Trend Line Chart Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          'Earnings Trend',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
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
                                'Daily',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF555555)),
                              ),
                              Icon(Icons.arrow_drop_down, color: Color(0xFF555555), size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Line Chart Painter
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _MiniTrendLineChartPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. Performance by Crop Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Performance by Crop',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E2DF)),
                ),
                child: Column(
                  children: [
                    _buildCropPerformanceBar(
                      emoji: '🌽',
                      cropName: 'Maize',
                      deliveries: '10',
                      earnings: '₦1,125,000',
                      pctShare: 0.459,
                    ),
                    const SizedBox(height: 16),
                    _buildCropPerformanceBar(
                      emoji: '🌾',
                      cropName: 'Rice',
                      deliveries: '6',
                      earnings: '₦864,000',
                      pctShare: 0.353,
                    ),
                    const SizedBox(height: 16),
                    _buildCropPerformanceBar(
                      emoji: '🥜',
                      cropName: 'Groundnut',
                      deliveries: '4',
                      earnings: '₦312,000',
                      pctShare: 0.127,
                    ),
                    const SizedBox(height: 16),
                    _buildCropPerformanceBar(
                      emoji: '🍅',
                      cropName: 'Tomato',
                      deliveries: '3',
                      earnings: '₦149,000',
                      pctShare: 0.061,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 6. Business Insights Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Insights',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildInsightCard(
                      icon: Icons.trending_up,
                      title: 'Great Job!',
                      description: 'Your earnings increased\nby 18.5% this month.',
                      color: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                    ),
                    const SizedBox(width: 10),
                    _buildInsightCard(
                      icon: Icons.access_time,
                      title: 'Busiest Day',
                      description: 'Tuesdays - Most deliveries\ncompleted on Tuesdays.',
                      color: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF1565C0),
                    ),
                    const SizedBox(width: 10),
                    _buildInsightCard(
                      icon: Icons.star_border,
                      title: 'Top Crop',
                      description: 'Maize - Your best\nperforming crop this month.',
                      color: const Color(0xFFFFFDE7),
                      iconColor: const Color(0xFFF57F17),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 7. Bottom Growth Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.show_chart, color: Color(0xFF2E7D32), size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Keep Growing Your Business!',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'More deliveries, more earnings. Let\'s make this month even better.',
                            style: TextStyle(fontSize: 9, color: Color(0xFF555555), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      child: const Text('View Tips', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
    required bool isUp,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E2DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF888888)),
              ),
              Icon(Icons.show_chart, color: color.withOpacity(0.3), size: 16),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    isUp ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isUp ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                    size: 10,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '$trend ',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: isUp ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                    ),
                  ),
                  const Text(
                    'vs last month',
                    style: TextStyle(fontSize: 8, color: Color(0xFFBBBBBB)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCropPerformanceBar({
    required String emoji,
    required String cropName,
    required String deliveries,
    required String earnings,
    required double pctShare,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(color: Color(0xFFF7F7F5), shape: BoxShape.circle),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 18))),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cropName,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  Text(
                    earnings,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$deliveries deliveries',
                    style: const TextStyle(fontSize: 9, color: Color(0xFF999999)),
                  ),
                  Text(
                    '${(pctShare * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 9, color: Color(0xFF999999), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Linear Progress Indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: pctShare,
                  backgroundColor: const Color(0xFFF1F1EF),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: iconColor),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 9, color: Color(0xFF555555), height: 1.3, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _MiniTrendLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final gridPaint = Paint()
      ..color = const Color(0xFFF1F1EF)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final textStyle = TextStyle(color: Colors.grey[500], fontSize: 9, fontWeight: FontWeight.w500);

    // Left labels
    final leftLabels = ['N300K', 'N200K', 'N100K', 'N0'];
    final double ySpacing = h * 0.8 / 3;
    
    for (int i = 0; i < 4; i++) {
      final double y = ySpacing * i + 10;
      canvas.drawLine(Offset(35, y), Offset(w - 10, y), gridPaint);
      final textSpan = TextSpan(text: leftLabels[i], style: textStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      textPainter.paint(canvas, Offset(2, y - 6));
    }

    // Bottom labels
    final dates = ['May 1', 'May 6', 'May 11', 'May 16', 'May 21', 'May 26', 'May 31'];
    final double xSpacing = (w - 55) / 6;
    
    for (int i = 0; i < 7; i++) {
      final double x = 40 + xSpacing * i;
      final textSpan = TextSpan(text: dates[i], style: textStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, h - 16));
    }

    // Graph Line Curve
    final points = [
      Offset(40, h * 0.8 + 10), // May 1
      Offset(40 + xSpacing, h * 0.55 + 10), // May 6
      Offset(40 + xSpacing * 2, h * 0.65 + 10), // May 11
      Offset(40 + xSpacing * 3, h * 0.28 + 10), // May 16 (Peak)
      Offset(40 + xSpacing * 4, h * 0.65 + 10), // May 21
      Offset(40 + xSpacing * 5, h * 0.50 + 10), // May 26
      Offset(w - 15, h * 0.40 + 10), // May 31
    ];

    final curvePaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final current = points[i];
      path.cubicTo(
        prev.dx + (current.dx - prev.dx) / 2, prev.dy,
        prev.dx + (current.dx - prev.dx) / 2, current.dy,
        current.dx, current.dy,
      );
    }
    canvas.drawPath(path, curvePaint);

    // Highlight dot on peak
    final peakPoint = points[3];
    canvas.drawCircle(peakPoint, 4, Paint()..color = Colors.white..style = PaintingStyle.fill);
    canvas.drawCircle(peakPoint, 4, Paint()..color = const Color(0xFF2E7D32)..strokeWidth = 2..style = PaintingStyle.stroke);

    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(peakPoint.dx, peakPoint.dy - 18), width: 62, height: 16),
      const Radius.circular(5),
    );
    canvas.drawRRect(badgeRect, Paint()..color = const Color(0xFF1B5E20)..style = PaintingStyle.fill);
    
    final badgeTextSpan = const TextSpan(
      text: '₦245,000',
      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
    );
    final badgeTextPainter = TextPainter(text: badgeTextSpan, textDirection: TextDirection.ltr)..layout();
    badgeTextPainter.paint(
      canvas,
      Offset(peakPoint.dx - badgeTextPainter.width / 2, peakPoint.dy - 18 - badgeTextPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
