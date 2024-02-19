import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandas/features/authentication/models/user_model.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';
import 'package:pandas/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final fullName = TextEditingController();
  final userDOB = TextEditingController();
  final phoneNumber = TextEditingController();
  final oneTimePassword = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String userEmail, String userPass) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(userEmail, userPass);
  }

  void createUser(UserModel userData) async {
    await userRepo.createUser(userData);
  }

  void verifyPhoneNumber(String phoneNumber) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNumber);
  }

  Rx<bool> getVerificationStatus() {
    return AuthenticationRepository.instance.isVerified;
  }
}
