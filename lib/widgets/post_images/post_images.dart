import 'package:easyplay_app/models/validator_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../../screens/map/widgets/post/post_image.dart';
import '../../services/images.dart';
import '../../services/markers.dart';
import '../../services/users.dart';


class PostImages extends StatefulWidget {

  final String id;
  final bool isUserMarker;

  const PostImages({Key? key,
    required this.id, required this.isUserMarker
  }) : super(key: key);

  @override
  _PostImagesState createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> with ValidatorModelAppDefault {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.isUserMarker ?
      getImagesMarker(widget.id):
      getImagesUser(widget.id),
      builder: (context, images) {
        if (images.connectionState == ConnectionState.done) {
          return ResponsiveGridList(
              scroll: true,
              desiredItemWidth: 80,
              minSpacing: 3,
              children: images.data!.map((img) {
                return FutureBuilder<dynamic>(
                  future: getCacheImages(img['image']),
                  builder: (context, imgCache) {
                    if (imgCache.connectionState == ConnectionState.done) {
                      return GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> markerData = await getMarkerData(img['markerId']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PostImage(markerData: markerData, image: imgCache.data)),
                          );
                        },
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(imgCache.data),
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(Color(0x3D000000), BlendMode.darken),
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  },
                );
              }).toList()
          );
        }else{
          return Container();
        }
      },
    );
  }
}

