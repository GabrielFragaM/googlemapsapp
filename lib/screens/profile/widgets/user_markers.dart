import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import '../../map/widgets/map_marker/marker_struct.dart';


class UserMarkers extends StatefulWidget {

  final List<Map<String, dynamic>>? events;

  const UserMarkers({Key? key,
    required this.events
  }) : super(key: key);

  @override
  _UserMarkersState createState() => _UserMarkersState();
}

class _UserMarkersState extends State<UserMarkers> with ValidatorModelAppDefault {

  getMarker(Map<String, dynamic> marker){
    return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
            height: 55,
            decoration: BoxDecoration(
                color: getMarkerColor(marker['type']),
                borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
                leading: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(marker['markerImage']),
                      )
                  ),
                ),
                title: SizedBox(
                  height: 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: getMarkerTitle(marker['type']),
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: marker['subTitle'],
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.events!.length,
        itemBuilder: (_, index) => getMarker(widget.events![index])
    );
  }
}

