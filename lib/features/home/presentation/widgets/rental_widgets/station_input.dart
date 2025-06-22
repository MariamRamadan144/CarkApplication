import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/car_cubit.dart';
import '../../cubit/choose_car_state.dart';
import '../../model/location_model.dart';

class StationInput extends StatefulWidget {
  final bool isPickup; // true => pickup, false => return

  const StationInput({required this.isPickup, super.key});

  @override
  State<StationInput> createState() => _StationInputState();
}

class _StationInputState extends State<StationInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // It's good practice to initialize the controller with the initial value from the cubit
    final cubit = context.read<CarCubit>();
    final initialStation = widget.isPickup ? cubit.state.pickupStation : cubit.state.returnStation;
    if (initialStation != null) {
      _controller.text = initialStation.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String text) {
    final cubit = context.read<CarCubit>();
    // For simplicity, we create a LocationModel with just the name.
    // You might want to adjust this based on your actual LocationModel needs.
    final location = LocationModel(name: text, address: '', description: '');
    if (widget.isPickup) {
      cubit.setPickupStation(location);
    } else {
      cubit.setReturnStation(location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CarCubit, ChooseCarState>(
      // Listen for changes in both pickup and return stations
      listenWhen: (previous, current) {
        if (widget.isPickup) {
          return previous.pickupStation != current.pickupStation;
        } else {
          return previous.returnStation != current.returnStation;
        }
      },
      listener: (context, state) {
        final stationValue =
        widget.isPickup ? state.pickupStation : state.returnStation;
        // Check if the controller's text needs to be updated.
        // This prevents an infinite loop of updates.
        if (stationValue != null && _controller.text != stationValue.name) {
          _controller.text = stationValue.name;
        }
      },
      child: TextFormField(
        controller: _controller,
        onChanged: _onTextChanged,
        decoration: InputDecoration(
          hintText: widget.isPickup
              ? 'Enter Pick-up Station'
              : 'Enter Return Station',
          prefixIcon: Icon(
            widget.isPickup ? Icons.my_location : Icons.location_on,
            color: Theme.of(context).hintColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
