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

<<<<<<< Updated upstream
class ViewCarsScreen extends StatelessWidget {
  const ViewCarsScreen({super.key});

=======
class ViewCarsScreen extends StatefulWidget {
  // const ViewCarsScreen({super.key});
  final int? userRole; // 🟡

  const ViewCarsScreen({super.key, this.userRole});
  @override
  State<ViewCarsScreen> createState() => _ViewCarsScreenState();
}

class _ViewCarsScreenState extends State<ViewCarsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddCarCubit>().fetchCarsFromServer();
  }

  @override
  void dispose() {
    super.dispose();
  }

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    // Get the cars when the screen is built
    final cars = context.read<AddCarCubit>().getCars();
    
=======
    // Get the current user
    final authCubit = context.read<AuthCubit>();
    final currentUser = authCubit.userModel;

    // Get the cars and filter by current user's ID
    // final allCars = context.read<AddCarCubit>().getCars();
    // final cars =
    //     allCars.where((car) => car.ownerId == currentUser?.id).toList();

    final cars = context.watch<AddCarCubit>().getCars();
    final filteredCars = cars.where((car) => car.ownerId == currentUser?.id).toList();

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======

      body: BlocBuilder<AddCarCubit, AddCarState>(
>>>>>>> Stashed changes
        builder: (context, state) {
          if (state is AddCarLoading) {
            return const Center(child: CircularProgressIndicator());
          }
<<<<<<< Updated upstream
          
          if (cars.isEmpty) {
=======

          // if (cars.isEmpty) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.directions_car_outlined,
          //           size: 64.sp,
          //           color: Colors.grey,
          //         ),
          //         SizedBox(height: 16.h),
                  // Text(
                  //   TextManager.noCarsMessage.tr(),
                  //   style: TextStyle(
                  //     fontSize: 16.sp,
                  //     color: Colors.grey,
                  //   ),
                  // ),
          if (state is AddCarError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          }

          if (state is AddCarFetchedSuccessfully) {
            final cars = state.cars;
            final filteredCars = cars.where((car) => car.ownerId == currentUser?.id).toList();

            if (widget.userRole == 1 || filteredCars.isEmpty) {
            // رينتر أو ماعندوش عربيات، نعرض شاشة فاضية مع زر إضافة عربية
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                    TextManager.noCarsMessage.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
=======
                    'No cars found. Add your first car!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, ScreensName.addCarScreen);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    label: Text(
                      'Add Car',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
>>>>>>> Stashed changes
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
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
} 