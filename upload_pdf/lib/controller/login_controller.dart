import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upload_pdf/model/login_mode.dart';
import 'package:upload_pdf/view/upload_assignment_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  /// Login button click
  void login() {
    final model = LoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!isValid(model)) return;

    isLoading.value = true;

    // 🔴 Dummy login (NO Firebase)
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar("Success", "Login Successful");
      Get.offAll(() => const AssignmentUploadView()); // Navigate to home screen
    });
  }

  bool isValid(LoginModel model) {
    if (model.email.isEmpty) {
      Get.snackbar("Error", "Email is required");
      return false;
    }

    if (!GetUtils.isEmail(model.email)) {
      Get.snackbar("Error", "Enter valid email");
      return false;
    }

    if (model.password.isEmpty) {
      Get.snackbar("Error", "Password is required");
      return false;
    }

    if (model.password.length < 6) {
      Get.snackbar("Error", "Password must be 6 characters");
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
