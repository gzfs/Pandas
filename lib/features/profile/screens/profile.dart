import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pandas/common_widgets/button.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 30.0, bottom: 25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DiamondButton(
                      buttonInversion: true,
                      goRoute: "/discover",
                      validateFunc: () {
                        return true;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset("assets/Profile.svg"),
                    ),
                    const SizedBox(
                      width: 35,
                    )
                  ]),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(70, 70),
                  padding: const EdgeInsets.only(right: 2),
                  backgroundColor: Colors.amber,
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: () {
                  AuthenticationRepository.instance.userLogout();
                },
                child: const Icon(Iconsax.logout, color: Colors.black),
              )
            ]),
      ),
    );
  }
}
