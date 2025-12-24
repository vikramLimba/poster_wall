import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_wall/controllers/dashboard_controller.dart';
import 'package:poster_wall/ui/shared/glass_container.dart';
import 'package:poster_wall/utilities/style/app_colors.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return PopScope(
      canPop: false,
      child: Obx(
        () => Scaffold(
          body: controller.pages[controller.selectedIndex.value],
          floatingActionButtonAnimator:
              FloatingActionButtonAnimator.noAnimation,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: isKeyboardOpen
              ? null
              : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 65,
                  child: GlassContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: controller.selectedIndex.value == 0
                                ? AppColors.primaryColor
                                : AppColors.black,
                          ),
                          onPressed: () => controller.onTabSelected(0),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: controller.selectedIndex.value == 1
                                ? AppColors.primaryColor
                                : AppColors.black,
                          ),
                          onPressed: () => controller.onTabSelected(1),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
