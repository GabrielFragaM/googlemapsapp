import 'package:easyplay_app/services/local_storage.dart';


Future<bool>checkPermission(String permission) async {
  Map<String, dynamic> localStorage = await getLocalStorage();

  return localStorage['permissions'][permission];
}