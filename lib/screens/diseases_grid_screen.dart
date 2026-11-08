import 'package:flutter/material.dart';
import 'body_problems_screen.dart'; // استيراد الشاشة الرئيسية

class DiseasesGridScreen extends StatelessWidget {
  const DiseasesGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header مع زرين
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade600],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                // زر العودة
                Positioned(
                  left: 20,
                  top: 40,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // العنوان
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'الحالات الطبية',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'اختر الحالة الطبية المناسبة لك',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // زر التخطي للداشبورد
                Positioned(
                  right: 20,
                  top: 40,
                  child: TextButton(
                    onPressed: () {
                      // الانتقال المباشر للداشبورد
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BodyProblemsScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white.withOpacity(0.9),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Diseases Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // نص إرشادي
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'اختر الحالة الطبية التي تناسبك لعرض التمارين والنصائح المخصصة',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // الشبكة
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.9,
                      children: [
                        _SquareDiseaseCard(
                          disease: 'السكري',
                          icon: Icons.monitor_heart_outlined,
                          color: Colors.green,
                        ),
                        _SquareDiseaseCard(
                          disease: 'الضغط',
                          icon: Icons.favorite_outline,
                          color: Colors.red,
                        ),
                        _SquareDiseaseCard(
                          disease: 'هشاشة العظام',
                          icon: Icons.accessible_outlined,
                          color: Colors.orange,
                        ),
                        _SquareDiseaseCard(
                          disease: 'القلب',
                          icon: Icons.favorite_border,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // زر المتابعة للداشبورد
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // الانتقال للداشبورد بعد اختيار المرض
                _navigateToDashboard(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
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
                    'متابعة ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BodyProblemsScreen()),
    );
  }
}

class _SquareDiseaseCard extends StatelessWidget {
  final String disease;
  final IconData icon;
  final Color color;

  const _SquareDiseaseCard({
    required this.disease,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على الكارت
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiseaseDetailScreen(disease: disease),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 35, color: color),
            ),
            const SizedBox(height: 15),
            Text(
              disease,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'اضغط للتفاصيل',
                style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// صفحة تفاصيل المرض
class DiseaseDetailScreen extends StatelessWidget {
  final String disease;

  const DiseaseDetailScreen({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              // الانتقال للداشبورد من هنا أيضاً
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BodyProblemsScreen(),
                ),
              );
            },
            tooltip: 'الذهاب للمشاكل الجسدية',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // أيقونة المرض
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _getDiseaseColor(disease).withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getDiseaseColor(disease).withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                _getDiseaseIcon(disease),
                size: 50,
                color: _getDiseaseColor(disease),
              ),
            ),
            const SizedBox(height: 20),

            // عنوان
            Text(
              'معلومات عن $disease',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // معلومات المرض
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _getDiseaseColor(disease).withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: _getDiseaseColor(disease).withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getDiseaseDescription(disease),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // التمارين الموصى بها
                  const Text(
                    'التمارين الموصى بها:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._getRecommendedExercises(disease).map(
                    (exercise) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: _getDiseaseColor(disease),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(exercise, style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // أزرار
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('رجوع'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BodyProblemsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getDiseaseColor(disease),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('التالي'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // دالة للحصول على وصف المرض
  String _getDiseaseDescription(String disease) {
    switch (disease) {
      case 'السكري':
        return 'مرض السكري هو حالة مزمنة تؤثر على كيفية استخدام الجسم للسكر (الجلوكوز). هناك نوعان رئيسيان: النوع الأول والنوع الثاني. النظام الغذائي والتمارين المنظمة تلعب دوراً حيوياً في إدارة المرض.';
      case 'الضغط':
        return 'ارتفاع ضغط الدم هو حالة شائعة حيث تكون قوة الدم ضد جدران الشرايين مرتفعة بما يكفي لتسبب مشاكل صحية. يمكن السيطرة عليه من خلال تغييرات نمط الحياة والأدوية المناسبة.';
      case 'هشاشة العظام':
        return 'هشاشة العظام هي حالة تصبح فيها العظام ضعيفة وهشة، مما يزيد من خطر الكسور. التغذية السليمة والتمارين المناسبة تساعد في بناء والحفاظ على كثافة العظام.';
      case 'القلب':
        return 'أمراض القلب تشمل مجموعة من الحالات التي تؤثر على القلب والأوعية الدموية. تشمل أمراض الشريان التاجي، واضطرابات نظم القلب، وعيوب القلب الخلقية.';
      default:
        return 'معلومات عامة عن الحالة الطبية.';
    }
  }

  // دالة للحصول على التمارين الموصى بها
  List<String> _getRecommendedExercises(String disease) {
    switch (disease) {
      case 'السكري':
        return [
          'المشي السريع 30 دقيقة يومياً',
          'تمارين المقاومة الخفيفة',
          'اليوغا والتأمل',
          'السباحة',
        ];
      case 'الضغط':
        return [
          'المشي المعتدل',
          'تمارين الإطالة',
          'اليوغا العلاجية',
          'التأمل والتنفس العميق',
        ];
      case 'هشاشة العظام':
        return [
          'تمارين تحمل الوزن',
          'المشي',
          'تمارين التوازن',
          'تمارين القوة الخفيفة',
        ];
      case 'القلب':
        return [
          'المشي الخفيف',
          'تمارين التنفس',
          'اليوغا العلاجية',
          'تمارين خفيفة متدرجة',
        ];
      default:
        return ['تمارين عامة مناسبة لجميع الأعمار'];
    }
  }

  IconData _getDiseaseIcon(String disease) {
    switch (disease) {
      case 'السكري':
        return Icons.monitor_heart_outlined;
      case 'الضغط':
        return Icons.favorite_outline;
      case 'هشاشة العظام':
        return Icons.accessible_outlined;
      case 'القلب':
        return Icons.favorite_border;
      default:
        return Icons.medical_services;
    }
  }

  Color _getDiseaseColor(String disease) {
    switch (disease) {
      case 'السكري':
        return Colors.green;
      case 'الضغط':
        return Colors.red;
      case 'هشاشة العظام':
        return Colors.orange;
      case 'القلب':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
