import 'package:flutter/material.dart';
import '../../../../core/services/api_service.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _priceController = TextEditingController();
  
  List<dynamic> _farmers = [];
  dynamic _selectedFarmer;
  dynamic _selectedBuyer;
  
  String _selectedProduce = 'Maize';
  final List<String> _produceTypes = ['Maize', 'Cocoa', 'Cashew', 'Soybeans', 'Yams'];
  
  // Market Benchmarks
  final Map<String, double> _benchmarks = {
    'Maize': 600.0,
    'Cocoa': 2500.0,
    'Cashew': 1200.0,
    'Soybeans': 950.0,
    'Yams': 500.0,
  };

  bool _isEscrow = false;
  bool _loading = false;
  bool _fetchingData = true;
  bool _photoTaken = false;
  double _totalValue = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchOnboardedData();
    _weightController.addListener(_updateTotal);
    _priceController.addListener(_updateTotal);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _fetchOnboardedData() async {
    setState(() => _fetchingData = true);
    final farmers = await ApiService.getFarmers();
    final buyers = await ApiService.getBuyers();
    
    setState(() {
      _farmers = farmers;
      if (farmers.isNotEmpty) _selectedFarmer = farmers[0];
      if (buyers.isNotEmpty) _selectedBuyer = buyers[0];
      _fetchingData = false;
    });
  }

  void _updateTotal() {
    final weight = double.tryParse(_weightController.text) ?? 0.0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    setState(() {
      _totalValue = weight * price;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFarmer == null || _selectedBuyer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select farmer.')),
      );
      return;
    }

    setState(() => _loading = true);

    final data = {
      'farmer': _selectedFarmer['id'],
      'buyer': _selectedBuyer['id'],
      'produce_type': _selectedProduce,
      'weight': double.parse(_weightController.text),
      'unit_price': double.parse(_priceController.text),
      'is_escrow': _isEscrow,
      'image_url': _photoTaken ? 'https://farmgatepay.net/uploads/scale_reading_mock.jpg' : null,
    };

    final result = await ApiService.createDelivery(data);

    setState(() => _loading = false);

    if (result != null) {
      final payoutDetails = result['payout_details'] ?? {};
      _showPayoutConfirmationDialog(result, payoutDetails);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit delivery and initiate payout.')),
        );
      }
    }
  }

  void _showPayoutConfirmationDialog(Map<String, dynamic> delivery, Map<String, dynamic> payout) {
    final amount = double.tryParse(delivery['total_price'] ?? '0') ?? 0.0;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Settlement Initiated',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  'Payout of ₦${amount.toStringAsFixed(0)} to ${_selectedFarmer['name']} is processing.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Reference:', payout['reference'] ?? 'N/A'),
                      _buildDetailRow('Account:', '${_selectedFarmer['bank_name']} (${_selectedFarmer['account_number']})'),
                      _buildDetailRow('Status:', payout['status'] ?? 'PENDING', isStatus: true),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx); // Close dialog
                    _weightController.clear();
                    _priceController.clear();
                    setState(() {
                      _photoTaken = false;
                      _isEscrow = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[900],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Return to Logs'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String val, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(
            val,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isStatus ? Colors.purple : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_fetchingData) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF10B981)),
        ),
      );
    }

    final double benchmark = _benchmarks[_selectedProduce]!;
    final double inputPrice = double.tryParse(_priceController.text) ?? 0.0;
    final bool isFairPrice = inputPrice >= benchmark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Harvest Delivery'),
        backgroundColor: Colors.deepPurple[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Farmer & Payout Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              _farmers.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(8)),
                      child: const Text('No farmers onboarded. Go to Onboarding tab first.', style: TextStyle(color: Colors.red)),
                    )
                  : DropdownButtonFormField<dynamic>(
                      value: _selectedFarmer,
                      decoration: const InputDecoration(border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                      items: _farmers.map((f) {
                        return DropdownMenuItem<dynamic>(
                          value: f,
                          child: Text('${f['name']} (${f['bank_name']})'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedFarmer = val),
                    ),
              const SizedBox(height: 20),

              // Produce & Benchmarks
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Produce Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedProduce,
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                          items: _produceTypes.map((p) {
                            return DropdownMenuItem<String>(value: p, child: Text(p));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedProduce = val;
                                _priceController.text = _benchmarks[val]!.toStringAsFixed(0);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Lagos Market Index', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[50],
                          ),
                          child: Text(
                            '₦${benchmark.toStringAsFixed(0)}/kg',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Weight and Unit Price
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        suffixText: 'kg',
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Enter weight' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Unit Price (₦/kg)',
                        border: const OutlineInputBorder(),
                        suffixIcon: inputPrice > 0
                            ? Icon(
                                isFairPrice ? Icons.verified : Icons.warning_amber,
                                color: isFairPrice ? const Color(0xFF10B981) : Colors.orange,
                              )
                            : null,
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Enter unit price' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Benchmark Check Banner
              if (inputPrice > 0)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isFairPrice ? const Color(0x1F10B981) : Colors.amber[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isFairPrice ? Icons.verified : Icons.info,
                        color: isFairPrice ? const Color(0xFF10B981) : Colors.amber[800],
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isFairPrice
                            ? 'Fair value verified. Matches or exceeds market index.'
                            : 'Agreed price is below standard index.',
                        style: TextStyle(
                          color: isFairPrice ? const Color(0xFF065F46) : Colors.amber[900],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // Escrow toggle
              Card(
                color: Colors.deepPurple[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: CheckboxListTile(
                  title: const Text(
                    'Quality Hold (Escrow)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.deepPurple),
                  ),
                  subtitle: const Text(
                    'Lock funds in Monnify escrow sub-account until processor confirms crop grades at factory.',
                    style: TextStyle(fontSize: 11, color: Colors.blueGrey),
                  ),
                  value: _isEscrow,
                  onChanged: (val) => setState(() => _isEscrow = val ?? false),
                  activeColor: Colors.deepPurple[900],
                ),
              ),
              const SizedBox(height: 20),

              // Camera trigger
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => _photoTaken = !_photoTaken);
                },
                icon: Icon(
                  _photoTaken ? Icons.check_circle : Icons.camera_alt_outlined,
                  color: _photoTaken ? const Color(0xFF10B981) : Colors.grey[700],
                ),
                label: Text(
                  _photoTaken ? 'Scale Reading Attached' : 'Capture Scale Weight & Quality Photo',
                  style: TextStyle(color: _photoTaken ? const Color(0xFF10B981) : Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(
                    color: _photoTaken ? const Color(0xFF10B981) : Colors.grey[400]!,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 32),

              // Total Calculation Card
              Card(
                elevation: 0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Payout',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
                      ),
                      Text(
                        '₦${_totalValue.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _loading || _farmers.isEmpty ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'Confirm & Settle Payout',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
