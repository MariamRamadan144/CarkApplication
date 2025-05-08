import 'package:flutter/material.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/features/auth/presentation/screens/login_screen.dart';
import 'package:test_cark/features/auth/presentation/screens/signup.dart';
import 'package:test_cark/features/splash/presentation/screens/get_started_screen.dart';
import '../../features/auth/presentation/screens/login_cubit_test.dart';
import '../../features/auth/presentation/screens/signup_cubit_test.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

abstract class RoutesManager {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    print("in RoutesManager , route settings name: ${routeSettings.name}" );
    switch (routeSettings.name) {
      case ScreensName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case ScreensName.getStarted:
        return MaterialPageRoute(builder: (context) => const GetStartedScreen());
      case ScreensName.login:
        return MaterialPageRoute(builder: (context) =>  (LoginScreen())); // LoginCubitTest
      case ScreensName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpCubitTest()); // SignUpScreen
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
