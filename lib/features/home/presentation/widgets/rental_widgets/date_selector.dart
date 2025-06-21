import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/features/home/presentation/cubit/car_cubit.dart';
import 'package:test_cark/features/home/presentation/cubit/choose_car_state.dart';
import '../../cubit/rental_cubit.dart';
import '../../cubit/rental_state.dart';


class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarCubit, ChooseCarState>(
      builder: (context, state) {
        final dateRange = state.dateRange;

        return GestureDetector(
          onTap: () async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              context.read<CarCubit>().setDateRange(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onSecondaryFixed),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.calendar_today, size: 20, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 0.03.sw),
                Text(
                  dateRange != null
                      ? '${DateFormat('MMM dd | hh:mm a').format(dateRange.start)} - ${DateFormat('MMM dd | hh:mm a').format(dateRange.end)}'
                      : 'Select rental date range'.tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            )
          ),
        );
      },
    );
  }
}
