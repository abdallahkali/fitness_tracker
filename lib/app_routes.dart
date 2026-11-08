// lib/app_routes.dart
// ignore_for_file: unused_import

import 'package:fitness_tracker/screens/login_screen.dart';
import 'package:fitness_tracker/screens/register_screen.dart';
import 'package:flutter/material.dart';

// استيراد الصفحات
import 'screens/dashboard_screen.dart';
import 'screens/profile_screen.dart';

// الصفحات التي تعمل بدون parameters
// ignore: duplicate_ignore
// ignore: unused_import
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

class AppRoutes {
  // أسماء المسارات
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String ageSelection = '/age-selection';
  static const String bodyTypeSelection = '/body-type-selection';

  // قائمة المسارات (فقط الصفحات التي تعمل بدون parameters)
  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    dashboard: (context) => const DashboardScreen(selectedProblem: ''),
    profile: (context) => const ProfileScreen(),
    // سنتعامل مع الصفحات التي تحتاج parameters بشكل منفصل
  };

  // دوال خاصة للصفحات التي تحتاج parameters
  static WidgetBuilder ageSelectionBuilder({String? userId, String? userName}) {
    return (context) => AgeSelection(
      userId: userId ?? 'default',
      userName: userName ?? 'مستخدم',
    );
  }

  static WidgetBuilder bodyTypeSelectionBuilder({
    required Function(String) onSelected,
  }) {
    return (context) => BodyTypeSelection(onSelected: onSelected);
  }

  // دوال مساعدة للتنقل
  static Future<T?> push<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<T?> pushReplacement<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushAgeSelection<T>(
    BuildContext context,
    String userId,
    String userName,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgeSelection(userId: userId, userName: userName),
      ),
    );
  }

  static Future<T?> pushBodyTypeSelection<T>(
    BuildContext context,
    Function(String) onSelected,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodyTypeSelection(onSelected: onSelected),
      ),
    );
  }

  static void pop(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      predicate,
      arguments: arguments,
    );
  }
}

// أنشئ تعريفات بسيطة للصفحات المفقودة
class AgeSelection extends StatefulWidget {
  const AgeSelection({
    super.key,
    this.userId = 'default',
    this.userName = 'مستخدم',
  });

  final String userId;
  final String userName;

  @override
  State<AgeSelection> createState() => _AgeSelectionState();
}

class _AgeSelectionState extends State<AgeSelection> {
  int _age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختيار العمر')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('اختر عمرك:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(
              '$_age سنة',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Slider(
              value: _age.toDouble(),
              min: 10,
              max: 80,
              onChanged: (value) {
                setState(() => _age = value.round());
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                AppRoutes.pop(context);
              },
              child: const Text('حفظ والعودة'),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyTypeSelection extends StatefulWidget {
  const BodyTypeSelection({super.key, required this.onSelected});

  final Function(String) onSelected;

  @override
  State<BodyTypeSelection> createState() => _BodyTypeSelectionState();
}

class _BodyTypeSelectionState extends State<BodyTypeSelection> {
  String _selectedType = 'متوسط';

  final List<String> bodyTypes = ['نحيف', 'عضلي', 'متوسط', 'سمين'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختيار نوع الجسم')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bodyTypes.length,
        itemBuilder: (context, index) {
          final type = bodyTypes[index];
          return Card(
            color: _selectedType == type ? Colors.blue[50] : null,
            child: ListTile(
              title: Text(type),
              trailing: _selectedType == type
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() => _selectedType = type);
                widget.onSelected(type);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onSelected(_selectedType);
          AppRoutes.pop(context);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
