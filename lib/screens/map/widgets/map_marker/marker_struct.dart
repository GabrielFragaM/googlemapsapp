import 'package:easyplay_app/constants/theme/theme_app.dart';
import 'package:easyplay_app/widgets/post_images/post_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/fade_effect.dart';
import 'package:flutter_animate/effects/scale_effect.dart';
import 'package:tab_container/tab_container.dart';
import '../../../../widgets/texts/custom_text.dart';

///MAIN CONTAINER
Widget getContainerBottomInfoMarker(List<Widget> children){
  return Container(
    height: 500,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: ThemeApp.themeContainerDetailsColor,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

String getMarkerTitle(String markerType){
  return markerType == 'event' ? 'Evento' :
  markerType == 'user' ? 'Usuário' :
  markerType == 'meeting' ? 'Encontro' :
  markerType == 'championship' ? 'Campeonato' : '';
}

Color getMarkerColor(String markerType){
  return markerType == 'event' ? Colors.red :
  markerType == 'user' ? Colors.blue :
  markerType == 'meeting' ? Colors.deepPurple :
  markerType == 'championship' ? Colors.amber : ThemeApp.themeMainColor;
}

Widget getContainerInfoMarker(String markerType){
  Widget containerInfoMarker = Animate(
      effects: const [FadeEffect(), ScaleEffect()],
      child: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: getMarkerColor(markerType),
        ),
        child: Center(
          child: CustomText(
              text: getMarkerTitle(markerType), fontSize: 11
          ),
        ),
      )
  );

  return containerInfoMarker;
}

///BODY CONTAINER - MAIN TAB
Widget getHeaderMarker(String markerType, Map markerImage, String title, String subTitle){

  Widget header = Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: markerImage['type'] == 'network' ?
              CircleAvatar(
                backgroundImage: NetworkImage(markerImage['image']),
                maxRadius: 25,
              ):
              CircleAvatar(
                backgroundImage: AssetImage(markerImage['image']),
                maxRadius: 25,
              )
            ),
            const SizedBox(width: 15),
            Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: title.toString().toString().toUpperCase(),
                        textStyle: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: ThemeApp.themeTextDetailsColor
                        )
                    ),
                    CustomText(
                        text: subTitle.toString(),
                        textStyle: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 9.7,
                            color: ThemeApp.themeTextDetailsColor
                        )
                    )
                  ],
                )
            ),
          ],
        ),
        getContainerInfoMarker(markerType)
      ],
    ),
  );

  return header;
}

///BODY CONTAINER - MAIN TAB - CHILDREN TABS
Widget getBodyTabsMarker(void Function() onEnd, List<Widget> children){
  return Animate(
      effects: const [FadeEffect(), ScaleEffect()],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: TabContainer(
            childPadding: const EdgeInsets.all(15),
            color: Colors.white,
            isStringTabs: false,
            onEnd: onEnd,
            tabEdge: TabEdge.right,
            children: children,
            tabs: [
              Icon(Icons.info, color: ThemeApp.themeIconsDetailsColor),
              Icon(Icons.live_tv, color: ThemeApp.themeIconsDetailsColor),
              Icon(Icons.account_circle, color: ThemeApp.themeIconsDetailsColor),
            ],
          ),
        ),
      )
  );
}

Widget getTopDescriptionTabMarker(String title, String description){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
          text: title,
          textStyle: TextStyle(fontWeight: FontWeight.w500,
              fontSize: 15, color: ThemeApp.themeTextDetailsColor)
      ),
      const SizedBox(height: 20),
      CustomText(
          text: description,
          textStyle: TextStyle(fontWeight: FontWeight.w200,
              fontSize: 13, color: ThemeApp.themeTextDetailsColor)
      ),
    ],
  );
}

Widget getImageLiveTabMarker(String id, bool isUserMarker){
  return SizedBox(
    width: double.infinity,
    height: 270,
    child: PostImages(
      id: id,
      isUserMarker: isUserMarker,
    ),
  );
}