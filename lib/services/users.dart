import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/marker_model.dart';
import '../models/user_model.dart';
import 'markers.dart';


Future<Marker>getUserCurrentPosition(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? cache = prefs.getString('userInfoCache');

  Marker userMarker = await getMarker(context, UserModel.userMapData['id'], 'user',
      UserModel.userMapData['profileImage'], UserModel.userMapData['name'], UserModel.userMapData['username'], UserModel.userMapData['bio'],
      UserModel.userMapData['latitude'], UserModel.userMapData['longitude']);

  if(cache != null){
    Map<String, dynamic> userCache = json.decode(cache);
    CameraPosition cameraPosition = await getCameraPosition(userCache['latitude'], userCache['longitude'], null);
    UserModel.userMapData['cameraPosition'] = cameraPosition;
    return userMarker;
  }

  return await Geolocator.requestPermission().then((value) async {
    return await Geolocator.getCurrentPosition().then((position) async {
      CameraPosition cameraPosition = await getCameraPosition(position.latitude, position.longitude, null);
      UserModel.userMapData['cameraPosition'] = cameraPosition;
      return userMarker;
    });
  }).onError((error, stackTrace) async {
    await Geolocator.requestPermission();
    Marker marker = await getUserCurrentPosition(context);
    return marker;
  });
}

Future<Map<String, dynamic>>getUserLocalization(BuildContext context) async {
  return await Geolocator.requestPermission().then((value) async {
    return await Geolocator.getCurrentPosition().then((position) async {
      return {
        'localization': position,
        'success': true,
        'message': 'Localização encontrada.'
      };
    });
  }).onError((error, stackTrace) async {
    return {
      'localization': {},
      'success': false,
      'message': error.toString(),
    };
  });
}

Future<List<Map<String, dynamic>>>getImagesUser(String userId) async{
  QuerySnapshot query = await FirebaseFirestore.instance.collection('images').where('userId', isEqualTo: userId).get();
  List<Map<String, dynamic>> images = [];
  for(QueryDocumentSnapshot doc in query.docs){
    images.add(MarkerModel.getImageMarkerFormat(doc));
  }
  images.sort((a, b){
    return DateTime.parse(a['createdAt']).compareTo(DateTime.parse(b['createdAt']));
  });
  return images;
}


Future<Map<String, dynamic>>saveNewUser(Map<String, dynamic> userData) async {
  return await FirebaseFirestore.instance.collection('users').doc(userData['id']).set(userData).then((value) async
  {
    return {
      'success': true
    };
  }).catchError((onError) {
    return {
      'success': false
    };
  });
}

Future<Map<String, dynamic>>updateUser(BuildContext context, Map<String, dynamic> userData) async {
  return await FirebaseFirestore.instance.collection('users').doc(userData['id']).update(userData).then((value) async
  {
    Marker marker = await getMarker(context, userData['id'], 'user', userData['profileImage'], userData['name'],
        userData['username'], userData['bio'],
        userData['latitude'], userData['longitude']);
    return {
      'success': true,
      'marker': marker
    };
  }).catchError((onError) {
    return {
      'success': false,
    };
  });
}

Future<List<Map<String, dynamic>>>getAllMarkersUser(String userId) async {
  List<Map<String, dynamic>> markers = [];

  QuerySnapshot query = await FirebaseFirestore.instance.collection('markers').where('userId', isEqualTo: userId).get();

  if(query.docs.isNotEmpty){
    for(QueryDocumentSnapshot doc in query.docs){
      markers.add(MarkerModel.getMarkerFormat(doc));
    }
    return markers;
  }else{
    return markers;
  }
}