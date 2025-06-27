// FuelTypeFilterScreen.dart
import 'package:flutter/material.dart';

class FuelTypeFilterScreen extends StatefulWidget {
  const FuelTypeFilterScreen({super.key});

  @override
  _FuelTypeFilterScreenState createState() => _FuelTypeFilterScreenState();
}

class _FuelTypeFilterScreenState extends State<FuelTypeFilterScreen> {
  List<String> fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Hybrid'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Fuel Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, selected);
            },
          )
        ],
      ),
      body: ListView(
        children: fuelTypes.map((fuel) {
          final isSelected = selected.contains(fuel);
          return CheckboxListTile(
            title: Text(fuel),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selected.add(fuel);
                } else {
                  selected.remove(fuel);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
