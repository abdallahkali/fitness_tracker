// ملف إدارة اللغة
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  static bool _isEnglish = false;

  static bool get isEnglish => _isEnglish;

  // دالة لتحميل اللغة عند بدء التطبيق
  static Future<void> loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isEnglish = prefs.getBool('isEnglish') ?? false;
    } catch (e) {
      // ignore: avoid_print
      print('Error loading language: $e');
      _isEnglish = false; // القيمة الافتراضية: العربية
    }
  }

  // دالة لحفظ اللغة
  static Future<void> saveLanguage(bool isEnglish) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isEnglish', isEnglish);
      _isEnglish = isEnglish;
    } catch (e) {
      // ignore: avoid_print
      print('Error saving language: $e');
    }
  }

  // دالة للترجمة
  static String tr(String arabic, String english) {
    return _isEnglish ? english : arabic;
  }

  // دالة للحصول على اتجاه النص
  static bool get isRTL => !_isEnglish;
}
