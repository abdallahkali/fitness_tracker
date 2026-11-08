import 'package:flutter/material.dart';
import 'diseases_grid_screen.dart'; // استيراد صفحة الأمراض
import 'package:fitness_tracker/utils/user_data_manager.dart';

class BodyTypeSelectionScreen extends StatefulWidget {
  const BodyTypeSelectionScreen({super.key});

  @override
  State<BodyTypeSelectionScreen> createState() =>
      _BodyTypeSelectionScreenState();
}

class _BodyTypeSelectionScreenState extends State<BodyTypeSelectionScreen> {
  int selectedIndex = -1;

  // ألوان خيالية بتدرجات حديثة
  final List<Color> bodyTypeColors = [
    const Color(0xFF6A11CB), // أرجواني ملكي
    const Color(0xFF2575FC), // أزرق سماوي
    const Color(0xFFF7971E), // برتقالي مشع
    const Color(0xFFFF416C), // وردي نيون
  ];

  final List<Gradient> selectedGradients = [
    const LinearGradient(
      colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xFF2575FC), Color(0xFF00B4DB)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  final List<Map<String, dynamic>> bodyTypes = [
    {
      "name": "نحيف",
      "image": "assets/1.jpg",
      "icon": Icons.airline_seat_individual_suite,
      "description": "مقاسات جسم رفيعة مع نسبة دهون منخفضة",
      "advantages": ["مرونة عالية", "سرعة في الحركة", "تحمل جيد"],
      "health_tips": ["ركز على بناء العضلات", "تناول وجبات غنية بالبروتين"],
    },
    {
      "name": "عضلي",
      "image": "assets/2.jpg",
      "icon": Icons.fitness_center,
      "description": "عضلات بارزة مع تعريف واضح",
      "advantages": ["قوة بدنية", "مظهر رياضي", "تمثيل غذائي سريع"],
      "health_tips": ["حافظ على مستوى البروتين", "ركز على التضخيم"],
    },
    {
      "name": "متوسط",
      "image": "assets/3.jpeg",
      "icon": Icons.person_outline,
      "description": "جسم متوازن بين العضلات والدهون",
      "advantages": ["تناسق جيد", "صحة مثالية", "توازن في القوة"],
      "health_tips": ["حافظ على التوازن", "جمع بين الكارديو والتمارين"],
    },
    {
      "name": "سمين",
      "image": "assets/4.jpg",
      "icon": Icons.spa,
      "description": "جسم ممتلئ مع مخازن طاقة عالية",
      "advantages": ["قوة تحمل", "طاقة عالية", "عظام قوية"],
      "health_tips": ["ركز على الكارديو", "تحكم في السعرات الحرارية"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // الهيدر مع تأثير شفاف
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "اختر شكل جسمك",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // نص إرشادي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "اختر الشكل الأقرب لجسمك لنساعدك في تحقيق أهدافك الصحية",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // شبكة اختيار الأشكال
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: bodyTypes.length,
                  itemBuilder: (context, index) {
                    final body = bodyTypes[index];
                    bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: isSelected
                              ? selectedGradients[index]
                              : LinearGradient(
                                  colors: [Colors.white, Colors.grey[100]!],
                                ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? bodyTypeColors[index].withOpacity(0.3)
                                  : Colors.grey.withOpacity(0.1),
                              blurRadius: isSelected ? 20 : 10,
                              spreadRadius: isSelected ? 2 : 1,
                              offset: Offset(0, isSelected ? 8 : 4),
                            ),
                          ],
                          border: Border.all(
                            color: isSelected
                                ? bodyTypeColors[index]
                                : Colors.transparent,
                            width: isSelected ? 2 : 0,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // صورة الجسم
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset(
                                  body['image']!,
                                  fit: BoxFit.cover,
                                  colorBlendMode: BlendMode.overlay,
                                  color: isSelected
                                      ? Colors.black.withOpacity(0.1)
                                      : Colors.transparent,
                                ),
                              ),
                            ),

                            // طبقة تدرج
                            if (isSelected)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                      colors: [
                                        bodyTypeColors[index].withOpacity(0.2),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),

                            // محتوى البطاقة
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // أيقونة
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      body['icon'],
                                      color: bodyTypeColors[index],
                                      size: 24,
                                    ),
                                  ),

                                  const Spacer(),

                                  // الاسم
                                  Text(
                                    body['name']!,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      shadows: isSelected
                                          ? [
                                              Shadow(
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                blurRadius: 4,
                                              ),
                                            ]
                                          : null,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // الوصف
                                  Text(
                                    body['description'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 12),

                                  // مؤشر الاختيار
                                  if (isSelected)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'مختار',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // زر التالي ومعلومات إضافية
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedIndex != -1
                  ? _buildSelectedBodyInfo()
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "اختر شكل جسمك للاستمرار",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedBodyInfo() {
    final body = bodyTypes[selectedIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          // معلومات الجسم المختار
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bodyTypeColors[selectedIndex].withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: bodyTypeColors[selectedIndex].withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: bodyTypeColors[selectedIndex],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'معلومات عن ${body['name']}:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: bodyTypeColors[selectedIndex],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // المميزات
                Text(
                  'المميزات:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: bodyTypeColors[selectedIndex].withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    body['advantages'].length,
                    (index) => Chip(
                      label: Text(
                        body['advantages'][index],
                        style: TextStyle(
                          fontSize: 12,
                          color: bodyTypeColors[selectedIndex],
                        ),
                      ),
                      backgroundColor: bodyTypeColors[selectedIndex]
                          .withOpacity(0.1),
                      side: BorderSide(
                        color: bodyTypeColors[selectedIndex].withOpacity(0.3),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // نصائح صحية
                Text(
                  'نصائح لك:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: bodyTypeColors[selectedIndex].withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  body['health_tips'].length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: bodyTypeColors[selectedIndex],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            body['health_tips'][index],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // زر المتابعة للأمراض
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _goToDiseasesScreen(),
              style: ElevatedButton.styleFrom(
                backgroundColor: bodyTypeColors[selectedIndex],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: bodyTypeColors[selectedIndex].withOpacity(0.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "متابعة  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.medical_services, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToDiseasesScreen() async {
    // حفظ نوع الجسم في SharedPreferences
    final selectedBody = bodyTypes[selectedIndex];
    await UserDataManager.saveBodyType(selectedBody['name']);

    // الانتقال لصفحة الأمراض
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const DiseasesGridScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  ),
                ),
            child: child,
          );
        },
      ),
    );
  }
}
