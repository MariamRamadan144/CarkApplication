import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/themes/app_colors.dart';
import 'package:test_cark/features/home/presentation/cubit/booking_cubit.dart';
import '../../model/booking_model.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch bookings when the screen is first loaded
    context.read<BookingCubit>().fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('booking_history')),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingError) {
            return Center(child: Text(state.message));
          } else if (state is BookingLoaded) {
            if (state.bookings.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history,
                        size: 80.sp, color: Colors.grey.shade400),
                    SizedBox(height: 20.h),
                    Text(tr('no_booking_history'),
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700)),
                    SizedBox(height: 8.h),
                    Text(tr('no_bookings_yet'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp, color: Colors.grey.shade500)),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.h),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            booking.car.imageUrl,
                            width: 100.w,
                            height: 75.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${booking.car.brand} ${booking.car.model}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Booked: ${DateFormat.yMMMd().format(booking.startDate)} - ${DateFormat.yMMMd().format(booking.endDate)}',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade600),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '\$${booking.totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink(); // Should not happen
        },
      ),
    );
  }
} 