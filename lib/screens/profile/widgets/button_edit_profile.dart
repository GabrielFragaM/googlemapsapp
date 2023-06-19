import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../constants/theme/theme_app.dart';
import '../../user/user_details.dart';

class ButtonEditProfile extends StatefulWidget {
  const ButtonEditProfile({Key? key}) : super(key: key);


  @override
  _FollowAndUnfollowBottomState createState() => _FollowAndUnfollowBottomState();
}

class _FollowAndUnfollowBottomState extends State<ButtonEditProfile> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserDetailsScreen()),
        );
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0x4981BCF6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          text: 'editar perfil',
          fontColor: ThemeApp.themeMainColor,
        ),
      ),
    );
  }
}

