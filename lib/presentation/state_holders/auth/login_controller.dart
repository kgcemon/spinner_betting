import 'package:get/get.dart';
import 'package:rmbetting/data/api_urls.dart';
import 'package:rmbetting/data/model/response_object.dart';
import 'package:rmbetting/data/network_services/network_service.dart';
import 'package:rmbetting/presentation/state_holders/auth/user_auth_controller.dart';

class LoginController extends GetxController {
  RxBool inProgress = false.obs;

  Future<bool> login({required String email, required String password}) async {
    try {
      inProgress.value = true;
      ResponseObject response = await NetworkCaller.postRequest(
        ApiUrls.loginUrl,
        {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
       await AuthController.saveUserToken(response.responseBody["token"]);
       print(await AuthController.getUserToken());
        update();
        return true;
      } else {
        Get.snackbar("Error", response.responseBody['error']);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred");
      return false;
    } finally {
      inProgress.value = false;
    }
  }
}
