import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class DiamondButton extends StatelessWidget {
  const DiamondButton(
      {super.key, required this.buttonInversion, required this.goRoute, required this.validateFunc});

  final bool buttonInversion;
  final String goRoute;
  final Function validateFunc;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45.0 * pi / 180,
      child: OutlinedButton(
          onPressed: () {
            if(validateFunc()) context.push(goRoute);
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
