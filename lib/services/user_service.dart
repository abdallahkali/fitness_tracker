// lib/services/user_service.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String? gender;
  int? age;
  double? weight;
  double? height;
  String? activityLevel;

  UserData({
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'activityLevel': activityLevel,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      activityLevel: map['activityLevel'],
    );
  }
}

class UserService {
  static const String _userKey = 'user_data';

  Future<void> saveUserData(UserData userData) async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    final userMap = userData.toMap();

    // تحويل البيانات إلى JSON string
    final userJson = {
      'gender': userData.gender,
      'age': userData.age,
      'weight': userData.weight,
      'height': userData.height,
      'activityLevel': userData.activityLevel,
    };

    await prefs.setString(_userKey, jsonEncode(userJson));
  }

  Future<UserData?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonString = prefs.getString(_userKey);

    if (userJsonString != null) {
      final userMap = jsonDecode(userJsonString);
      return UserData.fromMap(userMap);
    }
    return null;
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<bool> hasUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }
}
