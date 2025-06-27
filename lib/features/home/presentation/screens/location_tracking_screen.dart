import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/location_tracking_cubit.dart';
import '../cubit/location_tracking_state.dart';
import '../model/car_model.dart';
import '../widgets/location_widgets/simple_map_widget.dart';
import '../widgets/location_widgets/location_history_widget.dart';

class LocationTrackingScreen extends StatefulWidget {
  final CarModel car;

  const LocationTrackingScreen({
    super.key,
    required this.car,
  });

  @override
  State<LocationTrackingScreen> createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  @override
  void initState() {
    super.initState();
    // Load location history when screen opens
    context.read<LocationTrackingCubit>().getLocationHistory(widget.car.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track ${widget.car.brand} ${widget.car.model}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<LocationTrackingCubit>().getLocationHistory(widget.car.id);
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh History',
          ),
        ],
      ),
      body: BlocConsumer<LocationTrackingCubit, LocationTrackingState>(
        listener: (context, state) {
          if (state is LocationTrackingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCarInfoCard(),
                _buildRequestLocationButton(),
                _buildLocationDisplay(state),
                _buildLocationHistory(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarInfoCard() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                widget.car.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.directions_car,
                    size: 30.sp,
                    color: Colors.grey[600],
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.car.brand} ${widget.car.model}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Plate: ${widget.car.plateNumber}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: widget.car.availability ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    widget.car.availability ? 'Available' : 'Unavailable',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestLocationButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<LocationTrackingCubit>().requestCarLocation(widget.car.id);
        },
        icon: const Icon(Icons.location_searching),
        label: Text(
          'Request Current Location',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }

  Widget _buildLocationDisplay(LocationTrackingState state) {
    if (state is LocationTrackingLoading) {
      return Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: CircularProgressIndicator(
                strokeWidth: 3.w,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Getting car location...',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      );
    }

    if (state is LocationTrackingSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Current Location',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SimpleMapWidget(locationRequest: state.locationRequest),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildLocationHistory(LocationTrackingState state) {
    if (state is LocationTrackingLoading) {
      return Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is LocationHistoryLoaded) {
      return LocationHistoryWidget(locationHistory: state.locationHistory);
    }

    return const SizedBox.shrink();
  }
} 