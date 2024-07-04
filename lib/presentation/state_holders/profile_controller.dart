import 'package:get/get.dart';
import 'package:rmbetting/data/api_urls.dart';
import 'package:rmbetting/data/model/response_object.dart';
import 'package:rmbetting/data/network_services/network_service.dart';
import 'package:rmbetting/data/model/user_model.dart';

class ProfileScreenController extends GetxController {
  RxBool isProgress = false.obs;
  Rx<UserData?> userData = Rx<UserData?>(null);

  @override
  void onInit() {
    super.onInit();
    getProfileInfo();
  }

  Future<void> getProfileInfo() async {
    isProgress.value = true;
    try {
      ResponseObject response = await NetworkCaller.getRequest(ApiUrls.profileUrl);
      if (response.isSuccess) {
        userData.value = UserData.fromJson(response.responseBody);
      } else {
        // Handle error, maybe show a message to the user
        Get.snackbar('Error', 'Failed to load profile information');
      }
    } catch (e) {
      // Handle exception
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isProgress.value = false;
    }
  }
}
