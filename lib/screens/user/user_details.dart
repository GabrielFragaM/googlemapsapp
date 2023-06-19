import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/widgets/appbar/custom_app_bar.dart';
import 'package:easyplay_app/widgets/custom_listview/custom_listview.dart';
import 'package:flutter/material.dart';
import '../../models/marker_model.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/images_marker_list/images_marker_list.dart';
import '../../widgets/inputs/custom_text_form_field.dart';


class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> with ValidatorModelAppDefault {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  saveUser() async {
    if(_formKey.currentState!.validate()){

    }
  }

  @override
  void initState() {
    ///IMAGEM DE PERFIL E NO MARCADOR
    MarkerModel.markerImage = {'image': UserModel.userMapData['profileImage'], 'type': 'network'};
    MarkerModel.defaultMarkerProfileImages = [
      {'image': '_', 'type': '_'},
      {'image': UserModel.userMapData['profileImage'], 'type': 'network'},
      ...MarkerModel.defaultMarkerProfileImages
    ];
    UserModel.usernameController.text = UserModel.userMapData['username'];
    UserModel.nameController.text = UserModel.userMapData['name'];
    UserModel.bioController.text = UserModel.userMapData['bio'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: CustomAppBar(
                title: 'usuário',
              )
          ),
          body: CustomListView(
            children: [
              const SizedBox(height: 5),
              MarkerImagesWidget(images: MarkerModel.defaultMarkerProfileImages),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: 'usuário',
                      validator: validateText,
                      maxLength: 15,
                      controller: UserModel.usernameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'nome',
                      validator: validateText,
                      maxLength: 40,
                      controller: UserModel.nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'bio',
                      maxLines: 4,
                      controller: UserModel.bioController,
                      maxLength: 120,
                      validator: validateText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              CustomButton(onTap: saveUser, title: 'salvar')
            ],
          ),
        ),
    );
  }
}