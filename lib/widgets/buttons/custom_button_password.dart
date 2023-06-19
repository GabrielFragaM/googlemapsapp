import 'package:flutter/material.dart';

class CustomButtonPassword extends StatelessWidget {
  final void Function()? onPressed;
  final bool showPassword;

  const CustomButtonPassword(
      {Key? key, required this.showPassword, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return IconButton(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(showPassword == true ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined, size: 17),
      onPressed: onPressed,
    );
  }
}