import 'package:easyplay_app/constants/theme/theme_app.dart';
import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final Color? fontColor;

  const CustomText({Key? key, required this.text, this.fontSize, this.textStyle, this.fontWeight, this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: textStyle ?? TextStyle(
          fontSize: fontSize ?? 13,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: fontColor ?? ThemeApp.themeTextColor,
        )
    );
  }
}