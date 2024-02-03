import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pandas/widgets/button.dart';
import 'package:pandas/widgets/date_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DiamondButton(
                            buttonInversion: true,
                            goRoute: "/",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SvgPicture.asset("assets/Signup.svg"),
                          ),
                          const SizedBox(
                            width: 35,
                          )
                        ]),
                    const SizedBox(
                      height: 40,
                    ),
                    const TextField(
                      style: TextStyle(fontFamily: "Urbanist"),
                      decoration: InputDecoration(
                        hintText: "Name",
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
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
                      decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
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
                      decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
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
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Age",
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        fillColor: Colors.amber,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DatePicker(
                dateChangedCallback: () {},
                upperLimit: DateTime.now(),
              )
            ],
          )),
        ));
  }
}
