import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:poster_wall/controllers/gallary_controller.dart';
import 'package:poster_wall/ui/screens/dashboard.dart';
import 'package:poster_wall/ui/screens/login.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool splash = false.obs;

  RxBool showSignIn = false.obs;
  RxBool remeberSignIn = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Get.put(GalleryController()).loadCuratedBackground();

    Future.delayed(const Duration(milliseconds: 500), () {
      splash.value = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      splash.value = true;

      bottomSheet();
      showSignIn.value = true;
    });
  }

  logIn() {
    if (emailController.text.isEmpty ||
        !RegExp(
          r"^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
        ).hasMatch(emailController.text) ||
        passwordController.text.isEmpty ||
        passwordController.text.length < 8) {
      return Get.snackbar("Error:", "Please enter valid credentials");
    } else {
      Get.to(() => Dashboard());
    }
  }
}
