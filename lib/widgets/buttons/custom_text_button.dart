import 'package:flutter/material.dart';
import '../../constants/theme/theme_app.dart';
import '../texts/custom_text.dart';


class CustomTextButton extends StatefulWidget {

  final void Function()? onTap;
  final String text;

  CustomTextButton({
    required this.onTap, required this.text
  });

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState(onTap, text);
}

class _CustomTextButtonState extends State<CustomTextButton> {

  final CustomTextButton _button;

  _CustomTextButtonState(void Function()? onTap, String text) : _button = CustomTextButton(
      onTap: onTap, text: text
  );

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: _button.onTap,
      child: Align(
        alignment: Alignment.center,
        child: CustomText(
          text: _button.text,
          fontColor: ThemeApp.themeMainColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}