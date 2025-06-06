import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/text_manager.dart';
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
        availableWithDriver: true,
        dailyRentalPrice: 350.0,
        dailyRentalPriceWithDriver: 450.0,
      ),
      imageUrl:
      'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_960_720.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          TextManager.allCars.tr(),
          style:
          TextStyle(fontSize: 0.02.sh, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 0.04.sh),

        // Cars List
        ListView.builder(
          itemCount: dummyCars.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CarCardWidget(
              car: dummyCars[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CarDetailsScreen(car: dummyCars[index]),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
