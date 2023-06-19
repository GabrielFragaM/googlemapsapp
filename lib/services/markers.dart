import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyplay_app/models/marker_model.dart';
import 'package:easyplay_app/services/permissions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screens/map/widgets/map_marker/marker_widget.dart';
import 'images.dart';


const CameraPosition defaultPosition = CameraPosition(
  target: LatLng(-27.152140, -48.487820),
  zoom: 14.4746,
);

///MARCADOR QUE FICARA NO MAPA
getMarkerWidget(String id, String type, Map markerImage, String title, String subTitle, String description,
    double latitude, double longitude,
    BuildContext context, BitmapDescriptor markerIcon){

  return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      icon: markerIcon,
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return MarkerWidget(
              id: id,
              type: type,
              markerImage: markerImage,
              title: title,
              subTitle: subTitle,
              description: description,
            );
          },
        );
      }
  );
}

Future<List<Marker>>getAllMarkers(context) async {
  List<Marker> markers = [];

  await FirebaseFirestore.instance.collection('markers').get().then((value) {
    for(QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs.toList()){
      getMarker(context, doc.id, doc.get('type'), doc.get('markerImage'), doc.get('title'), doc.get('subTitle'), doc.get('description'),
          doc.get('latitude'), doc.get('longitude')
      ).then((marker) {
        markers.add(marker);
      });
    }
  });

  return markers;
}


Future<Marker> getMarker(BuildContext context, String id, String type, Map markerImage, String title, String subTitle, String description, double latitude, double longitude) async {

  final Uint8List imgBytes = markerImage['type'] == 'network' ?
  await getBytesFromUrlImage(markerImage['image']) : await getBytesFromAsset(markerImage['image'], 100, 100);

  BitmapDescriptor markerIcon = BitmapDescriptor.fromBytes(imgBytes);

  return getMarkerWidget(id, type, markerImage, title, subTitle, description, latitude, longitude, context, markerIcon);
}

Future<Map<String, dynamic>>getMarkerData(String markerId) async{
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('markers').doc(markerId).get();
  Map<String, dynamic> marker = MarkerModel.getMarkerFormat(doc);

  return marker;
}

Future<List<Map<String, dynamic>>>getImagesMarker(String markerId) async{
  QuerySnapshot query = await FirebaseFirestore.instance.collection('images').where('markerId', isEqualTo: markerId).get();
  List<Map<String, dynamic>> images = [];
  for(QueryDocumentSnapshot doc in query.docs){
    images.add(MarkerModel.getImageMarkerFormat(doc));
  }
  images.sort((a, b){
    return DateTime.parse(a['createdAt']).compareTo(DateTime.parse(b['createdAt']));
  });
  return images;
}

Future<CameraPosition> getCameraPosition(double latitude, double longitude, double? zoom) async {
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: zoom ?? 16,
  );

  return cameraPosition;
}

Future<Map<String, dynamic>>saveNewMarker(BuildContext context, Map<String, dynamic> markerData) async {
  bool check = await checkPermission('createMarker');

  if(!check){
    return {
      'success': true,
      'message': 'sem autorização'
    };
  }

  return await FirebaseFirestore.instance.collection('markers').doc(markerData['id']).set(markerData).then((result) async
  {
    Marker marker = await getMarker(context, markerData['id'],
        markerData['type'], markerData['markerImage'], markerData['title'],
        markerData['subTitle'], markerData['description'], markerData['latitude'], markerData['longitude']
    );
    return {
      'success': true,
      'marker': marker,
      'message': 'salvo com sucesso.'
    };
  }).catchError((onError) {
    return {
      'success': false,
      'error': onError.toString(),
      'message': 'não foi possível salvar seu evento.'
    };
  });
}

Future<Map<String, dynamic>>deleteMarker(String markerId) async {
  return await FirebaseFirestore.instance.collection('markers').doc(markerId).delete().then((result) async
  {
    return {
      'success': true,
    };
  }).catchError((onError) {
    return {
      'success': false,
    };
  });
}

Future<Map<String, dynamic>>updateMarker(BuildContext context, Map<String, dynamic> markerData) async {
  return await FirebaseFirestore.instance.collection('markers').doc(markerData['id']).update(markerData).then((result) async
  {
    Marker marker = await getMarker(context, markerData['id'],
        markerData['type'], markerData['markerImage'], markerData['title'],
        markerData['subTitle'], markerData['description'], markerData['latitude'], markerData['longitude']
    );
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

