import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rmbetting/presentation/screens/category_screen.dart';
import 'package:rmbetting/presentation/screens/login_screen.dart';
import 'package:rmbetting/presentation/state_holders/auth/user_auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  routScreen() async {
    await AuthController.getUserToken().then(
      (value) async {
        String? token = await AuthController.getUserToken() ?? '';
        if (token.isEmpty) {
          Get.offAll(() => const LoginScreen());
        } else {
          Get.offAll(() => const CategoryScreen());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    routScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "RM20",
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
