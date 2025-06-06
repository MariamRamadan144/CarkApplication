import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/core/utils/text_manager.dart';
import 'package:test_cark/features/home/presentation/widgets/home_widgets/reusable_container.dart';
import '../presentation/cubit/home_cubit.dart';
// Done
// class DriverOption extends StatelessWidget {
//   const DriverOption({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     const options = CarCubit.driverOptions;
//     final selected = context.watch<CarCubit>().state.withDriver;
//     final cubit = context.read<CarCubit>();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Driver Options Title
//         Text(
//           TextManager.driverOption.tr(),
//           style: TextStyle(fontSize: 0.02.sh, fontWeight: FontWeight.bold),
//         ),
//
//         SizedBox(height: 0.01.sh),
//
//         // Driver Options List
//         SizedBox(
//           height: 0.05.sh,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: options.length,
//             separatorBuilder: (_, __) => SizedBox(width: 0.03.sw),
//             itemBuilder: (context, index) {
//               // Get the option and check if it is selected
//               final option = options[index];
//               final isSelected = (option == TextManager.withDriver.tr() &&
//                       (selected == true)) ||
//                   (option == TextManager.withoutDriver.tr() &&
//                       (selected == false));
//
//               return GestureDetector(
//                 onTap: () => cubit.setWithDriver(
//                   option == TextManager.withDriver.tr(),
//                 ),
//                 // Driver Options Container
//                 child:
//                     ReusableContainer(isSelected: isSelected, option: option),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
