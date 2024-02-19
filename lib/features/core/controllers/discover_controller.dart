import 'package:get/get.dart';
import 'package:pandas/repository/user_repository/user_repository.dart';

class DiscoverController extends GetxController {
  static DiscoverController get instance => Get.find();
  final userRepo = Get.put(UserRepository());

  Future<Map<String, dynamic>> getUserByEmail(String? userEmail) async {
    return await userRepo.getUserByEmail(userEmail);
  }
}
