// TransmissionTypeFilterScreen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransmissionTypeFilterScreen extends StatefulWidget {
  const TransmissionTypeFilterScreen({Key? key}) : super(key: key);

  @override
  _TransmissionTypeFilterScreenState createState() => _TransmissionTypeFilterScreenState();
}

class _TransmissionTypeFilterScreenState extends State<TransmissionTypeFilterScreen> {
  List<String> transmissionTypes = ['Manual', 'Automatic'];
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Transmission Types'),
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
        children: transmissionTypes.map((type) {
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
