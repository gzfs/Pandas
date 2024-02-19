import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  Function(String)? setValueFunction;
  final String placeholderValue;
  bool? readOnly;
  bool? isPhone;
  bool? isPassword;
  final TextInputType inputType;
  VoidCallback? onTapping;
  TextEditingController? textEditingController;
  VoidCallback? onPressed;
  Widget? suffixIcon;

  CustomTextField(
      {super.key,
      this.suffixIcon,
      this.isPhone,
      this.onPressed,
      this.textEditingController,
      this.onTapping,
      this.setValueFunction,
      required this.placeholderValue,
      this.readOnly,
      this.isPassword,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onTap: (onTapping == null) ? () {} : onTapping,
      style: const TextStyle(fontFamily: "Urbanist"),
      keyboardType: inputType,
      obscureText: (isPassword != null) ? isPassword! : false,
      onChanged: setValueFunction,
      readOnly: (readOnly != null) ? readOnly! : false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
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

// +1-555-521-5554