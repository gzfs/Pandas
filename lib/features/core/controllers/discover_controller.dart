import 'package:get/get.dart';
import 'package:pandas/repository/user_repository/user_repository.dart';

class DiscoverController extends GetxController {
  static DiscoverController get instance => Get.find();
  final userRepo = Get.put(UserRepository());

  Future<Map<String, dynamic>> getUserByEmail(String? userEmail) async {
    return await userRepo.getUserByEmail(userEmail);
  }

  Future<Map<String, dynamic>> getUserByID(String? userID) async {
    return await userRepo.getUserById(userID);
  }

  Future<void> createMessageRequest(String? senderId, String? receiverId,
      String? senderName, String? senderImage) async {
    await userRepo.createMessageRequest(
        senderId, receiverId, senderName, senderImage);
  }

  Future<bool> isRequested(String? senderId, String? receiverId) {
    return userRepo.isRequested(senderId, receiverId);
  }

  Stream getMessages(String? userId) {
    return userRepo.getMessages(userId);
  }

  Future<void> acceptRequest(String? senderId, String? receiverId) async {
    await userRepo.acceptMessageRequest(senderId, receiverId);
  }
}
