import 'package:flutter/material.dart';
import 'package:test_cark/core/utils/assets_manager.dart';

import '../../../auth/presentation/screens/login_screen.dart';


/// clean
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF05011F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                   AssetsManager.map,
                    //'assets/images/img/map2.png'
                    width: screenWidth
                ),
                Column(
                  children: [
                    Text(
                      'CAR',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: screenWidth * 0.15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.002),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.15),
                      child: Text(
                        'RENTAL',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'NEED',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
                fontSize: screenWidth * 0.08,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'A CAR ?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.09,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Image.asset(
              AssetsManager.car,
              // 'assets/images/img/car.png',
              width: screenWidth * 0.5,
            ),
            SizedBox(height: screenHeight * 0.08),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
                    pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOutQuad;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.5),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: screenWidth * 0.045,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
