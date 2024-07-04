import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rmbetting/controller_binder.dart';
import 'package:rmbetting/presentation/screens/login_screen.dart';
import 'package:rmbetting/presentation/screens/splash_screen.dart';
import 'package:rmbetting/presentation/utility/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: EdgeInsets.all(13),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 19),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            backgroundColor: const Color(0xff00AB55),
          ),
        ),
        colorSchemeSeed: const Color(0xff00AB55),
      ),
      home: const SplashScreen(),
    );
  }
}
