import 'package:flutter/material.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/features/auth/presentation/screens/login/login_screen.dart';
import 'package:test_cark/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:test_cark/features/cars/presentation/screens/view_car_details_screen.dart';
import 'package:test_cark/features/splash/presentation/screens/get_started_screen.dart';
import '../../features/auth/presentation/screens/profile/edit_profile_screen.dart';
import '../../features/auth/presentation/screens/profile/profile_screen.dart';
import '../../features/auth/presentation/screens/upload_documents/document_upload_screen.dart';
import '../../features/cars/presentation/screens/addcar_screen.dart';
import '../../features/cars/presentation/screens/car_rental_options_screen.dart';
import '../../features/cars/presentation/screens/car_usage_policy_screen.dart';
import '../../features/cars/presentation/screens/view_cars_screen.dart';
import '../../features/home/presentation/screens/booking_screens/car_details_screen.dart';
import '../../features/home/presentation/screens/home_screens/filter_screen.dart';
import '../../features/home/presentation/screens/home_screens/home_screen.dart';
import '../../features/home/presentation/screens/booking_screens/rental_search_screen.dart';
import '../../features/notifications/presentation/screens/owner_notification_screen.dart';
import '../../features/notifications/presentation/screens/renter_notification_screen.dart';
import '../../features/shared/presentation/screens/navigation_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/booking_screens/booking_summary_screen.dart';
import '../../features/home/presentation/screens/booking_screens/trip_management_screen.dart';
import '../../features/home/presentation/screens/booking_screens/payment_screen.dart';
import '../../features/home/presentation/model/car_model.dart';
import '../../features/home/presentation/model/location_model.dart';

abstract class RoutesManager {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    print("in RoutesManager , route settings name: ${routeSettings.name}");
    switch (routeSettings.name) {
      case ScreensName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case ScreensName.getStarted:
        return MaterialPageRoute(
            builder: (context) => const GetStartedScreen());
      case ScreensName.login:
        return MaterialPageRoute(builder: (context) => (LoginScreen()));
      case ScreensName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case ScreensName.profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case ScreensName.editProfile:
        return MaterialPageRoute(
            builder: (context) => const EditProfileScreen());
      case ScreensName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case ScreensName.mainNavigationScreen:
        return MaterialPageRoute(builder: (context) => MainNavigationScreen());
      case ScreensName.filterScreen:
        return MaterialPageRoute(builder: (context) => const FilterScreen());

      case ScreensName.rentalSearchScreen:
        return MaterialPageRoute(
            builder: (context) => const RentalSearchScreen());
      case ScreensName.bookingSummaryScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;
        final car = args['car'] as CarModel;
        final totalPrice = args['totalPrice'] as double;
        return MaterialPageRoute(
            builder: (context) => BookingSummaryScreen(
                  car: car,
                  totalPrice: totalPrice,
                ));
      case ScreensName.tripManagementScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;
        final car = args['car'] as CarModel;
        final totalPrice = args['totalPrice'] as double;
        final stops = args['stops'] as List<dynamic>;
        return MaterialPageRoute(
            builder: (context) => TripManagementScreen(
                  car: car,
                  totalPrice: totalPrice,
                  stops: stops.cast<LocationModel>(),
                ));
      case ScreensName.paymentScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;
        final totalPrice = args['totalPrice'] as double;
        return MaterialPageRoute(
            builder: (context) => PaymentScreen(
                  totalPrice: totalPrice,
                ));
      case ScreensName.ownerNotificationScreen:
        return MaterialPageRoute(
            builder: (context) => const OwnerNotificationScreen());
      case ScreensName.renterNotificationScreen:
        return MaterialPageRoute(
            builder: (context) => const RenterNotificationScreen());

      case ScreensName.ShowCarDetailsScreen:
        if (routeSettings.arguments is CarModel) {
          return MaterialPageRoute(
            builder: (context) => ViewCarDetailsScreen(car: routeSettings.arguments as CarModel),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Error: No car data provided')),
          ),
        );

      case ScreensName.viewCarsScreen:
        return MaterialPageRoute(builder: (context) => const ViewCarsScreen());

      case ScreensName.addCarScreen:
        return MaterialPageRoute(builder: (context) => const AddCarScreen());

      case ScreensName.rentalOptionScreen:
        if (routeSettings.arguments is CarModel) {
          return MaterialPageRoute(
            builder: (context) => CarRentalOptionsScreen(
              carData: routeSettings.arguments as CarModel,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Error: No car data provided'),
            ),
          ),
        );

      case ScreensName.usagePolicyScreen:
        if (routeSettings.arguments is Map<String, dynamic>) {
          final args = routeSettings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CarUsagePolicyScreen(
              carData: args['car'] as CarModel,
              rentalOptions: args['rentalOptions'] as RentalOptions,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Error: Invalid arguments for usage policy screen'),
            ),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Error , failed to navigate'),
            ),
          );
        });
    }
  }
}
