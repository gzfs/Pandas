import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
      body: OutlinedButton(
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(70, 70),
          backgroundColor: Colors.amber,
          side: const BorderSide(color: Colors.black),
        ),
        onPressed: () {
          AuthenticationRepository.instance.userLogout();
        },
        child: const Icon(Iconsax.logout, color: Colors.black),
      ),
    );
  }
}
