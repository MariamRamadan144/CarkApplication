import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/routes/routes_manager.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/config/themes/light_theme.dart';

import 'features/auth/presentation/screens/login_screen.dart';

class Cark extends StatelessWidget {
  const Cark({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: "assets/translation", // json files
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(412, 917),
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: RoutesManager.onGenerateRoute,
            title: 'Cark',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.light,
            initialRoute: ScreensName.signup, // Initial screen
          );
        },
      ),
    );
  }
}
