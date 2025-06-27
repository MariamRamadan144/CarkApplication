import 'package:flutter/material.dart';
import '../../model/car_model.dart';
import '../../model/location_model.dart';
import 'deposit_input_screen.dart';

class RequestSentScreen extends StatelessWidget {
  final CarModel car;
  final double totalPrice;
  final List<LocationModel> stops;

  const RequestSentScreen({
    super.key,
    required this.car,
    required this.totalPrice,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Sent')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Request sent to owner.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Simulate owner acceptance
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DepositInputScreen(
                      car: car,
                      totalPrice: totalPrice,
                      stops: stops,
                    ),
                  ),
                );
              },
              child: const Text('Simulate Owner Acceptance'),
            ),
          ],
        ),
      ),
    );
  }
} 