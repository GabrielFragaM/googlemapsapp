import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  static Map<String, dynamic> markerMapData = {};

  static Map<String, dynamic> goToSelectedAddress = {};

  ///LISTA DE MARCADORES PELA CLASSE DO GOOGLE MAPS "Marker"
  static List<Marker> markers = <Marker>[];

  ///ESTRURA CONTROLLERS E VARIAVEIS PARA CRIAR UM MARCADOR
  static List tags = [];
  static String type = 'event';
  static TextEditingController titleController = TextEditingController();
  static TextEditingController subTitleController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();

  static List<Map<String, dynamic>> defaultMarkerProfileImages = [
    {'image': 'assets/markers_user/marker_user_1.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_2.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_3.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_4.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_5.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_6.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_7.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_8.png', 'type': 'asset'},
    {'image': 'assets/markers_user/marker_user_9.png', 'type': 'asset'}
  ];

  static List<Map<String, dynamic>> defaultMarkerImages = [
    {'image': 'assets/markers/marker_balloons.png', 'type': 'asset'},
    {'image': 'assets/markers/marker_car_music.png', 'type': 'asset'},
    {'image': 'assets/markers/marker_championship.png', 'type': 'asset'},
    {'image': 'assets/markers/marker_confetti.png', 'type': 'asset'},
    {'image': 'assets/markers/marker_conversation.png', 'type': 'asset'},
    {'image': 'assets/markers/marker_skate_park_1.png', 'type': 'asset'},
    {'image': 'assets/markers/marker_tent.png', 'type': 'asset'},
    {'image': 'assets/markers_drinks/marker_cocktail.png', 'type': 'asset'},
    {'image': 'assets/markers_drinks/marker_juice.png', 'type': 'asset'},
    {'image': 'assets/markers_drinks/marker_pineapple.png', 'type': 'asset'},
    {'image': 'assets/markers_drinks/marker_watter.png', 'type': 'asset'}
  ];

  static Map<String, dynamic> markerImage =  {'image': '_', 'type': '_'};

  ///FUNCOES PARA REALIZAR TRATAMENTO DE DADOS DOS MARCADORES E SUAS IMAGENS
  static Map<String, dynamic>getMarkerFormat(doc){
    Map<String, dynamic> marker = {
      'id': doc.id,
      'title': doc.get('title'),
      'subTitle': doc.get('subTitle'),
      'type': doc.get('type'),
      'userId': doc.get('userId'),
      'markerImage': doc.get('markerImage'),
      'longitude': doc.get('longitude'),
      'latitude': doc.get('latitude'),
      'description': doc.get('description'),
      'tags': doc.get('tags'),
    };
    return marker;
  }

  static Map<String, dynamic>getImageMarkerFormat(doc){
    Map<String, dynamic> image = {
      'id': doc.id,
      'image': doc.get('image'),
      'markerId': doc.get('markerId'),
      'userId': doc.get('userId'),
      'createdAt': doc.get('createdAt')
    };
    return image;
  }

  static dispose(){
    tags.clear();
    markerImage = {'image': '_', 'type': '_'};
    titleController.text = '';
    subTitleController.text = '';
    descriptionController.text = '';
  }

  factory MarkerModel() => MarkerModel._internal();
  MarkerModel._internal();
}