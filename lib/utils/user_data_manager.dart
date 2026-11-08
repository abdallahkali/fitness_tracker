import 'package:shared_preferences/shared_preferences.dart';

class UserDataManager {
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userWeightKey = 'user_weight';
  static const String _userHeightKey = 'user_height';
  static const String _userAgeKey = 'user_age';

  // دالة لحفظ اسم المستخدم
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  // دالة لاسترجاع اسم المستخدم
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // دالة لحفظ البريد الإلكتروني
  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, email);
  }

  // دالة لاسترجاع البريد الإلكتروني
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // دالة لحفظ الوزن
  static Future<void> saveUserWeight(double weight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_userWeightKey, weight);
  }

  // دالة لاسترجاع الوزن
  static Future<double?> getUserWeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_userWeightKey);
  }

  // دالة لحفظ الطول
  static Future<void> saveUserHeight(double height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_userHeightKey, height);
  }

  // دالة لاسترجاع الطول
  static Future<double?> getUserHeight() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_userHeightKey);
  }

  // دالة لحفظ العمر
  static Future<void> saveUserAge(int age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userAgeKey, age);
  }

  // دالة لاسترجاع العمر
  static Future<int?> getUserAge() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userAgeKey);
  }

  // دالة للتحقق إذا كان هناك مستخدم مسجل
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_userNameKey);
    return name != null && name.isNotEmpty;
  }

  // دالة لتسجيل الخروج (مسح جميع البيانات)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    // ملاحظة: يمكنك حذف أو الاحتفاظ بالبيانات الأخرى حسب احتياجك
  }

  static Future<void> saveBodyType(selectedBody) async {}
}
