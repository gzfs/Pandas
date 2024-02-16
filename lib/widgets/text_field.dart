import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) setValueFunction;
  final String placeholderValue;
  bool? readOnly;
  bool? isPassword;
  final TextInputType inputType;

  CustomTextField({super.key, required this.setValueFunction, required this.placeholderValue, this.readOnly, this.isPassword, required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontFamily: "Urbanist"),
      keyboardType: inputType,
      obscureText: (isPassword != null) ? isPassword! : false,
      onChanged: setValueFunction,
      readOnly: (readOnly != null) ? readOnly! : false,
      decoration: InputDecoration(
        hintText: placeholderValue,
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        filled: true,
        fillColor: Colors.amber,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }
}