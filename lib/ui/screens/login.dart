import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_wall/controllers/gallary_controller.dart';
import 'package:poster_wall/controllers/login_controller.dart';
import 'package:poster_wall/ui/shared/animated_gallary_background.dart';
import 'package:poster_wall/ui/shared/custom_textfield.dart';
import 'package:poster_wall/ui/shared/glass_container.dart';
import 'package:poster_wall/ui/shared/wrapper_container.dart';
import 'package:poster_wall/utilities/style/app_colors.dart';

class Login extends GetView<LoginController> {
  Login({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(color: AppColors.primaryColor),
          ),
          Obx(
            () => Positioned(
              top: -70,
              right: -70,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: !controller.splash.value ? 0 : 1,
                child: CircleAvatar(
                  radius: 140,
                  backgroundColor: AppColors.primaryLight,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 1000),
                    opacity: !controller.splash.value ? 0 : 1,
                    child: Container(
                      margin: EdgeInsets.all(25),
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryUltraLight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              top: 80,
              left: 30,
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: !controller.showSignIn.value ? 0 : 1,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: !controller.splash.value ? 0 : 1,
                child: Text(
                  "Poster Wall",
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBackColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future bottomSheet() async {
  return showGeneralDialog(
    context: Get.context!,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (_, __, ___) {
      return MediaQuery.removePadding(
        context: Get.context!,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            final currentFocus = FocusScope.of(Get.context!);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.unfocus();
            }
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: SizedBox(
                  height: Get.height * 0.8,
                  width: Get.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedGalleryBackground(
                        imageUrls:
                            Get.find<GalleryController>().backgroundImages,
                      ),
                      Container(color: Colors.black.withValues(alpha: 0.35)),
                      Material(color: Colors.transparent, child: loginForm()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
        child: child,
      );
    },
  );
}

Widget loginForm() {
  final controller = Get.put(LoginController());

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              // color: AppColors.textColor,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 16),

          Text(
            "To keep connected with us please login with your personal details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              // color: AppColors.textSecondaryColor,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 40),
          GlassContainer(
            child: CustomTextfield(
              controller: controller.emailController,
              hintText: "Email",
              borderColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 20),
          GlassContainer(
            child: CustomTextfield(
              controller: controller.passwordController,
              hintText: "Password",
              borderColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 16),

          rememberMe(controller),
          SizedBox(height: 20),
          loginButton(controller),
        ],
      ),
    ),
  );
}

Widget rememberMe(LoginController controller) {
  return GlassContainer(
    padding: EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        wrapperContainer(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          child: GestureDetector(
            onTap: () {
              controller.remeberSignIn.value = !controller.remeberSignIn.value;
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Obx(
                  () => SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      value: controller.remeberSignIn.value,
                      activeColor: Colors.transparent,
                      fillColor: WidgetStatePropertyAll(Colors.transparent),

                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      side: BorderSide(width: 0.5, color: AppColors.white),
                      checkColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(28),
                      ),
                      onChanged: (_) {
                        controller.remeberSignIn.value =
                            !controller.remeberSignIn.value;
                      },
                    ),
                  ),
                ),

                Text(
                  "Remember me?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.emailController.clear();
            controller.passwordController.clear();
            Get.snackbar("New Login Ready", "login With New Credentials");
          },
          child: wrapperContainer(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Row(
              children: [
                Text(
                  "    Forgott!    ",
                  style: TextStyle(color: AppColors.redColor),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget loginButton(LoginController controller) {
  return GlassContainer(
    padding: EdgeInsets.all(8),
    child: SizedBox(
      width: Get.width,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: () {
          controller.logIn();
        },
        child: Text(
          "Log in",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
    ),
  );
}
