import 'package:flutter/material.dart';
import '../../model/car_model.dart';
import '../../model/location_model.dart';
import 'trip_management_screen.dart';

class DepositInputScreen extends StatefulWidget {
  final CarModel car;
  final double totalPrice;
  final List<LocationModel> stops;

  const DepositInputScreen({
    super.key,
    required this.car,
    required this.totalPrice,
    required this.stops,
  });

  @override
  State<DepositInputScreen> createState() => _DepositInputScreenState();
}

class _DepositInputScreenState extends State<DepositInputScreen> {
  final TextEditingController _depositController = TextEditingController();

  @override
  void dispose() {
    _depositController.dispose();
    super.dispose();
  }

  void _submitDeposit() {
    final deposit = _depositController.text;
    if (deposit.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your deposit.')),
      );
      return;
    }
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deposit of \$$deposit submitted!')),
    );
    
    // Navigate to Trip Management Screen after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TripManagementScreen(
            car: widget.car,
            totalPrice: widget.totalPrice,
            stops: widget.stops,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deposit Required')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Please enter your deposit.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _depositController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Deposit Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deposit should be paid in 24 hours.',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitDeposit,
              child: const Text('Submit Deposit'),
            ),
          ],
        ),
      ),
    );
  }
} 