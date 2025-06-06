import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/text_manager.dart';
import '../../model/car_model.dart';


// favorite screen
// rates
class CarCardWidget extends StatelessWidget {
  final CarModel car;
  final VoidCallback onTap;

  const CarCardWidget({
    super.key,
    required this.car,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final price = car.rentalOptions.availableWithoutDriver
        ? car.rentalOptions.dailyRentalPrice
        : car.rentalOptions.dailyRentalPriceWithDriver;

    final hasDriver = car.rentalOptions.availableWithDriver;
    final availability = car.availability ? TextManager.available.tr() : TextManager.unAvailable.tr();

    return GestureDetector(
      onTap: onTap,

      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Using Stack to overlay the image and icons
            Stack(
              children: [
                // Positioned to place the image at the top of the card
                ClipRRect(
                  // Using ClipRRect to apply rounded corners to the image
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12),),
                  // Displaying the car image - from database
                  child: Image.network(
                    car.imageUrl,
                    height: 0.2.sh,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Positioned to place the icons on top of the image
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                ),

                // Positioned to place the rating badge on the top left corner
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.01.sh),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // Displaying the rating icon and value
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 0.01.sw),
                        // Displaying a static rating for demonstration purposes
                        Text('4.9', style: TextStyle(fontSize: 12.sp),),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Car details section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.04.sh),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Displaying the car type
                  Text(
                    car.carType,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.01.sh),

                  // Displaying the car brand and model with price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Display the car brand and model
                      Text(
                        "${car.brand} ${car.model}",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),

                      SizedBox(width: 0.01.sh),

                      // Display the price per day
                      Text(
                        "\$${price?.toStringAsFixed(2) ?? 'N/A'}/day",
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.01.sh),

                  // Displaying the car transmission type , fuel type and seating capacity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoIcon(Icons.settings, car.transmissionType, context),
                      _buildInfoIcon(Icons.local_gas_station, car.fuelType , context),
                      _buildInfoIcon(Icons.event_seat, "${car.seatingCapacity} ${TextManager.seats.tr()}", context),
                    ],
                  ),
                  SizedBox(height: 0.02.sh),

                  // Displaying the availability status and driver option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Displaying the availability status and driver option
                      Text(
                        hasDriver ? TextManager.withDriver.tr()  :TextManager.withoutDriver.tr() ,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: hasDriver ? Colors.green : Colors.red,
                        ),
                      ),

                      // Displaying the availability status
                      Text(
                        availability,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: car.availability ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: 0.04.sw),
        Text(text, style: TextStyle(fontSize: 12.sp),),
      ],
    );
  }
}
