import 'dart:convert';
import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/screens/auth/signup/signup_screen.dart';
import 'package:easyplay_app/screens/auth/widgets/others_login.dart';
import 'package:easyplay_app/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/theme/theme_app.dart';
import '../../../models/validator_model.dart';
import '../../../services/auth.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/buttons/custom_button_password.dart';
import '../../../widgets/buttons/custom_text_button.dart';
import '../../../widgets/custom_listview/custom_listview.dart';
import '../../../widgets/inputs/custom_text_form_field.dart';
import '../../../widgets/logo/logo.dart';
import '../../../widgets/texts/custom_text.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInSignInScreenState createState() => _SignInSignInScreenState();
}

class _SignInSignInScreenState extends State<SignInScreen> with ValidatorModelAppDefault {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  Future<void>signIn() async {
    if(_formKey.currentState!.validate()){
      Map<String, dynamic> auth = await Auth().signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim()
      );
      if(auth['success']){
        Map<String, dynamic> userData = await UserModel.getUserData(auth['userId']);
        setState(() {
          UserModel.userMapData = userData;
        });
        userData.remove('createdAt');
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userInfoCache', json.encode(userData));
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
                  hintText: 'nome de usuário ou email',
                  validator: validateEmail,
                  controller: usernameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: 'senha',
                  validator: validateText,
                  controller: passwordController,
                  obscureText: !showPassword,
                  suffixIcon: CustomButtonPassword(
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                      showPassword: showPassword
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomText(
                    text: 'esqueci minha senha',
                    fontColor: ThemeApp.themeTextDetailsColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomButton(
                  title: 'entrar',
                  onTap: signIn,
                ),
                const SizedBox(
                  height: 35,
                ),
                const OthersLogin(),
                const SizedBox(
                  height: 50,
                ),
                CustomTextButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  text: 'novo cadastro',
                ),
              ]
          ),
        )
      ),

    );
  }

}

