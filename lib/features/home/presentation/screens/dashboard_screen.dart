import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> _deliveries = [];
  bool _loading = false;
  Timer? _timer;
  
  // Track known transaction IDs to detect new payouts and trigger SMS
  final Set<int> _knownSettledDeliveries = {};
  bool _showSmsBanner = false;
  String _smsText = '';

  @override
  void initState() {
    super.initState();
    _fetchDeliveries();
    
    // Poll for webhook status updates every 4 seconds
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _fetchDeliveries(isSilent: true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchDeliveries({bool isSilent = false}) async {
    if (!isSilent) setState(() => _loading = true);
    final data = await ApiService.getDeliveries();
    
    if (mounted) {
      setState(() {
        _deliveries = data;
        _loading = false;
      });

      // Detect new SUCCESS payouts to show SMS
      for (var d in data) {
        final id = d['id'] as int;
        final status = d['status'] as String;
        final farmer = d['farmer_details'] ?? {};
        final farmerName = farmer['name'] ?? 'Farmer';
        final accNum = farmer['account_number'] ?? '0000000000';
        final total = d['total_price'] ?? '0';
        final settlement = d['settlement_details'] ?? {};
        final refId = settlement['reference_id'] ?? 'FP-MOCK';

        if (status == 'SUCCESS' && !_knownSettledDeliveries.contains(id)) {
          _knownSettledDeliveries.add(id);
          
          // Trigger SMS Alert
          if (_knownSettledDeliveries.length > 1) { // Skip triggering on initial load of historical data
            _triggerSmsAlert(farmerName, accNum, total, refId);
          }
        }
      }
    }
  }

  void _triggerSmsAlert(String farmerName, String accNum, String amount, String refId) {
    setState(() {
      _smsText = 'Monnify Alert: Acct: *******${accNum.substring(accNum.length - 3)} Credited NGN ${double.parse(amount).toStringAsFixed(0)} via FarmGate Pay. Ref: $refId. Thank you for using Monnify.';
      _showSmsBanner = true;
    });

    // Hide after 6 seconds
    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() => _showSmsBanner = false);
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'SUCCESS':
        return const Color(0xFF10B981);
      case 'PENDING':
        return Colors.orange;
      case 'ESCROW':
        return Colors.deepPurple;
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooperative Ledger'),
        backgroundColor: Colors.deepPurple[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _fetchDeliveries(),
          )
        ],
      ),
      body: Stack(
        children: [
          _loading
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF10B981)))
              : _deliveries.isEmpty
                  ? const Center(
                      child: Text(
                        'No delivery records logged yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _deliveries.length,
                      itemBuilder: (ctx, idx) {
                        final d = _deliveries[idx];
                        final farmer = d['farmer_details'] ?? {};
                        final name = farmer['name'] ?? 'Unknown';
                        final bankName = farmer['bank_name'] ?? 'Bank';
                        final accNum = farmer['account_number'] ?? '0000000000';
                        final total = double.tryParse(d['total_price'] ?? '0') ?? 0.0;
                        final status = d['status'] ?? 'PENDING';
                        final date = DateTime.parse(d['created_at']);
                        final settlement = d['settlement_details'] ?? {};
                        final ref = settlement['reference_id'] ?? '';

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(status).withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        status == 'SUCCESS' ? 'Settled' : status == 'ESCROW' ? 'Escrow Held' : status,
                                        style: TextStyle(
                                          color: _getStatusColor(status),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '$bankName • $accNum',
                                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '₦${total.toStringAsFixed(0)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF10B981)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Produce: ${d['produce_type']} (${d['weight']}kg)',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                    if (ref.isNotEmpty)
                                      Text(
                                        'Ref: $ref',
                                        style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.grey[500]),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          
          // Floating SMS alert slide-down banner
          if (_showSmsBanner)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                color: const Color(0xFF1E293B),
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.sms, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Message • Monnify SMS',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                Text(
                                  'now',
                                  style: TextStyle(color: Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _smsText,
                              style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.3),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
