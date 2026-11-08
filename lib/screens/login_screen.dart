import 'package:fitness_tracker/screens/gender_selection.dart';
import 'package:fitness_tracker/screens/register_screen.dart';
import 'package:flutter/material.dart'; // ← إضافة هذا الاستيراد
import 'package:fitness_tracker/utils/user_data_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  bool _checkingLogin = true; // ← إضافة متغير جديد

  void _login(BuildContext context) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorDialog('يرجى ملء جميع الحقول');
      return;
    }

    if (!email.contains('@')) {
      _showErrorDialog('يرجى إدخال بريد إلكتروني صحيح');
      return;
    }

    setState(() => _isLoading = true);

    // حفظ بيانات المستخدم
    await UserDataManager.saveUserName(name);
    await UserDataManager.saveUserEmail(email);

    // محاكاة انتظار قصير
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _isLoading = false);

    // ✅ التصحيح: الانتقال للصفحة الرئيسية وليس GenderSelection
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GenderSelectionScreen()),
    );
  }

  // ⚠️ تعديل دالة التحقق من تسجيل الدخول
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // انتظر قليلاً لتجنب مشاكل الـ context
    await Future.delayed(const Duration(milliseconds: 100));

    final hasName = await UserDataManager.getUserName();
    final hasAge = await UserDataManager.getUserAge();

    // ✅ الحالة 1: المستخدم أكمل التسجيل (له اسم وعمر)
    if (hasName != null && hasAge != null) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GenderSelectionScreen(),
            ),
          );
        }
      });
    }

    // ✅ الحالة 2: المستخدم لم يكمل التسجيل أو جديد
    // يبقى في شاشة تسجيل الدخول
    setState(() => _checkingLogin = false);
  }

  // ❌ إزالة الدالة القديمة التي تسبب المشكلة
  // Future<void> _checkIfUserLoggedIn() async {
  //   final isLoggedIn = await UserDataManager.isUserLoggedIn();
  //   if (isLoggedIn) {
  //     Future.delayed(Duration.zero, () {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const GenderSelectionScreen(), // ← هذا خطأ
  //         ),
  //       );
  //     });
  //   }
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خطأ في التسجيل'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // عرض شاشة تحميل أثناء التحقق من حالة المستخدم
    if (_checkingLogin) {
      return Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              Text(
                'جاري التحقق...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
              Colors.blue.shade500,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار التطبيق مع تأثيرات
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.9),
                          Colors.white.withOpacity(0.7),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.fitness_center,
                        size: 70,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // العنوان الرئيسي
                  Text(
                    'Fitness Tracker',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [Shadow(color: Colors.black26, blurRadius: 10)],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ابدأ رحلتك نحو صحة أفضل',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 40),

                  // بطاقة نموذج التسجيل
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        const SizedBox(height: 25),

                        // حقل الاسم
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'الاسم الكامل',
                            labelStyle: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.person,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.blue.shade700,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // حقل البريد الإلكتروني
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            labelStyle: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.email,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.blue.shade700,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // حقل كلمة المرور
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            labelStyle: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.lock,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.blue.shade700,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // زر تسجيل الدخول
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade900,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blue.shade900.withOpacity(
                                0.4,
                              ),
                            ),
                            onPressed: _isLoading
                                ? null
                                : () => _login(context),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.login, size: 24),
                                      SizedBox(width: 10),
                                      Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // زر للتسجيل كـ مستخدم جديد (بدون بيانات)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue.shade700),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              // تسجيل دخول بدون بيانات (لتجربة التطبيق)
                              _loginAsGuest();
                            },
                            child: Text(
                              'دخول كـ ضيف',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // رابط إنشاء حساب جديد
                        TextButton(
                          onPressed: () {
                            // الانتقال لصفحة التسجيل
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'ليس لديك حساب؟ إنشاء حساب جديد',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // معلومات إضافية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.white.withOpacity(0.7),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'بياناتك محمية بشكل آمن',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // دالة للدخول كـ ضيف
  Future<void> _loginAsGuest() async {
    setState(() => _isLoading = true);

    // استخدام اسم ضيف عشوائي
    final guestName = 'مستخدم ${DateTime.now().millisecond}';
    await UserDataManager.saveUserName(guestName);
    await UserDataManager.saveUserEmail('guest@example.com');
    await UserDataManager.saveUserAge(25); // عمر افتراضي

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GenderSelectionScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
