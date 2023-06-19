import 'dart:io';
import 'package:easyplay_app/models/marker_model.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import '../../../constants/theme/theme_app.dart';
import '../../services/images.dart';

class MarkerImagesWidget extends StatefulWidget {

  final List<Map<String, dynamic>> images;

  const MarkerImagesWidget({Key? key,
    required this.images
  }) : super(key: key);

  @override
  _MarkerImagesWidgetState createState() => _MarkerImagesWidgetState();
}

class _MarkerImagesWidgetState extends State<MarkerImagesWidget> {

  static GlobalKey previewContainer = GlobalKey();

  List<Map<String, dynamic>> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: images.length * 500,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (_, index) => index == 0 ?
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ExpandTapWidget(
                tapPadding: const EdgeInsets.all(15),
                onTap: () async {
                  File? file = await getImage();
                  if(file != null){
                    setState(() {
                      images[0] = {'image': file, 'type': 'file'};
                      MarkerModel.markerImage = {'image': file, 'type': 'file'};
                    });
                  }else{
                    setState(() {
                      images[0] = MarkerModel.markerImage;
                    });
                  }
                },
                child: Column(
                  children: [
                    RepaintBoundary(
                      key: previewContainer,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: MarkerModel.markerImage['type'] == 'file' ?
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: FileImage(MarkerModel.markerImage['image']),
                                fit: BoxFit.fitWidth
                            )
                        ) :
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFFE5E5E5)
                        ),
                        child: MarkerModel.markerImage['type'] != 'file' ? const Icon(Icons.edit, size: 16, color: Color(0xFF757575)) : Container(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.6,
                              color: images[index]['image'] == MarkerModel.markerImage['image'] ? ThemeApp.themeMainColor : Colors.grey
                          ),
                          color: images[index]['image'] == MarkerModel.markerImage['image'] ? ThemeApp.themeMainColor : Colors.white,
                          borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                  ],
                ),
              )
          ) :
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ExpandTapWidget(
                tapPadding: const EdgeInsets.all(15),
                onTap: () {
                  setState(() {
                    images[0] = {'image': '_', 'type': 'file'};
                    MarkerModel.markerImage = images[index];
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration:
                      images[index]['type'] == 'network' ?
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(images[index]['image']),
                              fit: BoxFit.fitWidth
                          )
                      ) :
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: AssetImage(images[index]['image']),
                          )
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.6,
                              color: images[index]['image'] == MarkerModel.markerImage['image'] ? ThemeApp.themeMainColor : Colors.grey
                          ),
                          color: images[index]['image'] == MarkerModel.markerImage['image'] ? ThemeApp.themeMainColor : Colors.white,
                          borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}
