import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  void loginUser() {
    AuthenticationRepository.instance
        .loginWithEmailAndPassword(userEmail.text, userPassword.text);
  }
}
