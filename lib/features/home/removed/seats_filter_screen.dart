// SeatsFilterScreen.dart
import 'package:flutter/material.dart';

class SeatsFilterScreen extends StatefulWidget {
  const SeatsFilterScreen({super.key});

  @override
  _SeatsFilterScreenState createState() => _SeatsFilterScreenState();
}

class _SeatsFilterScreenState extends State<SeatsFilterScreen> {
  List<String> seatsOptions = ['2', '4', '5', '7+'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seats'),
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
        children: seatsOptions.map((seat) {
          final isSelected = selected.contains(seat);
          return CheckboxListTile(
            title: Text(seat),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selected.add(seat);
                } else {
                  selected.remove(seat);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
