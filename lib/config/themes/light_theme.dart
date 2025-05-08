// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:test_cark/cark.dart';
// import 'package:test_cark/core/constants/app_colors.dart';
//
// ThemeData lightTheme = ThemeData(
//   fontFamily: 'Inter',
//   colorScheme: const ColorScheme(
//     brightness: Brightness.light,
//     primary: AppColors.primary,
//     onPrimary: AppColors.white,
//     secondary: AppColors.gray,
//     onSecondary: AppColors.black,
//     error: AppColors.red,
//     onError: AppColors.white,
//     surface: AppColors.white,
//     onSurface: AppColors.black,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//    style: ElevatedButton.styleFrom(
//      backgroundColor: AppColors.primary,
//      textStyle: TextStyle(
//        fontWeight: FontWeight.w600,
//        fontSize: 20.sp,
//        color: AppColors.white,
//      ),
//      fixedSize: const Size(double.infinity, 48),
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(15),
//        side: const BorderSide(
//          color:  AppColors.primary,
//          width: 1,
//        ),
//      ),
//    ),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     fillColor: AppColors.white,
//     filled: true,
//     hintStyle: TextStyle(
//       color: AppColors.lightBlack,
//       fontWeight: FontWeight.w400,
//       fontSize: 17,
//     ),
//     border: decorateBorder(AppColors.lightBlack),
//     enabledBorder: decorateBorder(AppColors.lightBlack),
//     focusedBorder: decorateBorder(AppColors.lightBlack),
//     errorBorder: decorateBorder(AppColors.red),
//     errorStyle: const TextStyle(
//       color: AppColors.red,
//       fontWeight: FontWeight.w400,
//       fontSize: 17,
//     ),
//   ),
// );
//
// OutlineInputBorder decorateBorder(Color color){
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10),
//     borderSide: BorderSide(
//       color: color,
//     ),
//
//   );
// }
// Importing localization package for multi-language support
import 'package:easy_localization/easy_localization.dart';

// Core Flutter UI toolkit
import 'package:flutter/material.dart';

// For responsive UI based on screen size
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Importing app-specific modules
import 'package:test_cark/cark.dart';
import 'package:test_cark/config/themes/app_colors.dart';

// Defining the light theme for the application
ThemeData lightTheme = ThemeData(
  // Setting default font for the whole app
  fontFamily: 'Inter',
  // Defining the overall color scheme for light mode
  colorScheme: const ColorScheme(
    // Light theme brightness
    brightness: Brightness.light,
    // Main color (e.g. buttons)
    primary: AppColors.primary,
    // Text color on primary elements
    onPrimary: AppColors.white,
    // Secondary color
    secondary: AppColors.gray,
    // Text color on secondary
    onSecondary: AppColors.black,
    // Error color
    error:AppColors.red,
    // Text color on error background
    onError: AppColors.white,
    // Background for cards, sheets, etc.
    surface: AppColors.white,
    // Text color on surfaces
    onSurface: AppColors.black,
  ),
  // Styling for all ElevatedButtons in the app
  elevatedButtonTheme: ElevatedButtonThemeData(
    // style: ElevatedButton.styleFrom(
    //   // Button background
    //   backgroundColor: AppColors.primary,
    //   // Button text style
    //   textStyle: TextStyle(
    //     fontWeight: FontWeight.w600,
    //     // Responsive font size
    //     fontSize: 20.sp,
    //     // Text color
    //     color: AppColors.white,
    //   ),
    //
    //   // Full-width button with fixed height
    //   fixedSize: const Size(double.infinity, 48),
    //
    //   // Rounded corners and border
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15),
    //     side: const BorderSide(
    //       color: AppColors.primary,
    //       width: 1,
    //     ),
    //   ),
    // ),
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.red),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.w600,
          // Responsive font size
          fontSize: 20.sp,
          // Text color
          color: AppColors.white,
        ),
      ),
      shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            );
          } else {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            );
          }
        },
      ),
      fixedSize: WidgetStateProperty.all<Size>(
        const Size(double.infinity, 48),
      ),
    ),
  ),
  // Styling for all TextFields in the app
  inputDecorationTheme: InputDecorationTheme(
    // Fill color of the text field
    fillColor: AppColors.white,

    // Enables the fill color
    filled: true,

    // Style for hint text
    hintStyle: TextStyle(
      color: AppColors.lightBlack,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),

    // Default border
    border: decorateBorder(AppColors.lightBlack),

    // When not focused
    enabledBorder: decorateBorder(AppColors.lightBlack),

    // When focused
    focusedBorder: decorateBorder(AppColors.lightBlack),

    // When error exists
    errorBorder: decorateBorder(AppColors.red),

    // Error text style
    errorStyle: const TextStyle(
      color: AppColors.red,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.gray,
    backgroundColor: AppColors.white,
  ),
);

// Helper function to return a border with custom color
OutlineInputBorder decorateBorder(Color color) {
  return OutlineInputBorder(
    // Rounded corners for input field
    borderRadius: BorderRadius.circular(10),

    // Dynamic color for border
    borderSide: BorderSide(
      color: color,
    ),
  );
}
