import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/car_model.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarModel car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${car.brand} ${car.model}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(car.imageUrl, height: 200),
            const SizedBox(height: 16),
            Text('Brand: ${car.brand}'),
            Text('Model: ${car.model}'),
            Text('Year: ${car.year}'),
            Text('Seats: ${car.seatingCapacity}'),
            Text('Fuel: ${car.fuelType}'),
            Text('Transmission: ${car.transmissionType}'),
            // Add any other fields you want here...
          ],
        ),
      ),
    );
  }
}
