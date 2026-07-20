import 'package:flutter/material.dart';

class PaymentsDashboardScreen extends StatefulWidget {
  const PaymentsDashboardScreen({super.key});

  @override
  State<PaymentsDashboardScreen> createState() => _PaymentsDashboardScreenState();
}

class _PaymentsDashboardScreenState extends State<PaymentsDashboardScreen> {
  bool _hideEarnings = false;
  String _selectedPeriod = 'This Month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. App Bar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
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
                            'Earnings',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Track your income and payouts',
                            style: TextStyle(fontSize: 11, color: Color(0xFF888888), fontWeight: FontWeight.w500),
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
                      child: const Icon(Icons.tune, color: Color(0xFF666666), size: 20),
                    ),
                    const SizedBox(width: 8),
                    // Dropdown period
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E2DF)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, color: Color(0xFF666666), size: 14),
                          const SizedBox(width: 6),
                          Text(
                            _selectedPeriod,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          const Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Earnings Hero Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF33691E), Color(0xFF1B5E20)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Total Earnings',
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () => setState(() => _hideEarnings = !_hideEarnings),
                                child: Icon(
                                  _hideEarnings ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _hideEarnings ? '₦ ••••••' : '₦2,450,000',
                            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: const [
                              Icon(Icons.arrow_upward, color: Color(0xFFC8E6C9), size: 14),
                              SizedBox(width: 4),
                              Text(
                                '18.5% vs last month',
                                style: TextStyle(color: Color(0xFFC8E6C9), fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Wallet illustration
                    SizedBox(
                      width: 100,
                      height: 80,
                      child: CustomPaint(
                        painter: _WalletIllustrationPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Grid Statistics
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: [
                    _buildGridCard(
                      icon: Icons.check_circle_outline,
                      iconColor: const Color(0xFF2E7D32),
                      title: 'Completed',
                      value: '₦1,850,000',
                      subtext: '23 Deliveries',
                    ),
                    _buildGridCard(
                      icon: Icons.hourglass_empty_outlined,
                      iconColor: const Color(0xFFE65100),
                      title: 'Pending',
                      value: '₦420,000',
                      subtext: '4 Deliveries',
                    ),
                    _buildGridCard(
                      icon: Icons.send_outlined,
                      iconColor: const Color(0xFF1565C0),
                      title: 'Paid Out',
                      value: '₦1,300,000',
                      subtext: 'May 15, 2025',
                    ),
                    _buildGridCard(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF7B1FA2),
                      title: 'Available Balance',
                      value: '₦1,150,000',
                      subtext: 'Ready for payout',
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Earnings Overview Line Chart
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
                          'Earnings Overview',
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
                    const SizedBox(height: 20),
                    // Line Chart Painter
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _LineChartPainter(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. Recent Transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildTransactionRow(
                      icon: Icons.arrow_downward,
                      iconBg: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                      title: 'Payment Received',
                      subtitle: 'From ABC Agro Ltd',
                      date: 'May 20, 2025 • 08:45 AM',
                      amount: '₦1,125,000',
                      statusLabel: 'Completed',
                      statusBg: const Color(0xFFE8F5E9),
                      statusTextColor: const Color(0xFF2E7D32),
                    ),
                    const Divider(height: 20),
                    _buildTransactionRow(
                      icon: Icons.arrow_upward,
                      iconBg: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF1565C0),
                      title: 'Payout to Bank',
                      subtitle: 'GTBank **** 2188',
                      date: 'May 15, 2025 • 09:10 AM',
                      amount: '₦1,300,000',
                      statusLabel: 'Paid Out',
                      statusBg: const Color(0xFFE3F2FD),
                      statusTextColor: const Color(0xFF1565C0),
                    ),
                    const Divider(height: 20),
                    _buildTransactionRow(
                      icon: Icons.arrow_downward,
                      iconBg: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                      title: 'Payment Received',
                      subtitle: 'From FreshMart Ltd',
                      date: 'May 17, 2025 • 02:50 PM',
                      amount: '₦312,000',
                      statusLabel: 'Completed',
                      statusBg: const Color(0xFFE8F5E9),
                      statusTextColor: const Color(0xFF2E7D32),
                    ),
                    const Divider(height: 20),
                    _buildTransactionRow(
                      icon: Icons.arrow_downward,
                      iconBg: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                      title: 'Payment Received',
                      subtitle: 'From Niger Foods',
                      date: 'May 16, 2025 • 10:20 AM',
                      amount: '₦540,000',
                      statusLabel: 'Completed',
                      statusBg: const Color(0xFFE8F5E9),
                      statusTextColor: const Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 6. Bottom Banner Promo
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            'Get paid instantly',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Receive payments within minutes once your delivery is confirmed.',
                            style: TextStyle(fontSize: 10, color: Color(0xFF777777), height: 1.3, fontWeight: FontWeight.w500),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      child: const Text('Learn More', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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

  Widget _buildGridCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtext,
    bool isHighlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFFF3E5F5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlight ? const Color(0xFFE1BEE7) : const Color(0xFFE2E2DF),
          width: isHighlight ? 1.5 : 1,
        ),
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
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isHighlight ? const Color(0xFF7B1FA2) : const Color(0xFF888888),
                ),
              ),
              Icon(icon, color: iconColor, size: 18),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isHighlight ? const Color(0xFF7B1FA2) : const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtext,
                style: TextStyle(
                  fontSize: 8,
                  color: isHighlight ? const Color(0xFF9C27B0).withOpacity(0.8) : const Color(0xFFBBBBBB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String date,
    required String amount,
    required String statusLabel,
    required Color statusBg,
    required Color statusTextColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Color(0xFF777777), fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: const TextStyle(fontSize: 9, color: Color(0xFF999999)),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: title.contains('Payout') ? const Color(0xFF333333) : const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
              child: Text(
                statusLabel,
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: statusTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 20),
      ],
    );
  }
}

/// A custom painter that draws a vector wallet overflowing with notes and gold coins at bottom
class _WalletIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Currency notes (green/white rectangles behind)
    final notePaint = Paint()..color = const Color(0xFFA5D6A7)..style = PaintingStyle.fill;
    final notePaint2 = Paint()..color = const Color(0xFF81C784)..style = PaintingStyle.fill;
    
    canvas.save();
    canvas.translate(w * 0.35, h * 0.15);
    canvas.rotate(-0.25);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(0, 0, 44, 30), const Radius.circular(4)), notePaint);
    canvas.restore();

    canvas.save();
    canvas.translate(w * 0.45, h * 0.1);
    canvas.rotate(0.15);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(0, 0, 44, 30), const Radius.circular(4)), notePaint2);
    canvas.restore();

    // 2. Leather Wallet Body
    final walletPaint = Paint()..color = const Color(0xFF4E342E)..style = PaintingStyle.fill;
    final walletFlapPaint = Paint()..color = const Color(0xFF3E2723)..style = PaintingStyle.fill;

    final walletRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.25, h * 0.35, w * 0.95, h * 0.95),
      const Radius.circular(10),
    );
    canvas.drawRRect(walletRect, walletPaint);

    // Flap
    final flapRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.22, h * 0.38, w * 0.65, h * 0.85),
      const Radius.circular(8),
    );
    canvas.drawRRect(flapRect, walletFlapPaint);

    // Lock button (gold metal circle)
    final goldPaint = Paint()..color = const Color(0xFFFFB300)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.52, h * 0.62), 4, goldPaint);

    // 3. Gold Coins at the base
    canvas.drawOval(Rect.fromLTRB(w * 0.05, h * 0.78, w * 0.28, h * 0.95), goldPaint);
    canvas.drawOval(Rect.fromLTRB(w * 0.15, h * 0.82, w * 0.36, h * 0.96), goldPaint);
    canvas.drawOval(Rect.fromLTRB(w * 0.08, h * 0.85, w * 0.26, h * 0.98), goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A custom painter that draws a vector line graph showing daily earnings overview
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F1EF)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final textStyle = TextStyle(color: Colors.grey[500], fontSize: 9, fontWeight: FontWeight.w500);

    // 1. Draw Grid lines and Left labels
    final leftLabels = ['N300K', 'N200K', 'N100K', 'N0'];
    final double ySpacing = h * 0.8 / 3;
    
    for (int i = 0; i < 4; i++) {
      final double y = ySpacing * i + 10;
      canvas.drawLine(Offset(35, y), Offset(w - 10, y), gridPaint);
      
      // Paint text labels
      final textSpan = TextSpan(text: leftLabels[i], style: textStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      textPainter.paint(canvas, Offset(2, y - 6));
    }

    // 2. Bottom labels (Dates)
    final dates = ['May 1', 'May 6', 'May 11', 'May 16', 'May 21', 'May 26', 'May 31'];
    final double xSpacing = (w - 55) / 6;
    
    for (int i = 0; i < 7; i++) {
      final double x = 40 + xSpacing * i;
      final textSpan = TextSpan(text: dates[i], style: textStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, h - 16));
    }

    // 3. Line Chart Curve Points
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
      ..strokeWidth = 3
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
    
    // Draw smooth curve line
    canvas.drawPath(path, curvePaint);

    // Gradient fill under the line chart
    final fillPath = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[0].dx, h * 0.8 + 10);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final current = points[i];
      fillPath.cubicTo(
        prev.dx + (current.dx - prev.dx) / 2, prev.dy,
        prev.dx + (current.dx - prev.dx) / 2, current.dy,
        current.dx, current.dy,
      );
    }
    fillPath.lineTo(points[points.length - 1].dx, h * 0.8 + 10);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [const Color(0xFF2E7D32).withOpacity(0.2), const Color(0xFF2E7D32).withOpacity(0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(40, 10, w - 10, h - 16))
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // 4. Highlight Point (May 16 Peak)
    final peakPoint = points[3];
    final whiteDotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    final greenRingPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(peakPoint, 5, whiteDotPaint);
    canvas.drawCircle(peakPoint, 5, greenRingPaint);

    // Highlight text badge: "₦245,000"
    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(peakPoint.dx, peakPoint.dy - 22), width: 66, height: 18),
      const Radius.circular(6),
    );
    canvas.drawRRect(badgeRect, Paint()..color = const Color(0xFF1B5E20)..style = PaintingStyle.fill);
    
    final badgeTextSpan = const TextSpan(
      text: '₦245,000',
      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
    );
    final badgeTextPainter = TextPainter(text: badgeTextSpan, textDirection: TextDirection.ltr)..layout();
    badgeTextPainter.paint(
      canvas,
      Offset(peakPoint.dx - badgeTextPainter.width / 2, peakPoint.dy - 22 - badgeTextPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
