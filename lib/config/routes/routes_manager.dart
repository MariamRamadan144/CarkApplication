import 'package:flutter/material.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/features/auth/presentation/screens/login/login_screen.dart';
import 'package:test_cark/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:test_cark/features/splash/presentation/screens/get_started_screen.dart';
import '../../features/auth/presentation/screens/profile/edit_profile_screen.dart';
import '../../features/auth/presentation/screens/profile/profile_screen.dart';
import '../../features/auth/presentation/screens/upload_documents/document_upload_screen.dart';
import '../../features/home/presentation/screens/filter_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/rental_search_screen.dart';
import '../../features/shared/presentation/screens/navigation_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

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
