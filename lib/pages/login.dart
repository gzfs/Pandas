import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {

    String? userEmail;
    String? userPassword;

    return Container(
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                DiamondButton(
                  buttonInversion: true,
                  goRoute: "/",
                  validateFunc: () {},
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
              TextField(
                style: const TextStyle(fontFamily: "Urbanist"),
                onChanged: (String? newInput) {
                  userEmail = newInput;
                },
                decoration: const InputDecoration(
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
              TextField(
                style: const TextStyle(fontFamily: "Urbanist"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (String? newInput) {
                  userPassword = newInput;
                },
                decoration: const InputDecoration(
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
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Registered?", style: TextStyle(
                          color: Colors.white
                      ),),
                      TextButton(child: const Text("Sign in", style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          color: Colors.white
                      )), onPressed: () => context.go("/signup"),),
                    ],
                  )),
            ],
          ),
          DiamondButton(buttonInversion: false, goRoute: "/", validateFunc: (){
            if(userEmail == null || userPassword == null){
              return false;
            }
            return true;
          },)
        ],
      ),
    );
  }
}
