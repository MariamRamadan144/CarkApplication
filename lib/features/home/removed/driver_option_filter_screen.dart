// // DriverOptionFilterScreen.dart
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DriverOptionFilterScreen extends StatefulWidget {
//   const DriverOptionFilterScreen({Key? key}) : super(key: key);
//
//   @override
//   _DriverOptionFilterScreenState createState() => _DriverOptionFilterScreenState();
// }
//
// class _DriverOptionFilterScreenState extends State<DriverOptionFilterScreen> {
//   List<String> options = ['With Driver', 'Without Driver'];
//   List<String> selected = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Driver Options'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: () {
//               Navigator.pop(context, selected);
//             },
//           )
//         ],
//       ),
//       body: ListView(
//         children: options.map((option) {
//           final isSelected = selected.contains(option);
//           return CheckboxListTile(
//             title: Text(option),
//             value: isSelected,
//             onChanged: (bool? value) {
//               setState(() {
//                 if (value == true) {
//                   selected.add(option);
//                 } else {
//                   selected.remove(option);
//                 }
//               });
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
