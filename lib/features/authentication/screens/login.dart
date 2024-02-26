import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/common_widgets/text_field.dart';
import 'package:pandas/features/authentication/controllers/login_controller.dart';

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
  final textController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  textEditingController: textController.userEmail,
                  placeholderValue: "Email",
                  inputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: textController.userPassword,
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
              if (textController.userEmail.text.isEmpty ||
                  textController.userPassword.text.isEmpty) {
                var errorSnackBar = const SnackBar(
                  content: Text("Error! Fill all the Fields"),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                textController.loginUser();
                return false;
              }
              textController.loginUser();
              return true;
            },
          )
        ],
      ),
    );
  }
}
