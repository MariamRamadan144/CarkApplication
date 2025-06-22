import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/themes/app_colors.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import '../../model/car_model.dart';
import '../../model/location_model.dart';

class BookingSummaryScreen extends StatefulWidget {
  final CarModel car;
  final double totalPrice;

  const BookingSummaryScreen(
      {super.key, required this.car, required this.totalPrice});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(tr("booking_confirmation"),
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarDetails(),
            SizedBox(height: 24.h),
            _buildConditions(),
            SizedBox(height: 24.h),
            _buildBookingOverview(),
            SizedBox(height: 32.h),
            _buildAgreementSection(),
            SizedBox(height: 40.h),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarDetails() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.car.brand} ${widget.car.model}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              '${tr("or_similar")} | ${widget.car.carType}',
              style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditions() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr("conditions"),
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr("maximum_deductible"),
                    style: TextStyle(
                        fontSize: 15.sp, color: Colors.grey.shade700)),
                Text(tr("up_to_800"),
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(tr("included_no_extra_cost"),
                    style: TextStyle(fontSize: 15.sp, color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingOverview() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr("booking_overview"),
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            SizedBox(height: 16.h),
            _buildOverviewItem(Icons.check_circle, tr("third_party_insurance"),
                AppColors.primary),
            _buildOverviewItem(
                Icons.check_circle,
                tr("collision_damage_waiver"),
                AppColors.primary),
            _buildOverviewItem(Icons.check_circle,
                tr("theft_protection"), AppColors.primary),
            _buildOverviewItem(
                Icons.check_circle, tr("km_included"), AppColors.primary),
            _buildOverviewItem(Icons.check_circle,
                tr("flexible_booking"), AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: iconColor),
          SizedBox(width: 12.w),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 15.sp, color: Colors.grey.shade800))),
        ],
      ),
    );
  }

  Widget _buildAgreementSection() {
    return Card(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreedToTerms = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                        child: Text(tr("agree_to_terms"),
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey.shade800))),
                  ],
                ),
                Divider(height: 1.h, color: Colors.grey.shade200),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  child: _buildTotalPrice(),
                )
              ],
            )));
  }

  Widget _buildTotalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr("total_price"),
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        Text(
          '\$${widget.totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _agreedToTerms
            ? () {
                // Create sample stops for the trip
                final stops = [
                  LocationModel(
                    name: 'Pickup Station - Riyadh Central',
                    address: 'King Fahd Road, Riyadh',
                    description: 'Main pickup location',
                  ),
                  LocationModel(
                    name: 'Stop 1 - Shopping Mall',
                    address: 'Olaya Street, Riyadh',
                    description: 'Shopping destination',
                  ),
                  LocationModel(
                    name: 'Stop 2 - Business District',
                    address: 'King Abdullah Financial District',
                    description: 'Business meeting location',
                  ),
                  LocationModel(
                    name: 'Return Station - Airport',
                    address: 'King Khalid International Airport',
                    description: 'Final destination',
                  ),
                ];
                
                Navigator.pushNamed(
                  context,
                  ScreensName.tripManagementScreen,
                  arguments: {
                    'car': widget.car,
                    'totalPrice': widget.totalPrice,
                    'stops': stops,
                  },
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 7.h),
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(tr("continue_button"),
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
} 