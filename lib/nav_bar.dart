import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/utils/constants/colors.dart';
import 'package:to_do_app/views/home.dart';
import 'package:to_do_app/views/profile.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.secondary,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Obx(
            () => Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // ➜ Space Between
              children: [
                IconButton(
                  iconSize: 40, // ➜ Icon lebih besar
                  color: controller.selectedIndex.value == 0
                      ? AppColors.primary
                      : Colors.grey,
                  icon: const Icon(Icons.home),
                  onPressed: () => controller.selectedIndex.value = 0,
                ),
                IconButton(
                  iconSize: 40,
                  color: controller.selectedIndex.value == 1
                      ? AppColors.primary
                      : Colors.grey,
                  icon: const Icon(Icons.person),
                  onPressed: () => controller.selectedIndex.value = 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    Home(),
    UserProfilePage(),
  ];
}
