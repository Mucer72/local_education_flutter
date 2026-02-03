
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_education_app/api/auth_api.dart';
import 'package:local_education_app/models/user/user.dart' as usr;
import 'package:local_education_app/services/storage/auth_storage.dart';

class AuthProvider with ChangeNotifier {
  String? _ID;
  void setJwtID(String ID) {
    _ID = ID;
    notifyListeners();
  }
  String? get jwtID => _ID;

  Future<int> login(String username, String password) async {
    try {
      final response = await authLogin(username, password);
      _ID = response.user!.uid;
      await AuthStorage.saveID(_ID!);
      notifyListeners();
      return 200;
    } catch (e) {
      debugPrint('Error while login in : $e');
      return 400;
    }
  }

  Future<void> logOut() async {
    _ID = "";
    notifyListeners();
    await FirebaseAuth.instance.signOut();
    await AuthStorage.deleteID();
  }

  Future<usr.User?> getProfile() async {
    try {
      final response = await authGetProfile();
        return response;
    } catch (e) {
      debugPrint("There is Error: $e");
      return null;
    }
  }
}
