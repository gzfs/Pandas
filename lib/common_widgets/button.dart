// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class DiamondButton extends StatelessWidget {
  DiamondButton(
      {super.key,
      required this.buttonInversion,
      this.goRoute,
      required this.validateFunc,
      this.getPerms});
  DiamondButton(
      {super.key,
      required this.buttonInversion,
      this.goRoute,
      required this.validateFunc,
      this.getPerms});

  final bool buttonInversion;
  String? goRoute;
  final Function validateFunc;
  Function? getPerms;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45.0 * pi / 180,
      child: OutlinedButton(
          onPressed: () async {
            if (await validateFunc() && goRoute != null) Get.toNamed(goRoute!);
            if (getPerms != null) await getPerms!();
          },
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.only(right: 2.0),
              fixedSize: const Size(70, 70),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              backgroundColor: Colors.amber,
              side: const BorderSide(color: Colors.black)),
          child: Transform.rotate(
              angle: ((!buttonInversion) ? -45.0 : 135.0) * pi / 180,
              child: const Center(
                  child: Icon(
                Iconsax.arrow_right_1,
                size: 30.0,
                color: Colors.black,
              )))),
    );
  }
}
