// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/utils/text_manager.dart';
// import '../cubit/home_cubit.dart';
// import '../widgets/search_widgets/apply_button.dart';
// import '../widgets/search_widgets/custom_search_bar.dart';
// import '../widgets/search_widgets/filter_config.dart';
// import '../widgets/search_widgets/filter_option_item.dart';
// import '../widgets/search_widgets/filter_options.dart';
// /// version 1
// // class FilterScreen extends StatefulWidget {
// //   const FilterScreen({super.key});
// //
// //   @override
// //   _FilterScreenState createState() => _FilterScreenState();
// // }
// //
// // class _FilterScreenState extends State<FilterScreen> {
// //   // Filter options
// //   Map<String, bool> filters = {
// //     TextManager.location.tr(): false,
// //     TextManager.capacity.tr(): false,
// //     TextManager.brand.tr(): false,
// //     TextManager.price.tr(): false,
// //     TextManager.model.tr(): false,
// //     TextManager.availability.tr(): false,
// //   };
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Theme.of(context).colorScheme.onPrimary,
// //
// //       // AppBar
// //       appBar: AppBar(
// //         backgroundColor: Theme.of(context).colorScheme.onPrimary,
// //         elevation: 0,
// //
// //         // Screen title
// //         title: Text(
// //           TextManager.filter.tr(),
// //           style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary),
// //         ),
// //
// //         // Camera icon button
// //         actions: [
// //           Padding(
// //             padding: EdgeInsets.only(right: 0.06.sw),
// //             child: IconButton(
// //               icon: Icon(Icons.camera_alt, size: 24, color: Theme.of(context).colorScheme.onSecondary),
// //               onPressed: () {},
// //             ),
// //           ),
// //         ],
// //       ),
// //
// //       // Body
// //       body: Padding(
// //         padding: EdgeInsets.all(0.04.sw),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Search Bar
// //             const CustomSearchBar(),
// //
// //             SizedBox(height: 0.02.sh),
// //
// //             // Filter Options
// //             Expanded(
// //               child: ListView(
// //                 children: filters.keys.map((filter) {
// //                   return Padding(
// //                     padding: EdgeInsets.only(bottom: 0.01.sh),
// //                     child: FilterOption(
// //                       title: filter,
// //                       isSelected: filters[filter]!,
// //                       onTap: () {
// //                         setState(() {
// //                           filters[filter] = !filters[filter]!;
// //                         });
// //                       },
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //
// //             // Apply Button
// //             const ApplyButton(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// /// version 2
//
//
// class FilterScreen extends StatelessWidget {
//   const FilterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.watch<FilterCubit>();
//
//     // Get filter actions from the FilterConfig
//     final filterActions = FilterConfig.getFilterActions(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text(TextManager.filter.tr()),),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             //
//             Expanded(
//               child: ListView(
//                 // handle
//                 children: filterActions.entries.map((entry) {
//                   final isSelected = _isSelected(entry.key, cubit);
//                   return FilterOptionItem(
//                     title: entry.key,
//                     isSelected: isSelected,
//                     onTap: () => entry.value(context),
//                   );
//                 }).toList(),
//               ),
//             ),
//
//             const ApplyButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool _isSelected(String key, FilterCubit cubit) {
//     if (key == TextManager.brand.tr()) {
//       return cubit.state.selectedBrands.isNotEmpty;
//     }
//   if (key == TextManager.model.tr()) {
//       return cubit.state.selectedModels.isNotEmpty;
//     }
//   if (key == TextManager.seats.tr()) {
//       return cubit.state.selectedSeats.isNotEmpty;
//     }
//   if (key == TextManager.availability.tr()) {
//       return cubit.state.selectedAvailability.isNotEmpty;
//     }
//   if (key == TextManager.carCategory.tr()) {
//       return cubit.state.selectedCarCategories.isNotEmpty;
//     }
//
//     return false;
//   }
// }
