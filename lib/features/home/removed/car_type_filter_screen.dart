// CarTypeFilterScreen.dart
import 'package:flutter/material.dart';

class CarTypeFilterScreen extends StatefulWidget {
  const CarTypeFilterScreen({super.key});

  @override
  _CarTypeFilterScreenState createState() => _CarTypeFilterScreenState();
}

class _CarTypeFilterScreenState extends State<CarTypeFilterScreen> {
  List<String> carTypes = ['Sedan', 'SUV', 'Truck', 'Coupe'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Car Types'),
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
        children: carTypes.map((type) {
          final isSelected = selected.contains(type);
          return CheckboxListTile(
            title: Text(type),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selected.add(type);
                } else {
                  selected.remove(type);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
