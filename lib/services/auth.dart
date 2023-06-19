import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyplay_app/services/users.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      return {
        'success': true,
        'message': 'sucesso ao entrar.',
        'userId': value.user?.uid
      };
    }).catchError((onError) {
      return {
        'success': false,
        'message': onError.toString(),
        'userId': null
      };
    });
  }

  Future<Map<String, dynamic>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required Map<String, dynamic> data
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) async {
      data['createdAt'] = Timestamp.now();
      data['profileImage'] = {
        'image': 'assets/markers_user/marker_user_1.png',
        'type': 'asset'
      };
      data['bio'] = '';
      data['id'] = value.user?.uid;
      await saveNewUser(data);
      return {
        'success': true,
        'message': 'sucesso ao cadastrar.',
        'user': data
      };
    }).catchError((onError) {
      return {
        'success': false,
        'message': onError.toString(),
        'user': null
      };
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
