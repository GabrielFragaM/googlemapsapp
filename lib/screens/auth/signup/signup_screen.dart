import 'dart:convert';
import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/screens/map/map_screen.dart';
import 'package:easyplay_app/widgets/custom_listview/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/auth.dart';
import '../../../services/users.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/buttons/custom_button_password.dart';
import '../../../widgets/buttons/custom_text_button.dart';
import '../../../widgets/inputs/custom_text_form_field.dart';
import '../../../widgets/logo/logo.dart';
import '../widgets/others_login.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidatorModelAppDefault {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  Future<void>signUp() async {
    if(_formKey.currentState!.validate()){
      Map<String, dynamic> localization = await getUserLocalization(context);
      if(!localization['success']){
        return;
      }
      Map<String, dynamic> data = {
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'latitude': localization['localization'].latitude,
        'longitude': localization['localization'].longitude
      };
      Map<String, dynamic> auth = await Auth().createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          data: data
      );
      if(auth['success']){
        setState(() {
          UserModel.userMapData = auth['user'];
        });
        data.remove('createdAt');
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userInfoCache', json.encode(data));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: CustomListView(
              children: [
                const Logo(),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'email',
                  controller: emailController,
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'nome completo',
                  controller: nameController,
                  validator: validateText,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'nome de usuário',
                  controller: usernameController,
                  validator: validateText,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'senha',
                  controller: passwordController,
                  validator: validatePassword,
                  obscureText: !showPassword,
                  suffixIcon: CustomButtonPassword(
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                      showPassword: showPassword
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomButton(
                  title: 'cadastrar',
                  onTap: signUp,
                ),
                const SizedBox(
                  height: 35,
                ),
                const OthersLogin(),
                CustomTextButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'entrar',
                ),
              ]
          ),
        )
      ),

    );
  }
}