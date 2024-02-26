import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandas/features/authentication/screens/image_upload.dart';
import 'package:pandas/features/authentication/screens/login.dart';
import 'package:pandas/features/authentication/screens/signup.dart';
import 'package:pandas/features/core/screens/discover.dart';
import 'package:pandas/features/core/screens/home.dart';
import 'package:pandas/features/messaging/screens/message.dart';
import 'package:pandas/features/messaging/screens/message_screen.dart';
import 'package:pandas/features/profile/screens/profile.dart';
import 'package:pandas/firebase_options.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      getPages: [
        GetPage(name: "/login", page: () => const Login()),
        GetPage(name: "/register", page: () => const Register()),
        GetPage(name: "/discover", page: () => const Discover()),
        GetPage(name: "/profile", page: () => const Profile()),
        GetPage(name: "/message", page: () => const Message()),
        GetPage(name: "/image_upload", page: () => const ImageUpload()),
        GetPage(name: "/message_screen", page: () => const MessageScreen()),
      ],
    );
  }
}
