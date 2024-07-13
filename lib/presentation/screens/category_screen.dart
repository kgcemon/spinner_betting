import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rmbetting/presentation/screens/spinner_screen.dart';
import 'package:rmbetting/presentation/screens/waiting_screen.dart';
import 'package:rmbetting/presentation/state_holders/profile_controller.dart';
import 'package:rmbetting/presentation/widgets/appbar.dart';
import '../state_holders/category_screen_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileScreenController>().getProfileInfo();
    Get.find<CategoryScreenController>().getCategory();
  }
  CategoryScreenController categoryScreenController =
      Get.find<CategoryScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Image.asset("assets/woman.png"),
            Expanded(
              child: Obx(() {
                final controller = Get.find<CategoryScreenController>();
                if (controller.categoryModel.value.spinners == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.categoryModel.value.spinners!.isEmpty) {
                  return const Center(
                      child: Text(
                    "No spinners available.",
                    style: TextStyle(color: Colors.white),
                  ));
                }

                return GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                      controller.categoryModel.value.spinners?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 180,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final spinner =
                        controller.categoryModel.value.spinners![index];
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                    child: loadingDialog()),
                              );
                            },
                          );

                          Get.find<CategoryScreenController>()
                              .purchaseSpinner(controller.categoryModel.value.spinners![index].id.toString())
                              .then((value) {
                            Navigator.of(context).pop();
                            Get.to(()=> const WaitingScreen());
                          });
                        },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage("assets/spin.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${spinner.duration}৳",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                backgroundColor: const Color(0xFF3B0972),
                                minimumSize: const Size(double.infinity, 40),
                              ),
                              onPressed: () {

                              },
                              child: Text(
                                "Buy Now ${spinner.duration}৳",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
  Widget loadingDialog() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

}
