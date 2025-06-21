// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../cubit/rental_cubit.dart';
//
// class StationInput extends StatelessWidget {
//   final String label;
//   const StationInput({required this.label, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<RentalCubit>();
//     final controller = TextEditingController(
//       text: label.contains('Pick-up')
//           ? cubit.state.pickupStation
//           : cubit.state.returnStation,
//     );
//
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         prefixIcon: Icon(
//           label.contains('Pick-up') ? Icons.location_on : Icons.location_searching,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//       ),
//       onChanged: (value) {
//         if (label.contains('Pick-up')) {
//           cubit.setPickupStation(value);
//         } else {
//           cubit.setReturnStation(value);
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/car_cubit.dart';
import '../../cubit/rental_cubit.dart';

class StationInput extends StatefulWidget {
  final bool isPickup; // true => pickup, false => return

  const StationInput({required this.isPickup, super.key});

  @override
  State<StationInput> createState() => _StationInputState();
}

class _StationInputState extends State<StationInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CarCubit>();
    _controller = TextEditingController(
      text: widget.isPickup ? cubit.state.pickupStation : cubit.state.returnStation,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final cubit = context.read<CarCubit>();
    if (widget.isPickup) {
      cubit.setPickupStation(value);
    } else {
      cubit.setReturnStation(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.isPickup ? 'Pick-up Station' : 'Return Station';

    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(
          widget.isPickup ? Icons.location_on : Icons.location_searching,
          color: Theme.of(context).colorScheme.primary,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }
}

