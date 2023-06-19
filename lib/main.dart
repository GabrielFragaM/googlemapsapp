import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyplay_app/models/user_model.dart';
import 'package:easyplay_app/screens/chats/global_marker_chat/global_chat.dart';
import 'package:easyplay_app/screens/map/map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easyplay_app/services/auth.dart';
import 'constants/theme/theme_app.dart';
import 'models/marker_model.dart';
import 'screens/auth/signin/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserModel.initUserData();
  MarkerModel.goToSelectedAddress = {};
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ///AUTH CHECK APP
  Widget authMain = StreamBuilder(
    stream: Auth().authStateChanges,
    builder: (context, snapshot) {
      if (snapshot.hasData && UserModel.userMapData.isNotEmpty) {
        return const MapScreen();
      } else {
        return const SignInScreen();
      }
    },
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Easy Play App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: ThemeApp.themeMainColor,
      scaffoldBackgroundColor: ThemeApp.themeScaffoldBackgroundColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ThemeApp.themeCursorColor,
      ),
    ),
    home: authMain,
  );
}