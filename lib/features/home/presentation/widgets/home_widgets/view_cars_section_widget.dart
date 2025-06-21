import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/text_manager.dart';
import '../../cubit/car_cubit.dart';
import '../../cubit/choose_car_state.dart';
import '../../cubit/rental_cubit.dart';
import '../../model/car_model.dart';
import '../../screens/car_details_screen.dart';
import 'car_card_widget.dart';

class ViewCarsSectionWidget extends StatelessWidget {
  ViewCarsSectionWidget({super.key});

  // Dummy data for cars
  final List<CarModel> dummyCars = [
    CarModel(
      id: 1,
      model: 'Corolla',
      brand: 'Toyota',
      carType: 'Sedan',
      carCategory: 'Economy',
      plateNumber: 'ABC123',
      year: 2020,
      color: 'White',
      seatingCapacity: 5,
      transmissionType: 'Automatic',
      fuelType: 'Petrol',
      currentOdometerReading: 35000,
      availability: true,
      currentStatus: 'Available',
      approvalStatus: true,
      rentalOptions: RentalOptions(
        availableWithoutDriver: true,
        availableWithDriver: false,
        dailyRentalPrice: 150.0,
      ),
      imageUrl:
      'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_960_720.jpg',
    ),
    CarModel(
      id: 2,
      model: 'X5',
      brand: 'BMW',
      carType: 'SUV',
      carCategory: 'Luxury',
      plateNumber: 'XYZ789',
      year: 2022,
      color: 'Black',
      seatingCapacity: 7,
      transmissionType: 'Automatic',
      fuelType: 'Diesel',
      currentOdometerReading: 12000,
      availability: true,
      currentStatus: 'Available',
      approvalStatus: true,
      rentalOptions: RentalOptions(
        availableWithoutDriver: false,
        availableWithDriver: true,
        dailyRentalPriceWithDriver: 400.0,
      ),
      imageUrl:
      'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_960_720.jpg',
    ),
    CarModel(
      id: 3,
      model: 'Model 3',
      brand: 'Tesla',
      carType: 'Sedan',
      carCategory: 'Electric',
      plateNumber: 'TESLA01',
      year: 2023,
      color: 'Red',
      seatingCapacity: 5,
      transmissionType: 'Automatic',
      fuelType: 'Electric',
      currentOdometerReading: 5000,
      availability: true,
      currentStatus: 'Available',
      approvalStatus: true,
      rentalOptions: RentalOptions(
        availableWithoutDriver: true,
        availableWithDriver: false,
        dailyRentalPrice: 350.0,
        dailyRentalPriceWithDriver: 450.0,
      ),
      imageUrl:
      'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_960_720.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarCubit, ChooseCarState>(
      builder: (context, state) {
        final rentalState = context.watch<CarCubit>().state;
        final showWithDriver = rentalState.withDriver;
        final showWithoutDriver = rentalState.withoutDriver;

        final filteredCars = dummyCars.where((car) {
          final matchesType =
              state.carType == null || car.carType == state.carType;

          final matchesCategory =
              state.category == null || car.carCategory == state.category;

          final matchesTransmission = state.transmission == null ||
              car.transmissionType == state.transmission;

          final matchesFuel =
              state.fuel == null || car.fuelType == state.fuel;

          // Driver filter logic:
          // - If withDriver is true: show only cars available with driver
          // - If withoutDriver is true: show only cars available without driver  
          // - If both are null: show all cars (no driver filter applied)
          final matchesDriver = (showWithDriver == true && car.rentalOptions.availableWithDriver == true) ||
              (showWithoutDriver == true && car.rentalOptions.availableWithoutDriver == true) ||
              (showWithDriver == null && showWithoutDriver == null);

          return matchesType &&
              matchesCategory &&
              matchesTransmission &&
              matchesFuel &&
              matchesDriver;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              TextManager.allCars.tr(),
              style: TextStyle(fontSize: 0.02.sh, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0.02.sh),

            // Debug information (can be removed in production)
            if (showWithDriver != null || showWithoutDriver != null)
              Padding(
                padding: EdgeInsets.only(bottom: 0.01.sh),
                child: Text(
                  "Driver Filter: ${showWithDriver == true ? 'With Driver' : showWithoutDriver == true ? 'Without Driver' : 'None'}",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),

            // Cars list
            if (filteredCars.isEmpty)
              Text(
                "No cars match your filters.",
                style: TextStyle(fontSize: 16.sp),
              )
            else
              ListView.builder(
                itemCount: filteredCars.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CarCardWidget(
                    car: filteredCars[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CarDetailsScreen(car: filteredCars[index]),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
