import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>>getLocalStorage() async {

  final prefs = await SharedPreferences.getInstance();
  String? cache = prefs.getString('localStorage');

  Map<String, dynamic> localStorage = {
    'users': [],
    'permissions': {
      'createMarker': true,
      'auth': true,
      'followAndUnfollow': true,
      'makeRequestApi': true,
      'accessMap': true,
      'useChatGlobalMarker': true
    },
    'following': []
  };

  if(cache != null){
    return jsonDecode(cache);
  }else{
    updateLocalStorage(localStorage);
    return localStorage;
  }
}

Future<void>updateLocalStorage(Map<String, dynamic> update) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('localStorage', jsonEncode(update));
}