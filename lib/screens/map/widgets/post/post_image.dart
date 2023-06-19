import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../../constants/theme/theme_app.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';


class PostImage extends StatefulWidget {

  final Map<String, dynamic> markerData;
  final String image;

  const PostImage({Key? key, required this.markerData, required this.image}) : super(key: key);

  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(105),
              child: CustomAppBar(
                title: 'publicação',
                extraWidget: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(widget.markerData['image']),
                            maxRadius: 22,
                          ),
                          const SizedBox(width: 10),
                          CustomText(
                            text: '@' + widget.markerData['username'],
                            fontColor: ThemeApp.themeTextDetailsColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomText(
                          text: '...',
                          fontColor: ThemeApp.themeTextDetailsColor,
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(widget.image),
              )
            ],
          ),
        )
    );
  }

}

