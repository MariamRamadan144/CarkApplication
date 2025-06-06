// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../core/utils/text_manager.dart';
// import '../../model/car_model.dart';
// import '../../screens/car_details_screen.dart';
//
// class AvailableCarsListWidget extends StatelessWidget {
//   final List<CarModel> allCars;
//
//   const AvailableCarsListWidget({super.key, required this.allCars});
//
//   @override
//   Widget build(BuildContext context) {
//     final availableCars = allCars.where(
//           (car) =>
//       car.currentStatus == 'Available' &&
//           car.availability == true &&
//           car.approvalStatus == true,
//     ).toList();
//
//     if (availableCars.isEmpty) {
//       return const Text('No cars available at the moment.');
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           TextManager.allCars.tr(),
//           style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 0.10.sh),
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: availableCars.length,
//           itemBuilder: (context, index) {
//             final car = availableCars[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => CarDetailsScreen(car: car),
//                   ),
//                 );
//               },
//               child: Card(
//                 elevation: 3,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       // Car Image
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           car.imageUrl,
//                           width: 100.w,
//                           height: 70.h,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => const Icon(Icons.directions_car),
//                         ),
//                       ),
//                       SizedBox(width: 12.w),
//
//                       // Car Info
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('${car.brand} ${car.model}',
//                                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
//                             SizedBox(height: 4.h),
//                             Text('Seats: ${car.seatingCapacity}'),
//                             Text(car.rentalOptions.availableWithDriver
//                                 ? 'With Driver'
//                                 : 'Without Driver'),
//                             Text(car.availability ? 'Available' : 'Not Available',
//                                 style: TextStyle(
//                                     color: car.availability ? Colors.green : Colors.red),),
//                             SizedBox(height: 4.h),
//                             Text(
//                               '${car.rentalOptions.dailyRentalPrice?.toStringAsFixed(2)} EGP / day',
//                               style: const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
