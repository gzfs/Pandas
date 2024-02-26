import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pandas/features/core/screens/discover.dart';
import 'package:pandas/features/core/screens/home.dart';
import 'package:pandas/repository/authentication_repository/exceptions/signup_with_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _firebaseAuth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationID = "".obs;
  var isVerified = false.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
    firebaseUser.bindStream(_firebaseAuth.userChanges());

    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  dynamic _setInitialScreen(User? fireUser) {
    fireUser == null
        ? Get.offAll(() => const Home())
        : Get.offAll(() => const Discover());
  }

  Future<void> phoneAuthentication(String phoneNumber) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (recvCreds) async {
          Get.snackbar("Verified", "Phone Number is successfully Verified");
          isVerified.value = true;
        },
        verificationFailed: (err) {
          if (err.code == "invalid-phone-number") {
            Get.snackbar("Error", "Invalid Phone Number");
          } else {
            Get.snackbar("Error", "Something went wrong !!");
          }
        },
        codeSent: (verificationID, resendToken) {
          this.verificationID.value = verificationID;
        },
        codeAutoRetrievalTimeout: (verificationID) {
          this.verificationID.value = verificationID;
        });
  }

  Future<void> createUserWithEmailAndPassword(
      String userEmail, String userPassword) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      firebaseUser.value == null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => const Discover());
    } on FirebaseAuthException catch (err) {
      final gotEx = SignUpWithEmailPasswordFailure.code(err.code);
      if (kDebugMode) {
        print("[ERROR] Firebase Auth - ${gotEx.message}");
      }
    } catch (_) {}
  }

  Future<void> loginWithEmailAndPassword(
      String userEmail, String userPassword) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      firebaseUser.value == null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => const Discover());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        Get.snackbar("Error", "Invalid Credentials",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == "invalid-email") {
        Get.snackbar("Error", "Invalid Email",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        if (kDebugMode) {
          print(e);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> userLogout() async => await _firebaseAuth.signOut();
}
