// search bar and we will remove
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/car_cubit.dart';
//
// class BrandFilterScreen extends StatefulWidget {
//   const BrandFilterScreen({super.key});
//
//   @override
//   State<BrandFilterScreen> createState() => _BrandFilterScreenState();
// }
//
// class _BrandFilterScreenState extends State<BrandFilterScreen> {
//   final List<String> brands = ['Toyota', 'Honda', 'BMW', 'Ford'];
//   late List<String> selected;
//
//   @override
//   void initState() {
//     super.initState();
//     selected = List<String>.from(context.read<FilterCubit>().state.selectedBrands);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Brands")),
//       body: ListView.builder(
//         itemCount: brands.length,
//         itemBuilder: (_, index) {
//           final brand = brands[index];
//           final isSelected = selected.contains(brand);
//           return ListTile(
//             title: Text(brand),
//             trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
//             onTap: () {
//               setState(() {
//                 isSelected ? selected.remove(brand) : selected.add(brand);
//               });
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.pop(context, selected);
//         },
//         icon: const Icon(Icons.save),
//         label: const Text("Save"),
//       ),
//     );
//   }
// }
