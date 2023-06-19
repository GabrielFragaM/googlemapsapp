import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserModel {
  static Map<String, dynamic> userMapData = {};

  static TextEditingController usernameController = TextEditingController();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController bioController = TextEditingController();

  static Future<Map<String, dynamic>>getUserData(String userId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    Map<String, dynamic> userMapData = {
      'id': doc.id,
      'username': '@' + doc.get('username'),
      'email': doc.get('email'),
      'bio': doc.get('bio'),
      'name': doc.get('name'),
      'createdAt': doc.get('createdAt'),
      'profileImage': doc.get('profileImage'),
      'latitude': doc.get('latitude'),
      'longitude': doc.get('longitude')
    };

    return userMapData;
  }

  static initUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userInfoCache');
    if(userData != null){
      UserModel.userMapData = json.decode(userData);
    }
  }

  factory UserModel() => UserModel._internal();
  UserModel._internal();
}