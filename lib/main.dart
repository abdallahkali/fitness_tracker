// ignore: unused_import
import 'package:fitness_tracker/screens/gender_selection.dart';
import 'package:fitness_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker/utils/app_language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل اللغة المخزنة عند بدء التطبيق
  await AppLanguage.loadLanguage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: AppLanguage.isEnglish ? 'Roboto' : 'Tajawal',
      ),
      home: LoginScreen(),
    );
  }
}
