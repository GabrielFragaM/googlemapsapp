import 'package:easyplay_app/screens/profile/profile.dart';
import 'package:easyplay_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import '../../../chats/global_marker_chat/global_chat.dart';
import 'marker_struct.dart';

class MarkerWidget extends StatefulWidget {
  final String id;
  final String type;
  final Map markerImage;
  final String title;
  final String subTitle;
  final String description;

  const MarkerWidget({Key? key,
    required this.id, required this.type, required this.markerImage, required this.title, required this.subTitle, required this.description
  }) : super(key: key);

  @override
  _MarkerWidgetState createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {

  bool reload = true;

  @override
  Widget build(BuildContext context) {
    return getContainerBottomInfoMarker(
        [
          getHeaderMarker(
              widget.type,
              widget.markerImage,
              widget.type == 'user' ? (widget.title.split(' ')[0] + ' ' + widget.title.split(' ')[1]) : widget.title,
              widget.subTitle
          ),
          getBodyTabsMarker(
                () {
              if(reload == true){
                setState(() {
                  reload = false;
                });
              }
            },
            [
              getTopDescriptionTabMarker(
                widget.type == 'user' ? widget.title : widget.subTitle,
                widget.description,
              ),
              getImageLiveTabMarker(widget.id, widget.type == 'user'),
              widget.type == 'user' ?
              Column(
                children: [
                  CustomButton(
                      title: 'ver perfil',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen(
                            id: widget.id, name: widget.title,
                            username: widget.subTitle, bio: widget.description, image: widget.markerImage
                          )),
                        );
                      }
                  ),
                ],
              ) :
              GlobalMarkerChat(markerId: widget.id),
            ],
          )
        ]
    );
  }

}

