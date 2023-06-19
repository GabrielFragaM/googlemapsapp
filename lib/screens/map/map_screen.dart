import 'package:circular_menu/circular_menu.dart';
import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/screens/map/widgets/search_address/search_screen.dart';
import 'package:easyplay_app/screens/marker/marker_details.dart';
import 'package:easyplay_app/screens/profile/profile.dart';
import 'package:easyplay_app/services/users.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/theme/theme_app.dart';
import '../../models/marker_model.dart';
import '../../services/markers.dart';


class MapScreen extends StatefulWidget {

  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  setCurrentPosition(BuildContext context) async {
    Marker userMarker = await getUserCurrentPosition(context);
    setState(() {
      UserModel.userMapData = UserModel.userMapData;
      MarkerModel.markers.add(userMarker);
    });
  }

  @override
  void initState() {
    getAllMarkers(context).then((markers) {
      setState(() {
        MarkerModel.markers = markers;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: CircularMenu(
            alignment: Alignment.bottomCenter,
            backgroundWidget: GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(13,25),
              initialCameraPosition: defaultPosition,
              onLongPress: (LatLng latLong) async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarkerDetailsScreen(
                    markerData: const {}, action: 'create', latitude: latLong.latitude, longitude: latLong.longitude,
                  )),
                );
              },
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  mapController = controller;
                });
                mapController.setMapStyle(ThemeApp.mapTheme).whenComplete(() async {
                  await setCurrentPosition(context);
                  mapController.animateCamera(CameraUpdate.newCameraPosition(UserModel.userMapData['cameraPosition']));
                });
              },
              markers: MarkerModel.markers.toSet(),
            ),
            toggleButtonColor: ThemeApp.themeMainColor,
            toggleButtonBoxShadow: const [],
            items: [
              CircularMenuItem(
                  icon: Icons.add,
                  boxShadow: const [],
                  color: Colors.black,
                  onTap: () {
                  }
              ),
              CircularMenuItem(
                  icon: Icons.search,
                  boxShadow: const [],
                  color: Colors.black,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchScreen()),
                    );
                    if(MarkerModel.goToSelectedAddress.isNotEmpty){
                      CameraPosition position = await getCameraPosition(
                          MarkerModel.goToSelectedAddress['latitude'], MarkerModel.goToSelectedAddress['longitude'], null
                      );
                      mapController.animateCamera(CameraUpdate.newCameraPosition(position));
                      setState(() {
                        MarkerModel.goToSelectedAddress = {};
                      });
                    }
                  }
              ),
              CircularMenuItem(
                  icon: Icons.location_on,
                  boxShadow: const [],
                  color: Colors.black,
                  onTap: () {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(UserModel.userMapData['cameraPosition']));
                  }
              ),
              CircularMenuItem(
                  icon: Icons.account_circle_rounded,
                  boxShadow: const [],
                  color: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen(
                          id: UserModel.userMapData['id'], username: UserModel.userMapData['username'],
                          image: UserModel.userMapData['profileImage'], name: UserModel.userMapData['name'], bio: UserModel.userMapData['bio']
                      )),
                    );
                  }
              ),
              CircularMenuItem(
                  icon: Icons.settings,
                  boxShadow: const [],
                  color: Colors.black,
                  onTap: () {
                  }
              ),
            ],
          ),
        )
    );
  }

}

