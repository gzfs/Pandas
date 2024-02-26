import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pandas/features/authentication/models/user_model.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';
import 'package:pandas/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController with StateMixin {
  static SignUpController get instance => Get.find();

  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final fullName = TextEditingController();
  final userDOB = TextEditingController();
  final phoneNumber = TextEditingController();
  final oneTimePassword = TextEditingController();
  final initialGenderValue = "".obs;
  final List<dynamic> imageUrls = [].obs;

  final userRepo = Get.put(UserRepository());

  void registerUser(String userEmail, String userPass) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(userEmail, userPass);
  }

  @override
  void onInit() {
    super.onInit();
    change(imageUrls, status: RxStatus.empty());
  }

  Future<String?> imageUpload(String imagePath, XFile recImage) async {
    try {
      change(imageUrls, status: RxStatus.loading());
      final storageRef = FirebaseStorage.instance.ref().child(recImage.name);
      await storageRef.putFile(File(recImage.path));
      final downloadUrl = await storageRef.getDownloadURL();
      imageUrls.add(downloadUrl);
      change(imageUrls, status: RxStatus.success());
      return downloadUrl;
    } on FirebaseException catch (_) {
    } on PlatformException catch (_) {
    } catch (_) {}
    return null;
  }

  void createUser(UserModel userData) async {
    try {
      await userRepo.createUser(userData);
    } on Exception catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void verifyPhoneNumber(String phoneNumber) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNumber);
  }

  Rx<bool> getVerificationStatus() {
    return AuthenticationRepository.instance.isVerified;
  }
}
