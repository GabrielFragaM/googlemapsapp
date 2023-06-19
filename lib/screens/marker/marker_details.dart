import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/screens/marker/widgets/tags_widget.dart';
import 'package:easyplay_app/services/markers.dart';
import 'package:easyplay_app/widgets/appbar/custom_app_bar.dart';
import 'package:easyplay_app/widgets/buttons/custom_button.dart';
import 'package:easyplay_app/widgets/custom_listview/custom_listview.dart';
import 'package:easyplay_app/widgets/images_marker_list/images_marker_list.dart';
import 'package:flutter/material.dart';
import '../../models/marker_model.dart';
import '../../widgets/inputs/custom_text_form_field.dart';

class MarkerDetailsScreen extends StatefulWidget {

  final Map<String, dynamic> markerData;
  final double latitude;
  final double longitude;
  final String action;

  const MarkerDetailsScreen({Key? key,
    required this.markerData, required this.latitude, required this.longitude, required this.action
  }) : super(key: key);

  @override
  _MarkerDetailsScreenState createState() => _MarkerDetailsScreenState();
}

class _MarkerDetailsScreenState extends State<MarkerDetailsScreen> with ValidatorModelAppDefault {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  saveMarker(context) async {
    if(_formKey.currentState!.validate()){
      final String id = widget.action == 'create' ? Timestamp.now().microsecondsSinceEpoch.toString() : widget.markerData['id'];

      Map<String, dynamic> marker = {
        'id': id,
        'title': MarkerModel.titleController.text,
        'subTitle': MarkerModel.subTitleController.text,
        'description': MarkerModel.descriptionController.text,
        'tags': MarkerModel.tags,
        'markerImage': MarkerModel.markerImage,
        'type': MarkerModel.type,
        'latitude': widget.latitude,
        'longitude': widget.longitude,
        'userId': UserModel.userMapData['id']
      };

      Map<String, dynamic> result = widget.action == 'create' ? await saveNewMarker(context, marker) : await updateMarker(context, marker);

      if(result['success']){
        setState(() {
          MarkerModel.markers.add(result['marker']);
        });
        Navigator.pop(context);
        //show success message = result['message']
      }else{
        //show success error = result['message']
      }
    }
  }

  @override
  void initState() {
    if(widget.action == 'edit'){
      ///IMAGEM DO MARCADOR
      MarkerModel.markerImage = widget.markerData['markerImage'];
      MarkerModel.defaultMarkerImages = [
        {'image': '_', 'type': '_'},
        widget.markerData['markerImage'],
        ...MarkerModel.defaultMarkerImages
      ];
      MarkerModel.markerImage = widget.markerData['markerImage'];
      MarkerModel.titleController.text = widget.markerData['title'];
      MarkerModel.subTitleController.text = widget.markerData['subTitle'];
      MarkerModel.descriptionController.text = widget.markerData['description'];
      MarkerModel.tags = widget.markerData['tags'];
    }else{
      MarkerModel.dispose();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: CustomAppBar(
                title: widget.action == 'create' ? 'novo evento' : 'evento',
              )
          ),
          body: CustomListView(
            children: [
              const SizedBox(height: 5),
              MarkerImagesWidget(images: MarkerModel.defaultMarkerImages),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: 'título',
                      validator: validateText,
                      maxLength: 33,
                      controller: MarkerModel.titleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'sub título',
                      validator: validateText,
                      maxLength: 40,
                      controller: MarkerModel.subTitleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'descrição',
                      maxLines: 6,
                      controller: MarkerModel.descriptionController,
                      maxLength: 200,
                      validator: validateText,
                    ),
                  ],
                ),
              ),
              TagsWidget(
                  onChangeTags: (List tags) {
                    setState(() {
                      MarkerModel.tags = tags;
                    });
                  }
              ),
              const SizedBox(height: 25),
              CustomButton(onTap: () async {
                await saveMarker(context);
              }, title: 'salvar')
            ],
          ),
        ),
    );
  }
}