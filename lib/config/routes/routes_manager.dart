import 'package:flutter/material.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/features/auth/presentation/screens/login/login_screen.dart';
import 'package:test_cark/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:test_cark/features/cars/presentation/screens/view_car_details_screen.dart';
import 'package:test_cark/features/splash/presentation/screens/get_started_screen.dart';
import '../../features/auth/presentation/screens/profile/edit_profile_screen.dart';
import '../../features/auth/presentation/screens/profile/profile_screen.dart';
import '../../features/auth/presentation/screens/upload_documents/document_upload_screen.dart';
import '../../features/cars/presentation/screens/add_car_screen.dart';
import '../../features/cars/presentation/screens/car_rental_options_screen.dart';
import '../../features/cars/presentation/screens/car_usage_policy_screen.dart';
import '../../features/cars/presentation/screens/view_cars_screen.dart';
import '../../features/handover/presentation/cubits/renter_handover_cubit.dart';
import '../../features/handover/presentation/screens/renter_handover_screen.dart';
import '../../features/home/presentation/screens/booking_screens/booking_history_screen.dart';
import '../../features/home/presentation/screens/booking_screens/car_details_screen.dart';
import '../../features/home/presentation/screens/booking_screens/trip_details_screen.dart';
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
import '../../features/home/presentation/screens/location_tracking_screen.dart';
import '../../features/home/presentation/model/car_model.dart';
import '../../features/home/presentation/model/location_model.dart';
import '../../features/owner/presentation/screens/owner_navigation_screen.dart';
import '../../features/owner/presentation/screens/owner_home_screen.dart';
import '../../features/owner/presentation/screens/owner_profile_screen.dart';
import '../../features/owner/presentation/screens/owner_notification_screen.dart' hide OwnerNotificationScreen;
import '../../features/handover/presentation/screens/handover_screen.dart';
import '../../features/handover/presentation/screens/handover_confirmation_screen.dart';
import '../../features/renter/presentation/screens/renter_handover_screen.dart';
import '../../features/handover/presentation/screens/renter_drop_off_screen.dart';
import '../../features/handover/presentation/screens/owner_drop_off_screen.dart';
import '../../features/handover/presentation/models/post_trip_handover_model.dart';
import '../../features/handover/presentation/models/handover_log_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        
        // Convert stops to LocationModel list safely
        List<LocationModel> locationStops = [];
        try {
          for (var stop in stops) {
            if (stop is LocationModel) {
              locationStops.add(stop);
            } else if (stop is Map<String, dynamic>) {
              // Handle case where stop is a map that needs to be converted to LocationModel
              locationStops.add(LocationModel(
                name: stop['name']?.toString() ?? '',
                address: stop['address']?.toString() ?? '',
                coordinates: stop['coordinates'] is Map<String, dynamic> 
                  ? Map<String, double>.from(stop['coordinates'])
                  : null,
                description: stop['description']?.toString(),
              ));
            }
          }
        } catch (e) {
          // If conversion fails, use empty list
          print('Error converting stops to LocationModel: $e');
          locationStops = [];
        }
        
        return MaterialPageRoute(
            builder: (context) => TripManagementScreen(
                  car: car,
                  totalPrice: totalPrice,
                  stops: locationStops,
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

      case ScreensName.showCarDetailsScreen:
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

      case ScreensName.bookingHistoryScreen:
        return MaterialPageRoute(builder: (context) => const BookingHistoryScreen());

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

      case ScreensName.ownerNavigationScreen:
        return MaterialPageRoute(builder: (context) => const OwnerNavigationScreen());
      case ScreensName.ownerHomeScreen:
        return MaterialPageRoute(builder: (context) => const OwnerHomeScreen());
      case ScreensName.ownerProfileScreen:
        return MaterialPageRoute(builder: (context) => const OwnerProfileScreen());
      case ScreensName.ownerNotificationScreenMain:
        return MaterialPageRoute(builder: (context) => const OwnerNotificationScreen());

      case ScreensName.handoverScreen:
        return MaterialPageRoute(builder: (context) => const HandoverScreen());

      case ScreensName.handoverConfirmationScreen:
        return MaterialPageRoute(
          builder: (context) => const HandoverConfirmationScreen(),
        );

      case ScreensName.renterHandoverScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => RenterHandoverCubit(),
            child: const RenterHandoverScreen(),
          ),
        );

      case ScreensName.tripDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const TripDetailsScreen(),
        );

      case ScreensName.locationTrackingScreen:
        if (routeSettings.arguments is CarModel) {
          return MaterialPageRoute(
            builder: (context) => LocationTrackingScreen(
              car: routeSettings.arguments as CarModel,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Error: No car data provided for location tracking')),
          ),
        );

      case ScreensName.renterDropOffScreen:
        if (routeSettings.arguments is Map<String, dynamic>) {
          final args = routeSettings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => RenterDropOffScreen(
              tripId: args['tripId'] as String,
              carId: args['carId'] as String,
              renterId: args['renterId'] as String,
              ownerId: args['ownerId'] as String,
              paymentMethod: args['paymentMethod'] as String,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Error: Missing required arguments for renter drop-off')),
          ),
        );

      case ScreensName.ownerDropOffScreen:
        if (routeSettings.arguments is Map<String, dynamic>) {
          final args = routeSettings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => OwnerDropOffScreen(
              handoverData: args['handoverData'] as PostTripHandoverModel,
              logs: args['logs'] as List<HandoverLogModel>,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Error: Missing required arguments for owner drop-off')),
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