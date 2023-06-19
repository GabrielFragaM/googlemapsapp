import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import '../../constants/theme/theme_app.dart';


class CustomButtonFacebook extends StatelessWidget {
  final void Function()? onTap;

  const CustomButtonFacebook(
      {Key? key,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CustomText(
            text: 'entrar com',
            fontColor: ThemeApp.themeTextDetailsColor,
            fontSize: 15,
            fontWeight: FontWeight.w200,
          ),
          const SizedBox(width: 5),
          const CustomText(
            text: 'facebook',
            fontColor: Colors.blueAccent,
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ],
      )
    );
  }
}
