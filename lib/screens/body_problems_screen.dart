import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // استيراد الداشبورد

class BodyProblemsScreen extends StatelessWidget {
  const BodyProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade700,
              Colors.deepPurple.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header مع زر تخطي
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'مشاكل الجسم الشائعة',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // زر تخطي للداشبورد
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DashboardScreen(selectedProblem: ''),
                          ),
                        );
                      },
                      child: const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              // Subtitle
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                color: Colors.black.withOpacity(0.1),
                child: const Center(
                  child: Text(
                    'اختر المشكلة التي ترغب في تحسينها',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Body Problems Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.9,
                    children: [
                      _BodyProblemCard(
                        problem: 'ذراعين رفيعة',
                        description: 'تقوية وبناء العضلات',
                        icon: Icons.accessibility_new,
                        color: Colors.blue,
                        gradientColors: [
                          Colors.blue.shade600,
                          Colors.blue.shade400,
                        ],
                        exerciseCount: 8,
                      ),
                      _BodyProblemCard(
                        problem: 'أرجل ضعيفة',
                        description: 'تقوية الأرجل والساقين',
                        icon: Icons.directions_run,
                        color: Colors.green,
                        gradientColors: [
                          Colors.green.shade600,
                          Colors.green.shade400,
                        ],
                        exerciseCount: 10,
                      ),
                      _BodyProblemCard(
                        problem: 'كرش',
                        description: 'تنحيف منطقة البطن',
                        icon: Icons.spa,
                        color: Colors.orange,
                        gradientColors: [
                          Colors.orange.shade600,
                          Colors.orange.shade400,
                        ],
                        exerciseCount: 12,
                      ),
                      _BodyProblemCard(
                        problem: 'صدر ضعيف',
                        description: 'تقوية عضلات الصدر',
                        icon: Icons.fitness_center,
                        color: Colors.red,
                        gradientColors: [
                          Colors.red.shade600,
                          Colors.red.shade400,
                        ],
                        exerciseCount: 9,
                      ),
                      _BodyProblemCard(
                        problem: 'ظهر مترهل',
                        description: 'تقوية عضلات الظهر',
                        icon: Icons.arrow_upward,
                        color: Colors.purple,
                        gradientColors: [
                          Colors.purple.shade600,
                          Colors.purple.shade400,
                        ],
                        exerciseCount: 7,
                      ),
                      _BodyProblemCard(
                        problem: 'أكتاف ضيقة',
                        description: 'توسيع وبناء الأكتاف',
                        icon: Icons.open_with,
                        color: Colors.teal,
                        gradientColors: [
                          Colors.teal.shade600,
                          Colors.teal.shade400,
                        ],
                        exerciseCount: 6,
                      ),
                      _BodyProblemCard(
                        problem: 'مؤخرة مسطحة',
                        description: 'بناء عضلات الأرداف',
                        icon: Icons.water_damage,
                        color: Colors.pink,
                        gradientColors: [
                          Colors.pink.shade600,
                          Colors.pink.shade400,
                        ],
                        exerciseCount: 11,
                      ),
                      _BodyProblemCard(
                        problem: 'ذراعين مترهلين',
                        description: 'شد وتقوية الذراعين',
                        icon: Icons.waves,
                        color: Colors.amber,
                        gradientColors: [
                          Colors.amber.shade600,
                          Colors.amber.shade400,
                        ],
                        exerciseCount: 8,
                      ),
                    ],
                  ),
                ),
              ),

              // زر الانتقال للداشبورد
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DashboardScreen(selectedProblem: ''),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dashboard, size: 22),
                      SizedBox(width: 10),
                      Text(
                        'متابعة للداشبورد',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// كارت مشكلة الجسم مع إضافة OnTap
class _BodyProblemCard extends StatelessWidget {
  final String problem;
  final String description;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;
  final int exerciseCount;

  const _BodyProblemCard({
    required this.problem,
    required this.description,
    required this.icon,
    required this.color,
    required this.gradientColors,
    required this.exerciseCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على الكارت، انتقل للداشبورد مع المشكلة المختارة
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(selectedProblem: problem),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // تأثيرات خلفية
              Positioned(
                top: -15,
                right: -15,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                left: -10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // محتوى الكارت
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // الأيقونة
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 26),
                    ),

                    // المشكلة والوصف
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          problem,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),

                    // عدد التمارين مع أيقونة السهم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.fitness_center,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '$exerciseCount تمرين',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.7),
                          size: 16,
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
    );
  }
}
