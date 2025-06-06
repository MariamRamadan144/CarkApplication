// search bar and we will remove
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/utils/text_manager.dart';
// import '../../cubit/home_cubit.dart';
// import '../../screens/availability_filter_screen.dart';
// import '../../screens/brand_filter_screen.dart';
// import '../../screens/car_category_filter_screen.dart';
// import '../../screens/car_type_filter_screen.dart';
// import '../../screens/driver_option_filter_screen.dart';
// import '../../screens/fuel_type_filter_screen.dart';
// import '../../screens/model_filter_screen.dart';
// import '../../screens/price_filter_screen.dart';
// import '../../screens/seats_filter_screen.dart';
// import '../../screens/transmission_type_filter_screen.dart';
// //
// // // type definition
// // typedef FilterAction = Future<void> Function(BuildContext context);
// //
// // class FilterConfig {
// //   // Key : filter name , Value : function to handle the filter action
// //   static Map<String, FilterAction> getFilterActions(BuildContext context) {
// //
// //     return {
// //       'Brand': (context) async {
// //         final selected = await Navigator.push<List<String>>(
// //           context,
// //           MaterialPageRoute(builder: (_) => const BrandFilterScreen()),
// //         );
// //         if (selected != null) {
// //           context.read<FilterCubit>().updateSelectedBrands(selected);
// //         }
// //       },
// //
// //       // Add other filters similarly
// //     };
// //   }
// // }
//
//
//
//
// // type definition
// typedef FilterAction = Future<void> Function(BuildContext context);
//
// class FilterConfig {
//   // Key : filter name , Value : function to handle the filter action
//   static Map<String, FilterAction> getFilterActions(BuildContext context) {
//     return {
//
//       TextManager.brand.tr(): (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const BrandFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedBrands(selected);
//         }
//       },
//
//       TextManager.price.tr(): (context) async {
//         final selected =  await Navigator.push<RangeValues>(
//           context,
//           MaterialPageRoute(builder: (_) => const PriceFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedPriceRange(selected);
//         }
//       },
//
//       'Model': (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const ModelFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedModels(selected);
//         }
//       },
//
//       'Car Type': (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const CarTypeFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedCarTypes(selected);
//         }
//       },
//
//       'Availability': (context) async {
//         final selected = await Navigator.push<String>(
//           context,
//           MaterialPageRoute(builder: (_) => const AvailabilityFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedAvailability(selected);
//         }
//       },
//
//       'Car Categories': (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const CarCategoryFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedCarCategories(selected);
//         }
//       },
//
//       'Driver Options': (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const DriverOptionFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedDriverOptions(selected);
//         }
//       },
//
//       'Seats': (context) async {
//         final selected = await Navigator.push<List<int>>(
//           context,
//           MaterialPageRoute(builder: (_) => const SeatsFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedSeats(selected);
//         }
//       },
//
//       'Fuel Type': (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const FuelTypeFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedFuelTypes(selected);
//         }
//       },
//
//       'Transmission Types': (context) async {
//         final selected = await Navigator.push<List<String>>(
//           context,
//           MaterialPageRoute(builder: (_) => const TransmissionTypeFilterScreen()),
//         );
//         if (selected != null) {
//           context.read<FilterCubit>().updateSelectedTransmissionTypes(selected);
//         }
//       },
//     };
//   }
// }
