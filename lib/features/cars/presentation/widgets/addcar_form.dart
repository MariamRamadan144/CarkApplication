import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCarForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController modelController;
  final TextEditingController brandController;
  final TextEditingController carTypeController;
  final TextEditingController carCategoryController;
  final TextEditingController plateNumberController;
  final TextEditingController yearController;
  final TextEditingController colorController;
  final TextEditingController seatingCapacityController;
  final TextEditingController transmissionTypeController;
  final TextEditingController fuelTypeController;
  final TextEditingController odometerController;

  const AddCarForm({
    super.key,
    required this.formKey,
    required this.modelController,
    required this.brandController,
    required this.carTypeController,
    required this.carCategoryController,
    required this.plateNumberController,
    required this.yearController,
    required this.colorController,
    required this.seatingCapacityController,
    required this.transmissionTypeController,
    required this.fuelTypeController,
    required this.odometerController,
  });

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number for $fieldName';
    }
    return null;
  }

  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter year';
    }
    final year = int.tryParse(value);
    if (year == null) {
      return 'Please enter a valid year';
    }
    if (year < 1900 || year > DateTime.now().year + 1) {
      return 'Please enter a valid year between 1900 and ${DateTime.now().year + 1}';
    }
    return null;
  }

  String? _validatePlateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter plate number';
    }
    // Add your country-specific plate number validation here
    // This is a basic example
    if (value.length < 3) {
      return 'Plate number must be at least 3 characters';
    }
    return null;
  }

  String? _validateSeatingCapacity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter seating capacity';
    }
    final seats = int.tryParse(value);
    if (seats == null) {
      return 'Please enter a valid number';
    }
    if (seats < 1 || seats > 50) {
      return 'Please enter a valid seating capacity between 1 and 50';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: brandController,
            decoration: const InputDecoration(
              labelText: 'Brand',
              hintText: 'Enter car brand (e.g., Toyota, Honda)',
              prefixIcon: Icon(Icons.branding_watermark),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'brand'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: modelController,
            decoration: const InputDecoration(
              labelText: 'Model',
              hintText: 'Enter car model',
              prefixIcon: Icon(Icons.model_training),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'model'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: carTypeController,
            decoration: const InputDecoration(
              labelText: 'Car Type',
              hintText: 'Enter car type (e.g., Sedan, SUV)',
              prefixIcon: Icon(Icons.car_rental),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'car type'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: carCategoryController,
            decoration: const InputDecoration(
              labelText: 'Car Category',
              hintText: 'Enter car category',
              prefixIcon: Icon(Icons.category),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'car category'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: plateNumberController,
            decoration: const InputDecoration(
              labelText: 'Plate Number',
              hintText: 'Enter plate number',
              prefixIcon: Icon(Icons.pin),
            ),
            textCapitalization: TextCapitalization.characters,
            validator: _validatePlateNumber,
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: yearController,
            decoration: const InputDecoration(
              labelText: 'Year',
              hintText: 'Enter car year',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            keyboardType: TextInputType.number,
            validator: _validateYear,
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: colorController,
            decoration: const InputDecoration(
              labelText: 'Color',
              hintText: 'Enter car color',
              prefixIcon: Icon(Icons.color_lens),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'color'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: seatingCapacityController,
            decoration: const InputDecoration(
              labelText: 'Seating Capacity',
              hintText: 'Enter seating capacity',
              prefixIcon: Icon(Icons.airline_seat_recline_normal),
            ),
            keyboardType: TextInputType.number,
            validator: _validateSeatingCapacity,
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: transmissionTypeController,
            decoration: const InputDecoration(
              labelText: 'Transmission Type',
              hintText: 'Enter transmission type (e.g., Automatic, Manual)',
              prefixIcon: Icon(Icons.settings),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'transmission type'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: fuelTypeController,
            decoration: const InputDecoration(
              labelText: 'Fuel Type',
              hintText: 'Enter fuel type (e.g., Petrol, Diesel)',
              prefixIcon: Icon(Icons.local_gas_station),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) => _validateNotEmpty(value, 'fuel type'),
          ),
          SizedBox(height: 0.02.sh),

          TextFormField(
            controller: odometerController,
            decoration: const InputDecoration(
              labelText: 'Current Odometer Reading',
              hintText: 'Enter current odometer reading',
              prefixIcon: Icon(Icons.speed),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => _validateNumber(value, 'odometer reading'),
          ),
          SizedBox(height: 0.04.sh),
        ],
      ),
    );
  }
}