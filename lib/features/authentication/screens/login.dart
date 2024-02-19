import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/common_widgets/text_field.dart';
import 'package:pandas/repository/authentication_repository/authentication_repository.dart';

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
  // void _getSharedPreferences() async {

  // }

  @override
  void initState() {
    super.initState();
  }

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
                  validateFunc: () {
                    return true;
                  },
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
              CustomTextField(
                  setValueFunction: (String? newValue) {
                    userEmail = newValue;
                  },
                  placeholderValue: "Email",
                  inputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                setValueFunction: (String? newValue) {
                  userPassword = newValue;
                },
                placeholderValue: "Password",
                inputType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Registered?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        child: const Text("Sign in",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                color: Colors.white)),
                        onPressed: () => Get.toNamed("/register"),
                      ),
                    ],
                  )),
            ],
          ),
          DiamondButton(
            buttonInversion: false,
            validateFunc: () {
              if (userEmail == null || userPassword == null) {
                var errorSnackBar = const SnackBar(
                  content: Text("Error! Fill all the Fields"),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                return false;
              }
              AuthenticationRepository.instance
                  .loginWithEmailAndPassword(userEmail!, userPassword!);
              return true;
            },
          )
        ],
      ),
    );
  }
}
