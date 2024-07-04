import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rmbetting/presentation/screens/login_screen.dart';
import '../../presentation/state_holders/auth/user_auth_controller.dart';
import '../model/response_object.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      log(url);
      log(AuthController.accessToken.toString());
      String token = await AuthController.getUserToken() ?? '';
      final http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 500) {
        moveToSignIn();
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body,
      {bool fromSignIn = false}) async {
    try {
      log(url);
      log(body.toString());
      String token = await AuthController.getUserToken() ?? '';
      print(token);
      final http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        if (fromSignIn) {
          moveToSignIn();
          return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '',
            errorMessage: 'Email/password is incorrect. Try again',
          );
        } else {
          moveToSignIn();
          return ResponseObject(
              isSuccess: false,
              statusCode: response.statusCode,
              responseBody: '');
        }
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<void> moveToSignIn() async {
    await AuthController.clearUserData();
    Get.offAll(() => const LoginScreen());
  }
}
