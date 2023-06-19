
import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/screens/profile/widgets/button_edit_profile.dart';
import 'package:easyplay_app/screens/profile/widgets/user_markers.dart';
import 'package:easyplay_app/services/users.dart';
import 'package:easyplay_app/widgets/appbar/custom_app_bar.dart';
import 'package:easyplay_app/widgets/post_images/post_images.dart';
import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';
import '../../../constants/theme/theme_app.dart';
import 'widgets/button_follow_unfollow.dart';

class ProfileScreen extends StatefulWidget {

  final String id;
  final String username;
  final Map image;
  final String name;
  final String bio;

   const ProfileScreen({Key? key,
    required this.id, required this.username, required this.image, required this.name, required this.bio
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ValidatorModelAppDefault {

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: CustomAppBar(
                title: widget.username,
              )
          ),
          body: Padding(
              padding: const EdgeInsets.all(30),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration:
                        widget.image['type'] == 'network' ?
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(widget.image['image']),
                            )
                        ):
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: AssetImage(widget.image['image']),
                            )
                        )
                      ),
                      SizedBox(
                        height: 85,
                        width: _width / 1.8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: '2', fontColor: Colors.black),
                                      const CustomText(text: 'eventos', fontColor: Colors.grey),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: '244', fontColor: Colors.black),
                                      const CustomText(text: 'seguindo', fontColor: Colors.grey),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: '553', fontColor: Colors.black),
                                      const CustomText(text: 'seguidores', fontColor: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            widget.id == UserModel.userMapData['id'] ?
                            const ButtonEditProfile() :
                            FollowAndUnfollowButton(profileId: widget.id)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    text: widget.name,
                    fontColor: Colors.black,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    text: widget.bio,
                    fontColor: Colors.grey,
                    fontSize: 13,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: TabContainer(
                      childPadding: const EdgeInsets.all(15),
                      color: const Color(0x4981BCF6),
                      isStringTabs: false,
                      onEnd: () {},
                      tabEdge: TabEdge.right,
                      children: [
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: getAllMarkersUser(widget.id),
                          builder: (context, events) {
                            if (events.connectionState == ConnectionState.done) {
                              return UserMarkers(events: events.data);
                            }else{
                              return Container();
                            }
                          },
                        ),
                        PostImages(
                          id: widget.id,
                          isUserMarker: false,
                        )
                      ],
                      tabs: [
                        Icon(Icons.emoji_events_outlined, color: ThemeApp.themeIconsDetailsColor),
                        Icon(Icons.live_tv, color: ThemeApp.themeIconsDetailsColor),
                      ],
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}