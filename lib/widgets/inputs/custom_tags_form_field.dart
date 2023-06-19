import 'package:flutter/material.dart';


class CustomTagsFormField extends StatelessWidget {
  final String? hintText;
  final int? maxLength;
  final void Function()? onPressed;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTagsFormField(
      {Key? key,  this.hintText, this.maxLength, required this.onPressed, required this.controller,
        this.validator
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: TextFormField(
        maxLength: maxLength ?? 35,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
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
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.add_circle_outlined),
            onPressed: onPressed,
          ),
          hintText: hintText ?? '',
          hintStyle: const TextStyle(color: Color(0xFF858585), fontSize: 13),
        ),
      ),
    );
  }
}