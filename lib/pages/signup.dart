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

  String? initialGenderValue = "Male";

  final genderDropdown = [
    "Male",
    "Female",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
        body: SingleChildScrollView(
          child: SafeArea(
              minimum: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DiamondButton(
                                buttonInversion: true,
                                goRoute: "/login",
                                validateFunc: () {
                                  return true;
                                },
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
                  const SizedBox(
                    height: 10,
                  ),
                  DatePicker(
                    dateChangedCallback: () {},
                    upperLimit: DateTime.now().toLocal().subtract(const Duration(seconds: 567648000)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color:  Colors.amber,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: DropdownButton(
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    color: Colors.black,
                    fontSize: 16
                  ),
                  isExpanded: true,
                  value: initialGenderValue,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: genderDropdown.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      initialGenderValue = newValue;
                    });
                },),
              ),
            ),
                  const SizedBox(
                    height: 40,
                  ),
                  DiamondButton(buttonInversion: false, goRoute: "/discover", validateFunc: () {},),
                  const SizedBox(
                    height: 40,
                  ),
              ],
              )),
        ));
  }
}
