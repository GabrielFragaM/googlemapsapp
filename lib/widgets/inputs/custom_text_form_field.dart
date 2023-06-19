import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool? obscureText;
  final int? maxLines;
  final int? maxLength;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const CustomTextFormField(
      {Key? key,  this.hintText,
        this.obscureText, this.maxLines, this.maxLength, this.onPressed, this.onChanged, this.validator, this.controller, this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = suffixIcon != null ?
    InputDecoration(
      filled: true,
      fillColor: const Color(0xF5F1F1F1),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xDFEEEEEE)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xDFEEEEEE)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xDFEEEEEE)),
      ),
      hintText: hintText ?? '',
      semanticCounterText: '',
      hintStyle: const TextStyle(color: Color(0xFF858585), fontSize: 13),
      suffixIcon: suffixIcon ?? Container(width: 0.1),
    ):
    InputDecoration(
      filled: true,
      fillColor: const Color(0xF5F1F1F1),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xDFEEEEEE)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xDFEEEEEE)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Color(0xDFEEEEEE)),
      ),
      hintText: hintText ?? '',
      semanticCounterText: '',
      hintStyle: const TextStyle(color: Color(0xFF858585), fontSize: 13),
    );
    return SizedBox(
      height: (maxLines != null ? 31 : 65) * double.parse(maxLines != null ? maxLines.toString() :  '1'),
      child: maxLength != null ?
      TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 35,
        validator: validator,
        decoration: inputDecoration,
      ):
      TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        maxLines: maxLines ?? 1,
        validator: validator,
        decoration: inputDecoration,
      ),
    );
  }
}