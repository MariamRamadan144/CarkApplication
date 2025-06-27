// ModelFilterScreen.dart
import 'package:flutter/material.dart';

class ModelFilterScreen extends StatefulWidget {
  const ModelFilterScreen({super.key});

  @override
  _ModelFilterScreenState createState() => _ModelFilterScreenState();
}

class _ModelFilterScreenState extends State<ModelFilterScreen> {
  List<String> models = ['Sedan', 'SUV', 'Hatchback', 'Convertible'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Models'),
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
        children: models.map((model) {
          final isSelected = selected.contains(model);
          return CheckboxListTile(
            title: Text(model),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selected.add(model);
                } else {
                  selected.remove(model);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
