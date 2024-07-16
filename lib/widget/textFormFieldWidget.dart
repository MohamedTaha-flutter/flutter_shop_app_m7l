import 'package:flutter/material.dart';

import '../styles/color.dart';

class TextFormFieldWidget extends StatelessWidget {
   TextFormFieldWidget({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    required this.label,
    this.validator,
    required this.prefixIcon,
    this.suffixIcon,
     this.onSubmitted,
     this.isPassword = false,
  });
   final bool isPassword ;
  final Widget label;
  final Widget prefixIcon;
   Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      onFieldSubmitted:  onSubmitted,
      validator: validator ,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: label ,
        prefixIcon: prefixIcon ,
        suffixIcon: suffixIcon ,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor), // Set border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor), // Set enabled border color
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 2.0), // Set focused border color and width
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Set error border color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 2.0), // Set focused error border color and width
        ),      ),
    );
  }
}
