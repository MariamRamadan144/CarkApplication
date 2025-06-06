import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/core/utils/text_manager.dart';
import '../cubit/home_cubit.dart';
import '../widgets/filter_widgets/car_category_widget.dart';
import '../widgets/filter_widgets/car_type_widget.dart';

class FilterScreen2 extends StatelessWidget {
  const FilterScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final carCubit = context.read<CarCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.02.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Close & Clear
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Close Button
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        Navigator.pushNamed(context, ScreensName.homeScreen),
                  ),

                  // Filter Title
                  Text(
                    TextManager.filter.tr(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      carCubit.resetFilters();
                    },
                    child: Text(
                      TextManager.clear.tr(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 0.02.sh),

              // Car Type Filter Widget
              const CarTypeWidget(),

              SizedBox(height: 0.05.sh),

              // Car Category Filter Widget
              const CarCategoryWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
