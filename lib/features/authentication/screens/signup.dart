import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pandas/common_widgets/button.dart';
import 'package:pandas/common_widgets/text_field.dart';
import 'package:pandas/features/authentication/controllers/signup_controller.dart';
import 'package:pandas/features/authentication/models/user_model.dart';
import 'package:uuid/uuid.dart';

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 60, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                textEditingController: textController.fullName,
                                placeholderValue: "Name",
                                inputType: TextInputType.name),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                                textEditingController: textController.userEmail,
                                placeholderValue: "Email",
                                inputType: TextInputType.emailAddress),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                                isPhone: true,
                                textEditingController:
                                    textController.phoneNumber,
                                placeholderValue: "Phone",
                                inputType: TextInputType.phone),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                                textEditingController:
                                    textController.userPassword,
                                isPassword: true,
                                placeholderValue: "Password",
                                inputType: TextInputType.visiblePassword),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                                textEditingController: textController.userDOB,
                                onTapping: () async {
                                  var selectedDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate:
                                          DateTime(DateTime.now().year - 17));

                                  setState(() {
                                    textController.userDOB.text =
                                        selectedDate.toString().split(" ")[0];
                                  });
                                },
                                placeholderValue: "Age",
                                readOnly: true,
                                inputType: TextInputType.text),
                          ],
                        ),
                      ),
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
                  goRoute: "/discover",
                  validateFunc: () async {
                    if (_formKey.currentState!.validate() &&
                        initialGenderValue != null &&
                        initialGenderValue!.isNotEmpty &&
                        textController.phoneNumber.text.isNotEmpty &&
                        textController.userEmail.text.isNotEmpty &&
                        textController.userPassword.text.isNotEmpty &&
                        textController.fullName.text.isNotEmpty &&
                        textController.userDOB.text.isNotEmpty) {
                      var userModel = UserModel(
                        id: const Uuid().v4(),
                        name: textController.fullName.text,
                        email: textController.userEmail.text,
                        phone: textController.phoneNumber.text,
                        age: textController.userDOB.text,
                        gender: initialGenderValue!,
                      );

                      textController.createUser(userModel);
                      textController.registerUser(textController.userEmail.text,
                          textController.userPassword.text);

                      return true;
                    }
                    Get.snackbar(
                        "Error", "Fill all the Fields and Verify your Number",
                        backgroundColor: Colors.amber);
                    return false;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
