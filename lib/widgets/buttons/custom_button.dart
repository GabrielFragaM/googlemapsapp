import 'package:flutter/material.dart';

import '../../constants/theme/theme_app.dart';
import '../texts/custom_text.dart';


class CustomButton extends StatefulWidget {

  final Function onTap;
  final String title;

  const CustomButton({Key? key,
    required this.onTap, required this.title
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: loading == false ?
          MaterialStateProperty.all<Color>(ThemeApp.themeMainColor):
          MaterialStateProperty.all<Color>(const Color(0x4981BCF6)),
        ),
        onPressed: () async {
          if(loading){
            return;
          }
          setState(() {
            loading = true;
          });

          await widget.onTap();

          setState(() {
            loading = false;
          });
        },
        child: Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.center,
            child: loading == false ?
            CustomText(
                text: widget.title
            ): const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            )
        )
    );
  }
}