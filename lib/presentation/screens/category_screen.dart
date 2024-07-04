import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rmbetting/presentation/screens/spinner_screen.dart';
import 'package:rmbetting/presentation/screens/waiting_screen.dart';
import 'package:rmbetting/presentation/state_holders/profile_controller.dart';
import 'package:rmbetting/presentation/widgets/appbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  void initState() {
    Get.find<ProfileScreenController>().getProfileInfo();
    super.initState();
  }

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
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 180,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Get.to(()=>const SpinnerScreen()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/spin.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "১০৳",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              backgroundColor: const Color(0xFF3B0972),
                              minimumSize: const Size(double.infinity, 40)),
                          onPressed: () {},
                          child: const Text(
                            "Buy Now ১০৳",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
