import 'package:flutter/material.dart';
import 'package:fitness_tracker/screens/workouts/chest_workouts.dart';
import 'package:fitness_tracker/screens/workouts/legs_workouts.dart';
import 'package:fitness_tracker/screens/workouts/back_workouts.dart';
import 'package:fitness_tracker/screens/workouts/shoulders_workouts.dart';
import 'package:fitness_tracker/screens/workouts/arms_workouts.dart';
import 'package:fitness_tracker/screens/workouts/abs_workouts.dart';
import 'package:fitness_tracker/screens/body_problems_screen.dart'; // ✅ أضف هذا الاستيراد
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String? selectedProblem; // ✅ إضافة متغير للمشكلة المختارة

  const DashboardScreen({
    super.key,
    this.selectedProblem, // ✅ قبول المشكلة المختارة
  });

  // 6 أنواع رئيسية من التمارين
  final List<Map<String, dynamic>> muscleGroups = const [
    {
      "id": "chest",
      "name": "تمارين الصدر",
      "icon": Icons.fitness_center,
      "color": Colors.red,
      "description": "تقوية عضلات الصدر",
      "exerciseCount": 8,
    },
    {
      "id": "legs",
      "name": "تمارين الساقين",
      "icon": Icons.directions_run,
      "color": Colors.green,
      "description": "تقوية عضلات الأرجل",
      "exerciseCount": 10,
    },
    {
      "id": "back",
      "name": "تمارين الظهر",
      "icon": Icons.self_improvement,
      "color": Colors.blue,
      "description": "تقوية عضلات الظهر",
      "exerciseCount": 7,
    },
    {
      "id": "shoulders",
      "name": "تمارين الأكتاف",
      "icon": Icons.accessibility_new,
      "color": Colors.orange,
      "description": "تقوية عضلات الكتف",
      "exerciseCount": 6,
    },
    {
      "id": "arms",
      "name": "تمارين الذراعين",
      "icon": Icons.sports_handball,
      "color": Colors.purple,
      "description": "تقوية عضلات الذراع",
      "exerciseCount": 9,
    },
    {
      "id": "abs",
      "name": "تمارين البطن",
      "icon": Icons.sports_gymnastics,
      "color": Colors.teal,
      "description": "تقوية عضلات البطن",
      "exerciseCount": 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: _buildAppBarTitle(),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: _buildBackButton(context), // ✅ زر العودة
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ عرض المشكلة المختارة (إذا كانت موجودة)
            if (selectedProblem != null) _buildSelectedProblemCard(),

            const SizedBox(height: 15),

            // عنوان قسم التمارين
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedProblem != null
                        ? "تمارين لـ $selectedProblem" // ✅ عنوان مخصص
                        : "أنواع التمارين",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Chip(
                    label: const Text("6 مجموعات"),
                    backgroundColor: Colors.blue[100],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // شبكة أنواع التمارين
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85,
              ),
              itemCount: muscleGroups.length,
              itemBuilder: (context, index) {
                final group = muscleGroups[index];
                return _buildMuscleGroupCard(context, group);
              },
            ),

            const SizedBox(height: 25),

            // زر اختيار مشكلة جسم أخرى
            _buildChangeProblemButton(context),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ✅ بناء عنوان AppBar مع المشكلة المختارة
  Widget _buildAppBarTitle() {
    if (selectedProblem != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "لوحة التحكم",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            "لمشكلة: $selectedProblem",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
    } else {
      return const Text(
        "لوحة التحكم",
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
  }

  // ✅ زر العودة لصفحة مشاكل الجسم
  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BodyProblemsScreen()),
        );
      },
    );
  }

  // ✅ بطاقة عرض المشكلة المختارة
  Widget _buildSelectedProblemCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flag, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "المشكلة المختارة: $selectedProblem",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "سنركز على التمارين المناسبة لهذه المشكلة",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ زر لتغيير المشكلة المختارة
  Widget _buildChangeProblemButton(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BodyProblemsScreen()),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        ),
        icon: const Icon(Icons.change_circle, color: Colors.blue),
        label: const Text(
          "تغيير مشكلة الجسم",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }

  // بناء بطاقة مجموعة عضلية
  Widget _buildMuscleGroupCard(
    BuildContext context,
    Map<String, dynamic> group,
  ) {
    // ✅ تحديد إذا كانت المجموعة العضلية مرتبطة بالمشكلة المختارة
    bool isRelevant = _isRelevantToProblem(group['name'], selectedProblem);

    return GestureDetector(
      onTap: () {
        _navigateToWorkoutScreen(context, group['id']);
      },
      child: Card(
        elevation: isRelevant ? 5 : 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isRelevant
              ? BorderSide(color: Colors.blue, width: 2)
              : BorderSide.none,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                group['color'].withOpacity(isRelevant ? 1.0 : 0.8),
                group['color'].withOpacity(isRelevant ? 0.6 : 0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          group['icon'],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          group['description'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.list,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${group['exerciseCount']} تمرين",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ✅ علامة للمجموعات العضلية المناسبة للمشكلة
              if (isRelevant)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "مناسب",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  //  دالة للتحقق من علاقة المجموعة العضلية بالمشكلة المختارة
  bool _isRelevantToProblem(String muscleGroup, String? problem) {
    if (problem == null) return false;

    // العلاقات بين المشاكل والمجموعات العضلية
    final Map<String, List<String>> problemMuscleMap = {
      'ذراعين رفيعة': ['تمارين الذراعين', 'تمارين الأكتاف'],
      'ذراعين مترهلين': ['تمارين الذراعين', 'تمارين الصدر'],
      'أرجل ضعيفة': ['تمارين الساقين', 'تمارين الظهر'],
      'كرش': ['تمارين البطن', 'تمارين الظهر'],
      'صدر ضعيف': ['تمارين الصدر', 'تمارين الأكتاف'],
      'ظهر مترهل': ['تمارين الظهر', 'تمارين الساقين'],
      'أكتاف ضيقة': ['تمارين الأكتاف', 'تمارين الظهر'],
      'مؤخرة مسطحة': ['تمارين الساقين', 'تمارين الظهر'],
    };

    final relevantGroups = problemMuscleMap[problem] ?? [];
    return relevantGroups.contains(muscleGroup);
  }

  // دالة للانتقال لصفحة التمارين المناسبة
  void _navigateToWorkoutScreen(BuildContext context, String muscleGroupId) {
    switch (muscleGroupId) {
      case 'chest':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChestWorkoutsScreen()),
        );
        break;
      case 'legs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LegsWorkoutsScreen()),
        );
        break;
      case 'back':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BackWorkoutsScreen()),
        );
        break;
      case 'shoulders':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ShouldersWorkoutsScreen(),
          ),
        );
        break;
      case 'arms':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArmsWorkoutsScreen()),
        );
        break;
      case 'abs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AbsWorkoutsScreen()),
        );
        break;
    }
  }
}
