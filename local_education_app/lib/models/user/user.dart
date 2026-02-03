// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String username;
  String phone;
  DateTime createdDate;
  User({
    required this.email,
    required this.username,
    required this.phone,
    required this.createdDate,
  });
  factory User.fromMap(Map<String, dynamic> data) {
    
    return User(
      email: data['email'] as String,
      username: data['userName'] as String,
      phone: data['phone'] as String,
      createdDate: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
