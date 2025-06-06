import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/features/home/removed/transmission_widget.dart';

import '../filter_widgets/car_category_widget.dart';
import '../filter_widgets/car_type_widget.dart';
import '../../../removed/driver_option_widget.dart';
import '../../../removed/fuel_type_widget.dart';

class FilterSectionWidget extends StatelessWidget {
  const FilterSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Car Type, Category, Fuel Type, Driver Option, Transmission
        const CarTypeWidget(),
        SizedBox(height: 0.04.sh),

        // const CarCategoryWidget(),
        // SizedBox(height: 0.04.sh),
        //
        // const FuelTypeWidget(),
        // SizedBox(height: 0.04.sh),
        //
        // const DriverOption(),
        // SizedBox(height: 0.04.sh),
        //
        // const TransmissionWidget(),
        // SizedBox(height: 0.04.sh),
      ],
    );
  }
}
