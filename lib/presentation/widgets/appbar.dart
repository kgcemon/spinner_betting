import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rmbetting/presentation/state_holders/profile_controller.dart';

myAppBar() {
  ProfileScreenController controller = Get.find<ProfileScreenController>();
  return AppBar(
    backgroundColor: const Color(0xFF3B0972),
    iconTheme: const IconThemeData(color: Colors.white),
    title: Obx(
      () => Text(
        "${controller.userData.value?.name}",
        style: const TextStyle(color: Colors.white),
      ),
    ),
    actions: [
      Obx(() => TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {},
            child: Text(
              "৳${controller.userData.value?.balance}",
              style: const TextStyle(color: Colors.white),
            ),
          )),
      const SizedBox(
        width: 15,
      )
    ],
  );
}
