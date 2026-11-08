import 'package:flutter/material.dart';
import 'package:fitness_tracker/screens/calorie_calculator.dart';
import 'package:fitness_tracker/utils/user_data_manager.dart'; // استيراد الملف الجديد

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ignore: prefer_final_fields
  int _activeDays = 24;
  // ignore: prefer_final_fields
  int _totalWorkouts = 45;
  double _weight = 65.0;
  double _height = 170.0;
  int _age = 25;
  // ignore: prefer_final_fields
  double _caloriesBurned = 1800.0;
  String _userName = "المستخدم"; // قيمة افتراضية
  String _userEmail = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // دالة لتحميل بيانات المستخدم من SharedPreferences
  Future<void> _loadUserData() async {
    final userName = await UserDataManager.getUserName();
    final userEmail = await UserDataManager.getUserEmail();
    final userWeight = await UserDataManager.getUserWeight();
    final userHeight = await UserDataManager.getUserHeight();
    final userAge = await UserDataManager.getUserAge();

    setState(() {
      _userName = userName ?? "المستخدم";
      _userEmail = userEmail ?? "";
      _weight = userWeight ?? 65.0;
      _height = userHeight ?? 170.0;
      _age = userAge ?? 25;
    });
  }

  // دالة لحفظ التعديلات
  Future<void> _saveUserData() async {
    await UserDataManager.saveUserWeight(_weight);
    await UserDataManager.saveUserHeight(_height);
    await UserDataManager.saveUserAge(_age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange.shade900,
              Colors.orange.shade700,
              Colors.orange.shade500,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // AppBar قابل للسحب
            SliverAppBar(
              expandedHeight: 250,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange.shade900.withOpacity(0.8),
                        Colors.orange.shade700.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -50,
                        top: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: -30,
                        bottom: -30,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // صورة البروفايل مع تأثير
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.orange.shade100,
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepOrange.withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.deepOrange,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _userName, // عرض الاسم المسترجع من الدالة
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(color: Colors.black26, blurRadius: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  _userEmail.isNotEmpty
                                      ? _userEmail
                                      : 'مستخدم نشط',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // محتوى البروفايل
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // إحصائيات المستخدم
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatCard(
                            icon: Icons.calendar_today,
                            value: '$_activeDays يوم',
                            title: 'نشط',
                            color: Colors.green,
                          ),
                          _StatCard(
                            icon: Icons.fitness_center,
                            value: '$_totalWorkouts',
                            title: 'تمارين',
                            color: Colors.blue,
                          ),
                          _StatCard(
                            icon: Icons.local_fire_department,
                            value: '${_caloriesBurned.toInt()} كالوري',
                            title: 'محروقة',
                            color: Colors.deepOrange,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // المعلومات الشخصية
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'المعلومات الشخصية',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _PersonalInfoItem(
                            icon: Icons.monitor_weight,
                            label: 'الوزن',
                            value: '$_weight كجم',
                            color: Colors.deepOrange,
                            onEdit: () => _editValue('الوزن', _weight),
                          ),
                          _PersonalInfoItem(
                            icon: Icons.height,
                            label: 'الطول',
                            value: '$_height سم',
                            color: Colors.orange,
                            onEdit: () => _editValue('الطول', _height),
                          ),
                          _PersonalInfoItem(
                            icon: Icons.cake,
                            label: 'العمر',
                            value: '$_age سنة',
                            color: Colors.amber,
                            onEdit: () => _editValue('العمر', _age.toDouble()),
                          ),
                          if (_userEmail.isNotEmpty) ...[
                            const SizedBox(height: 15),
                            _PersonalInfoItem(
                              icon: Icons.email,
                              label: 'البريد الإلكتروني',
                              value: _userEmail,
                              color: Colors.blue,
                              onEdit: null, // لا يمكن تعديل البريد
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // إحصائيات التقدم
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.trending_up, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'إحصائيات التقدم',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _ProgressCard(
                            label: 'قوة العضلات',
                            progress: 0.75,
                            color: Colors.green,
                            icon: Icons.fitness_center,
                          ),
                          const SizedBox(height: 15),
                          _ProgressCard(
                            label: 'التحمل',
                            progress: 0.65,
                            color: Colors.blue,
                            icon: Icons.directions_run,
                          ),
                          const SizedBox(height: 15),
                          _ProgressCard(
                            label: 'المرونة',
                            progress: 0.45,
                            color: Colors.purple,
                            icon: Icons.open_with,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // قائمة الخيارات السريعة
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _QuickActionCard(
                          icon: Icons.calculate,
                          title: 'حاسبة السعرات',
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CalorieCalculatorScreen(),
                              ),
                            );
                          },
                        ),
                        _QuickActionCard(
                          icon: Icons.settings,
                          title: 'الإعدادات',
                          color: Colors.blue,
                          onTap: () {
                            // شاشة الإعدادات
                          },
                        ),
                        _QuickActionCard(
                          icon: Icons.share,
                          title: 'مشاركة التقدم',
                          color: Colors.purple,
                          onTap: () {
                            // مشاركة التقدم
                          },
                        ),
                        _QuickActionCard(
                          icon: Icons.logout,
                          title: 'تسجيل الخروج',
                          color: Colors.red,
                          onTap: () => _showLogoutDialog(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // بطاقة الإنجازات
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepOrange.withOpacity(0.8),
                            Colors.orange.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '🏆 الإنجازات',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _AchievementItem(
                                icon: Icons.star,
                                title: 'الأسبوع النشط',
                                achieved: true,
                              ),
                              _AchievementItem(
                                icon: Icons.emoji_events,
                                title: 'الماراثون الأول',
                                achieved: true,
                              ),
                              _AchievementItem(
                                icon: Icons.local_fire_department,
                                title: '10K كالوري',
                                achieved: false,
                              ),
                              _AchievementItem(
                                icon: Icons.flag,
                                title: '30 يوم',
                                achieved: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editValue(String field, double currentValue) async {
    TextEditingController controller = TextEditingController(
      text: currentValue.toStringAsFixed(1),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل $field'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'أدخل قيمة جديدة لـ $field',
            suffixText: field == 'الوزن'
                ? 'كجم'
                : field == 'الطول'
                ? 'سم'
                : 'سنة',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final newValue = double.tryParse(controller.text);
              if (newValue != null && newValue > 0) {
                setState(() {
                  if (field == 'الوزن') {
                    _weight = newValue;
                  } else if (field == 'الطول') {
                    _height = newValue;
                  } else if (field == 'العمر') {
                    _age = newValue.toInt();
                  }
                });
                _saveUserData(); // حفظ التعديلات
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text('تسجيل الخروج'),
          ],
        ),
        content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              // استدعاء دالة تسجيل الخروج من UserDataManager
              await UserDataManager.logout();
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}

// باقي الـ Widgets المساعدة تبقى كما هي بدون تغيير...

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}

class _PersonalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onEdit;

  const _PersonalInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, color: Colors.deepOrange, size: 20),
            ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;
  final IconData icon;

  const _ProgressCard({
    required this.label,
    required this.progress,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool achieved;

  const _AchievementItem({
    required this.icon,
    required this.title,
    required this.achieved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: achieved
                ? Colors.white.withOpacity(0.9)
                : Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: achieved ? Colors.deepOrange : Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: achieved ? Colors.white : Colors.white.withOpacity(0.7),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
