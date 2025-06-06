// AvailabilityFilterScreen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailabilityFilterScreen extends StatefulWidget {
  const AvailabilityFilterScreen({Key? key}) : super(key: key);

  @override
  _AvailabilityFilterScreenState createState() => _AvailabilityFilterScreenState();
}

class _AvailabilityFilterScreenState extends State<AvailabilityFilterScreen> {
  List<String> availabilityOptions = ['Available', 'Unavailable'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Availability'),
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
        children: availabilityOptions.map((option) {
          final isSelected = selected.contains(option);
          return CheckboxListTile(
            title: Text(option),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selected.add(option);
                } else {
                  selected.remove(option);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
