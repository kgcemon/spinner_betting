import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rmbetting/presentation/state_holders/auth/login_controller.dart';
import 'category_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = Get.find<LoginController>();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25,),
                  Text(
                    "Sign in to RM20",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Enter your details below.",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Image.asset("assets/woman.png"),
                  accountNoticeBoardCard(screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Obx(
                        () => loginController.inProgress == false
                        ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          loginController
                              .login(
                              email: emailController.text,
                              password: passwordController.text)
                              .then(
                                (value) {
                              if (value == true) {
                                Get.offAll(() => const CategoryScreen());
                              }
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                        : const Center(child: CircularProgressIndicator()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget accountNoticeBoardCard(double screenHeight) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: screenHeight * 0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffD0F2FF),
            boxShadow: [
              BoxShadow(
                color: Colors.
              red.withOpacity(0.5 + 0.5 * _animationController.value),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info,
                color: Color(0xff2A9AFF),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Don't have an account? \nPlease contact the admin of \nRM20",
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
