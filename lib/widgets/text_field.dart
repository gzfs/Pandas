import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) setValueFunction;
  final String placeholderValue;

  const CustomTextField({super.key, required this.setValueFunction, required this.placeholderValue});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontFamily: "Urbanist"),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onChanged: setValueFunction,
      decoration: InputDecoration(
        hintText: placeholderValue,
        contentPadding:
        const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        filled: true,
        fillColor: Colors.amber,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }
}