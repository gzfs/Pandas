import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pandas/widgets/button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(30, 115, 237, 1),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 40, right: 40, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const DiamondButton(
                  buttonInversion: true,
                  goRoute: "/",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset("assets/Login.svg"),
                ),
                const SizedBox(
                  width: 35,
                )
              ]),
              const Image(
                image: AssetImage("assets/Login_Panda.png"),
                height: 200,
              ),
              const TextField(
                style: TextStyle(fontFamily: "Urbanist"),
                decoration: InputDecoration(
                  hintText: "Email",
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  fillColor: Colors.amber,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                style: TextStyle(fontFamily: "Urbanist"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  filled: true,
                  fillColor: Colors.amber,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "or",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: "Urbanist"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Image(
                  image: AssetImage("assets/Google.png"),
                  width: 60,
                ),
              )
            ],
          ),
          const DiamondButton(buttonInversion: false, goRoute: "/onboarding")
        ],
      ),
    );
  }
}
