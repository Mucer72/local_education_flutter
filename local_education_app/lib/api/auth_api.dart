import 'package:local_education_app/models/user/user.dart' as usr;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<dynamic> authLogin(String userName, String password) async {

  final FirebaseAuth auth = FirebaseAuth.instance;
  try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );

    return userCredential;
  } catch (e) {
    debugPrint("There is error while posting $e");
    return null;
  }
}

Future<dynamic> authRegister(
  String phone,
  String username,
  String email,
  String password,
) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );  
    String uid = userCredential.user!.uid;
    await _firestore.collection("users").doc(uid).set({
      'userName': username,
      'userId': uid,
      'email': email,
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
      'profileImageUrl': '',
    });

    return 200;
  } catch (e) {
    debugPrint("There is error while posting $e");
    return 400;
  }
}

Future<dynamic> authGetProfile() async {
  try {
    User? user = _auth.currentUser;
    DocumentSnapshot userDoc;
  if (user != null) {
    userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();;
        print(userDoc);
    return usr.User.fromMap(userDoc.data() as Map<String, dynamic>);
  }
  } catch (e) {
    debugPrint("There is error while getting profile: $e");
  }
}
