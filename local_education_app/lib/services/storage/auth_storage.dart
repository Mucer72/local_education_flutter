import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<bool> saveID(String ID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ID', ID);
      return true;
    } on Exception catch (e) {
      debugPrint("Error while saving ID in local storage: $e");
      return false;
    }
  }

  static Future<String?> loadID() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('ID');
    } on Exception catch (e) {
      debugPrint("Error while getting ID in local storage: $e");
      return null;
    }
  }

  static Future<bool> deleteID() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('ID');
      return true;
    } on Exception catch (e) {
      debugPrint('Error while deleting ID in local storage: $e');
      return false;
    }
  }
}
