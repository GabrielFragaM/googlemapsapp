import 'package:flutter/material.dart';

import '../../../constants/theme/theme_app.dart';
import '../../../widgets/buttons/custom_btn_facebook.dart';
import '../../../widgets/texts/custom_text.dart';

class OthersLogin extends StatelessWidget {

  const OthersLogin(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 0.5,
              width: _width / 3,
              color: Colors.grey,
            ),
            CustomText(
              text: 'ou',
              fontColor: ThemeApp.themeTextDetailsColor,
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
            Container(
              height: 0.5,
              width: _width / 3,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 155,
            child: CustomButtonFacebook(onTap: () {}),
          ),
        ),
      ],
    );
  }
}