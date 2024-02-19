import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pandas/features/authentication/models/user_model.dart';

class UserRepository {
  static UserRepository get instance => Get.find();

  final _fireDB = FirebaseFirestore.instance;

  createUser(UserModel userData) async {
    await _fireDB.collection("Users").add(userData.toJson()).whenComplete(
        () => Get.snackbar("Success", "User Created Successfully"));
  }

  getUserByEmail(String? userEmail) {
    return _fireDB
        .collection("Users")
        .where("email", isEqualTo: userEmail)
        .get()
        .then((value) => value.docs.first.data());
  }

  getUserById(String? userId) {
    return _fireDB
        .collection("Users")
        .where("id", isEqualTo: userId)
        .get()
        .then((value) => value.docs.first.data());
  }
}
