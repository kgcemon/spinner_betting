import 'package:get/get.dart';
import 'package:rmbetting/data/api_urls.dart';
import 'package:rmbetting/data/model/response_object.dart';
import 'package:rmbetting/data/network_services/network_service.dart';
import '../../data/model/category_model.dart';
import '../../data/model/purchase_spinner_model.dart';

class CategoryScreenController extends GetxController {
  var categoryModel = CategoryModel().obs;
  var purchaseSpinnerModel = PurchaseSpinnerModel().obs;

  getCategory() async {
    ResponseObject networkCaller =
        await NetworkCaller.getRequest(ApiUrls.spinnerList);
    categoryModel.value = CategoryModel.fromJson(networkCaller.responseBody);
  }

  Future<bool> purchaseSpinner(String spinnerId) async {
    ResponseObject response = await NetworkCaller.postRequest(
        ApiUrls.purchaseSpinner, {"spinner_id": spinnerId});
    if (response.responseBody['success'] == 200) {
      purchaseSpinnerModel.value =
          PurchaseSpinnerModel.fromJson(response.responseBody);
      return true;
    } else {
      return false;
    }
  }
}
