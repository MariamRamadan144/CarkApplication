// CarCategoryFilterScreen.dart
import 'package:flutter/material.dart';

class CarCategoryFilterScreen extends StatefulWidget {
  const CarCategoryFilterScreen({super.key});

  @override
  _CarCategoryFilterScreenState createState() => _CarCategoryFilterScreenState();
}

class _CarCategoryFilterScreenState extends State<CarCategoryFilterScreen> {
  List<String> categories = ['Luxury', 'Economy', 'Compact', 'Sports'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Car Categories'),
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
        children: categories.map((category) {
          final isSelected = selected.contains(category);
          return CheckboxListTile(
            title: Text(category),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selected.add(category);
                } else {
                  selected.remove(category);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
