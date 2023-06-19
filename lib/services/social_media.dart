
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyplay_app/services/local_storage.dart';

Future<bool>checkFollowAndUnfollow(String userId, String profileId) async {
  final Map<String, dynamic> localStorage = await getLocalStorage();

  if(localStorage['following'].where((_userId) => _userId == userId).isEmpty){
    return false;
  }else{
    return true;
  }
}

followAndUnfollowAction(bool? follow, String userId, String profileId) async {
  final Map<String, dynamic> localStorage = await getLocalStorage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  if(follow != null){
    if(follow){
      final Map<String, dynamic> userUpdate = {'userId': userId, 'createdAt': Timestamp.now()};
      firestore.collection('users').doc(profileId).collection('follows').add(userUpdate);

      localStorage['following'].add(profileId);
      updateLocalStorage(localStorage);

      userUpdate['userId'] = profileId;
      firestore.collection('users').doc(profileId).collection('following').add(userUpdate);
    }else{
      firestore.collection('users').doc(profileId).collection('follows').doc(userId).delete();

      localStorage['following'].remove(profileId);
      updateLocalStorage(localStorage);
      firestore.collection('users').doc(userId).collection('following').doc(profileId).delete();
    }
  }
}

