import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import '../../constants/theme/theme_app.dart';


class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? extraWidget;

  const CustomAppBar(
      {Key? key,
         this.title, this.extraWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 105,
        color: ThemeApp.themeAppBarDetailsColor,
        child: Column(
          children: [
            Container(
                height: 45,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 25,
                        child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: (){
                              Navigator.pop(context);
                            } ,
                            icon: const Icon(Icons.arrow_back_ios)
                        ),
                      ),
                      CustomText(
                        text: title ?? '',
                        fontColor: ThemeApp.themeTextDetailsColor,
                      ),
                      Container(
                        width: 25,
                      ),
                    ],
                  ),
                )
            ),
            extraWidget ?? Container()
          ],
        )
    );
  }
}
