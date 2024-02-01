import 'package:flutter_svg/svg.dart';
import 'package:pandas/widgets/button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SvgPicture.asset("assets/Logos.svg"),
                const Image(
                  image: AssetImage("assets/Panda.png"),
                  width: 250.0,
                ),
              ],
            ),
            const DiamondButton(
              buttonInversion: false,
              goRoute: "/login",
            )
          ],
        ),
      ),
    );
  }
}
