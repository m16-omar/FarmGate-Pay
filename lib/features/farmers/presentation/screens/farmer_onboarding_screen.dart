import 'package:flutter/material.dart';
import '../../../../core/services/api_service.dart';

class FarmerOnboardingScreen extends StatefulWidget {
  const FarmerOnboardingScreen({super.key});

  @override
  _FarmerOnboardingScreenState createState() => _FarmerOnboardingScreenState();
}

class _FarmerOnboardingScreenState extends State<FarmerOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _accountController = TextEditingController();

  final List<Map<String, String>> _banks = [
    {'name': 'Guaranty Trust Bank (GTBank)', 'code': '058'},
    {'name': 'First Bank of Nigeria', 'code': '011'},
    {'name': 'Zenith Bank', 'code': '057'},
    {'name': 'United Bank for Africa (UBA)', 'code': '033'},
    {'name': 'Access Bank', 'code': '044'},
    {'name': 'Fidelity Bank', 'code': '070'},
    {'name': 'Sterling Bank', 'code': '232'},
  ];

  late Map<String, String> _selectedBank;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _selectedBank = _banks[0];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final data = {
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'bank_code': _selectedBank['code'],
      'bank_name': _selectedBank['name'],
      'account_number': _accountController.text.trim(),
    };

    final result = await ApiService.createFarmer(data);

    setState(() => _loading = false);

    if (result != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Farmer onboarded successfully!'),
            backgroundColor: Color(0xFF10B981),
          ),
        );
        Navigator.pop(context, true);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to onboard farmer. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Onboarding'),
        backgroundColor: Colors.deepPurple[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_add_outlined,
                size: 80,
                color: Color(0xFF10B981),
              ),
              const SizedBox(height: 16),
              const Text(
                'Register a New Farmer',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Link a NUBAN account for instant post-harvest payouts',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 32),
              
              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Please enter full name' : null,
              ),
              const SizedBox(height: 20),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  hintText: 'e.g., 08031234567',
                ),
                validator: (val) => val == null || val.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 20),

              // Bank Dropdown
              DropdownButtonFormField<Map<String, String>>(
                value: _selectedBank,
                decoration: const InputDecoration(
                  labelText: 'Destination Bank',
                  prefixIcon: Icon(Icons.account_balance),
                  border: OutlineInputBorder(),
                ),
                items: _banks.map((bank) {
                  return DropdownMenuItem<Map<String, String>>(
                    value: bank,
                    child: Text(
                      bank['name']!,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedBank = val);
                  }
                },
              ),
              const SizedBox(height: 20),

              // Account Number
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'NUBAN Account Number',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter account number';
                  if (val.length != 10) return 'Must be exactly 10 digits';
                  return null;
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _loading ? null : _submit,
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
                        'Onboard & Link Account',
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
