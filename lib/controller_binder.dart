import 'package:get/get.dart';
import 'package:rmbetting/presentation/state_holders/auth/login_controller.dart';
import 'package:rmbetting/presentation/state_holders/category_screen_controller.dart';
import 'package:rmbetting/presentation/state_holders/profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(ProfileScreenController());
    Get.put(CategoryScreenController());
  }
}