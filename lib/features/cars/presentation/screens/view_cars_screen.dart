import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/text_manager.dart';
import '../cubits/add_car_cubit.dart';
import '../cubits/add_car_state.dart';
import 'package:test_cark/features/home/presentation/model/car_model.dart';
import 'add_car_screen.dart';
import '../widgets/car_data_table.dart';
import 'view_car_details_screen.dart';

class ViewCarsScreen extends StatelessWidget {
  const ViewCarsScreen({super.key});

  void _showDeleteConfirmation(BuildContext context, CarModel car) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28.sp),
              SizedBox(width: 10.w),
              Text(
                'Delete Car',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you want to delete this car?',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                '${car.brand} ${car.model}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Plate Number: ${car.plateNumber}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AddCarCubit>().deleteCar(car);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the cars when the screen is built
    final cars = context.read<AddCarCubit>().getCars();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(TextManager.viewCarsTitle.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCarScreen()),
              ).then((_) {
                // Rebuild the screen when returning from AddCarScreen
                (context as Element).markNeedsBuild();
              });
            },
          ),
        ],
      ),
      body: BlocConsumer<AddCarCubit, AddCarState>(
        listener: (context, state) {
          if (state is AddCarSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(TextManager.carDeletedSuccess.tr()),
                backgroundColor: Colors.green,
              ),
            );
            // Rebuild the screen after successful operation
            (context as Element).markNeedsBuild();
          } else if (state is AddCarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AddCarLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (cars.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 64.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    TextManager.noCarsMessage.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: CarDataTable(
              cars: cars,
              onEdit: (CarModel car) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCarScreen(carToEdit: car),
                  ),
                ).then((_) {
                  // Rebuild the screen when returning from edit
                  (context as Element).markNeedsBuild();
                });
              },
              onDelete: (CarModel car) => _showDeleteConfirmation(context, car), onViewDetails: (CarModel car) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewCarDetailsScreen(car: car),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 