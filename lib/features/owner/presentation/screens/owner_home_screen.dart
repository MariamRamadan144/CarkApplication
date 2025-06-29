import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cark/features/cars/presentation/widgets/car_data_table.dart';
import 'package:test_cark/features/cars/presentation/cubits/add_car_cubit.dart';
import 'package:test_cark/features/cars/presentation/cubits/add_car_state.dart';
import 'package:test_cark/features/cars/presentation/screens/add_car_screen.dart';

class OwnerHomeScreen extends StatelessWidget {
  // const OwnerHomeScreen({Key? key}) : super(key: key);
  final int? userRole;

<<<<<<< Updated upstream
  void _navigateToAddCar(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCarScreen()),
    );
    if (result == true) {
      // Just pop back, OwnerNavigationScreen will handle refresh and tab switch
      Navigator.pop(context);
    }
  }

=======
  const OwnerHomeScreen({Key? key, this.userRole}) : super(key: key);
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cars'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAddCar(context),
            tooltip: 'Add Car',
          ),
        ],
      ),
<<<<<<< Updated upstream
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddCarCubit, AddCarState>(
          listener: (context, state) {
            if (state is AddCarError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cars = context.read<AddCarCubit>().getCars();
            return SingleChildScrollView(
              child: Column(
                children: [
                  CarDataTable(
                    cars: cars,
                    onEdit: (car) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit tapped!')),
                      );
                    },
                    onDelete: (car) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Delete tapped!')),
                      );
                    },
                    onViewDetails: (car) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('View details tapped!')),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
=======
      drawer: const OwnerDrawer(),
      // body: const ViewCarsScreen(),
      body: ViewCarsScreen(userRole: userRole),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreensName.addCarScreen);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
>>>>>>> Stashed changes
      ),
    );
  }
} 