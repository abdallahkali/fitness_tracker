// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  bool _isLoading = false;

  UserData? get userData => _userData;
  bool get isLoading => _isLoading;

  final UserService _userService = UserService();

  // تحميل البيانات عند بداية التطبيق
  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();

    _userData = await _userService.getUserData();

    _isLoading = false;
    notifyListeners();
  }

  // تحديث وحفظ بيانات المستخدم
  Future<void> updateUserData({
    String? gender,
    int? age,
    double? weight,
    double? height,
    String? activityLevel,
  }) async {
    _userData ??= UserData();

    if (gender != null) _userData!.gender = gender;
    if (age != null) _userData!.age = age;
    if (weight != null) _userData!.weight = weight;
    if (height != null) _userData!.height = height;
    if (activityLevel != null) _userData!.activityLevel = activityLevel;

    await _userService.saveUserData(_userData!);
    notifyListeners();
  }

  // حساب السعرات الحرارية
  double? calculateCalories() {
    if (_userData == null ||
        _userData!.age == null ||
        _userData!.weight == null ||
        _userData!.height == null ||
        _userData!.gender == null) {
      return null;
    }

    // معادلة Harris-Benedict
    if (_userData!.gender == 'male') {
      return 88.362 +
          (13.397 * _userData!.weight!) +
          (4.799 * _userData!.height!) -
          (5.677 * _userData!.age!);
    } else {
      return 447.593 +
          (9.247 * _userData!.weight!) +
          (3.098 * _userData!.height!) -
          (4.330 * _userData!.age!);
    }
  }

  // معرفة إذا كانت البيانات كاملة
  bool get isProfileComplete {
    return _userData != null &&
        _userData!.gender != null &&
        _userData!.age != null &&
        _userData!.weight != null &&
        _userData!.height != null;
  }
}
