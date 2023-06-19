
import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/services/auth.dart';
import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../constants/theme/theme_app.dart';
import '../../../services/social_media.dart';

class FollowAndUnfollowButton extends StatefulWidget {

  final String profileId;

  const FollowAndUnfollowButton({Key? key,
    required this.profileId
  }) : super(key: key);

  @override
  _FollowAndUnfollowButtonState createState() => _FollowAndUnfollowButtonState();
}

class _FollowAndUnfollowButtonState extends State<FollowAndUnfollowButton> with ValidatorModelAppDefault {

  @override
  Widget build(BuildContext context) {
    Widget buttonTemplateWidget = Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0x4981BCF6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: 'seguir',
        fontColor: ThemeApp.themeMainColor,
      ),
    );

    return FutureBuilder<bool>(
      future: checkFollowAndUnfollow(Auth().currentUser!.uid, widget.profileId),
      builder: (context, followUser) {
        if (followUser.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              followAndUnfollowAction(followUser.data, Auth().currentUser!.uid, widget.profileId);
              setState(() {});
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0x4981BCF6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomText(
                text: followUser.data == true ? 'deixar de seguir' : 'seguir',
                fontColor: ThemeApp.themeMainColor,
              ),
            ),
          );
        }else{
          return buttonTemplateWidget;
        }
      },
    );
  }
}

