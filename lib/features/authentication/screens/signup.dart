import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/common_widgets/text_field.dart';
import 'package:pandas/features/authentication/controllers/signup_controller.dart';
import 'package:pandas/repository/user_repository/user_repository.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? initialGenderValue = "Male";

  final textController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  final genderDropdown = ["Male", "Female", "Others"];

  var requestOTP = false;
  var isVerified = false;

  DateTime? userAge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(30, 115, 237, 1),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Name cannot be empty";
                          } else if (p0.length < 5) {
                            return "Name too short";
                          }
                          return null;
                        },
                        textEditingController: textController.fullName,
                        placeholderValue: "Name",
                        inputType: TextInputType.name),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!p0.contains("@")) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                        textEditingController: textController.userEmail,
                        placeholderValue: "Email",
                        inputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Phone cannot be empty";
                          } else if (p0.length < 13 || p0.length > 13) {
                            return "Invalid Phone Number";
                          } else if (!p0.contains("+")) {
                            return "Invalid Phone Number";
                          }
                          return null;
                        },
                        isPhone: true,
                        textEditingController: textController.phoneNumber,
                        placeholderValue: "Phone",
                        inputType: TextInputType.phone),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (p0.length < 6) {
                            return "Password too short";
                          }
                          return null;
                        },
                        textEditingController: textController.userPassword,
                        isPassword: true,
                        placeholderValue: "Password",
                        inputType: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Age cannot be empty";
                          }
                          return null;
                        },
                        textEditingController: textController.userDOB,
                        onTapping: () async {
                          var selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(DateTime.now().year - 17));

                          setState(() {
                            textController.userDOB.text =
                                selectedDate.toString().split(" ")[0];
                          });
                        },
                        placeholderValue: "Age",
                        readOnly: true,
                        inputType: TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(25)),
                      child: DropdownButton(
                        style: const TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.black,
                            fontSize: 16),
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
                          textController.initialGenderValue.value = newValue!;
                          setState(() {
                            initialGenderValue = newValue;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DiamondButton(
                buttonInversion: false,
                goRoute: "/image_upload",
                validateFunc: () async {
                  if (_formKey.currentState!.validate()) {
                    var recvdUser = await UserRepository.instance
                        .getUserByEmail(textController.userEmail.text);

                    if (recvdUser["Message"] == null) {
                      Get.snackbar(
                          "Error", "User already exists with the Given Email",
                          backgroundColor: Colors.amber);

                      return false;
                    }
                    return true;
                  }
                  return false;
                },
              )
            ],
          ),
        ));
  }
}
