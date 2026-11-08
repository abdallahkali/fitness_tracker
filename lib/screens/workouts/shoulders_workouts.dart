import 'package:flutter/material.dart';

class ShouldersWorkoutsScreen extends StatefulWidget {
  const ShouldersWorkoutsScreen({super.key});

  @override
  State<ShouldersWorkoutsScreen> createState() =>
      _ShouldersWorkoutsScreenState();
}

class _ShouldersWorkoutsScreenState extends State<ShouldersWorkoutsScreen> {
  final List<Map<String, dynamic>> shoulderExercises = [
    {
      'id': 1,
      'name': 'رفع جانبي دمبل (Dumbbell Lateral Raise)',
      'description': 'لتوسيع الأكتاف وتحسين العرض',
      'sets': 4,
      'reps': '12-15',
      'rest': '60s',
      'muscle': 'جانبي',
      'difficulty': 'متوسط',
      'icon': Icons.open_with,
      'color': Colors.deepOrange,
      'tips': [
        'حافظ على مرفقيك مثنيين قليلاً',
        'تجنب استخدام الزخم',
        'أعد الأوزان ببطء للأسفل',
      ],
    },
    {
      'id': 2,
      'name': 'ضغط كتف بالدمبل (Dumbbell Shoulder Press)',
      'description': 'لتضخيم الكتف الأمامي والقوة',
      'sets': 4,
      'reps': '8-12',
      'rest': '90s',
      'muscle': 'أمامي',
      'difficulty': 'متقدم',
      'icon': Icons.arrow_upward,
      'color': Colors.orange,
      'tips': [
        'لا تفرط في مد الذراعين',
        'حافظ على الظهر مستقيماً',
        'تجنب إرجاع الرأس للخلف',
      ],
    },
    {
      'id': 3,
      'name': 'رفع أمامي (Front Raise)',
      'description': 'لعزل الكتف الأمامي وتفصيله',
      'sets': 3,
      'reps': '10-12',
      'rest': '60s',
      'muscle': 'أمامي',
      'difficulty': 'مبتدئ',
      'icon': Icons.arrow_forward,
      'color': Colors.amber,
      'tips': [
        'ارفع حتى مستوى الكتف',
        'تحكم في الحركة للأسفل',
        'استخدم أوزاناً مناسبة',
      ],
    },
    {
      'id': 4,
      'name': 'رفع خلفي (Rear Delt Fly)',
      'description': 'لتقوية الكتف الخلفي والتوازن',
      'sets': 4,
      'reps': '12-15',
      'rest': '60s',
      'muscle': 'خلفي',
      'difficulty': 'متوسط',
      'icon': Icons.arrow_back,
      'color': Colors.deepOrange[800]!,
      'tips': [
        'اثنِ جذعك للأمام',
        'ارفع الأثقال للخارج',
        'حافظ على استقرار الظهر',
      ],
    },
    {
      'id': 5,
      'name': 'رفع بار للأعلى (Barbell Upright Row)',
      'description': 'لتضخيم الكتف العلوي والعضلة شبه المنحرفة',
      'sets': 3,
      'reps': '8-10',
      'rest': '75s',
      'muscle': 'علوي',
      'difficulty': 'متوسط',
      'icon': Icons.trending_up,
      'color': Colors.orange[600]!,
      'tips': [
        'ارفع البار لأعلى الصدر',
        'تجنب رفع المرفقين عالياً',
        'حافظ على قبضة ضيقة',
      ],
    },
    {
      'id': 6,
      'name': 'رفع كتف بالآلة (Machine Shoulder Press)',
      'description': 'للتضخيم مع الأمان والتحكم',
      'sets': 4,
      'reps': '10-12',
      'rest': '75s',
      'muscle': 'أمامي',
      'difficulty': 'مبتدئ',
      'icon': Icons.settings,
      'color': Colors.orange[400]!,
      'tips': [
        'ضبط المقعد للارتفاع المناسب',
        'تحكم في الحركة الكاملة',
        'تجنب القفل الكامل للمرفقين',
      ],
    },
    {
      'id': 7,
      'name': 'رفع كابل جانبي (Cable Lateral Raise)',
      'description': 'لتوتر مستمر وتفصيل جانبي',
      'sets': 3,
      'reps': '15-20',
      'rest': '45s',
      'muscle': 'جانبي',
      'difficulty': 'متقدم',
      'icon': Icons.cable,
      'color': Colors.deepOrange[300]!,
      'tips': [
        'استخدم الكابل للتوتر المستمر',
        'تحكم في الحركة في كلا الاتجاهين',
        'ركز على الانقباض',
      ],
    },
  ];

  int _currentExercise = 0;
  // ignore: unused_field
  final Map<String, Color> _muscleColors = {
    'أمامي': Colors.orange,
    'جانبي': Colors.deepOrange,
    'خلفي': Colors.deepOrange[800]!,
    'علوي': Colors.orange[600]!,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تمارين الأكتاف المتقدمة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[700],
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.sports), onPressed: () {})],
      ),
      body: Row(
        children: [
          // قائمة التمارين الجانبية
          Container(
            width: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange[50]!, Colors.orange[100]!],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange[700]!, Colors.orange[600]!],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.list, color: Colors.white, size: 24),
                      const SizedBox(width: 10),
                      const Text(
                        'تمارين الأكتاف',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${shoulderExercises.length} تمرين',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: shoulderExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = shoulderExercises[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() => _currentExercise = index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _currentExercise == index
                                  ? [
                                      exercise['color'],
                                      exercise['color'].withOpacity(0.7),
                                    ]
                                  : [Colors.white, Colors.orange[50]!],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: _currentExercise == index
                                ? [
                                    BoxShadow(
                                      color: exercise['color'].withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                            border: Border.all(
                              color: _currentExercise == index
                                  ? exercise['color']
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _currentExercise == index
                                      ? Colors.white
                                      : exercise['color'].withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  exercise['icon'],
                                  color: _currentExercise == index
                                      ? exercise['color']
                                      : exercise['color'].withOpacity(0.7),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise['name'].split(' ')[0],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: _currentExercise == index
                                            ? Colors.white
                                            : Colors.grey[800],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _currentExercise == index
                                                ? Colors.white.withOpacity(0.2)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            '${exercise['sets']} مجموعات',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: _currentExercise == index
                                                  ? Colors.white
                                                  : exercise['color'],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _currentExercise == index
                                                ? Colors.white.withOpacity(0.2)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            exercise['difficulty'],
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: _currentExercise == index
                                                  ? Colors.white
                                                  : exercise['color'],
                                              fontWeight: FontWeight.bold,
                                            ),
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // المنطقة الرئيسية للتفاصيل
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[50]!, Colors.grey[100]!],
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // رأس التمرين الحالي
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            shoulderExercises[_currentExercise]['color']
                                .withOpacity(0.9),
                            shoulderExercises[_currentExercise]['color']
                                .withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: shoulderExercises[_currentExercise]['color']
                                .withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              shoulderExercises[_currentExercise]['icon'],
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shoulderExercises[_currentExercise]['name'],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  shoulderExercises[_currentExercise]['description'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              shoulderExercises[_currentExercise]['muscle'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // معلومات التمرين
                    const Text(
                      'معلومات التمرين',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 20),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _buildInfoCard(
                          Icons.format_list_numbered,
                          'المجموعات',
                          '${shoulderExercises[_currentExercise]['sets']}',
                          Colors.orange,
                        ),
                        _buildInfoCard(
                          Icons.repeat,
                          'التكرارات',
                          shoulderExercises[_currentExercise]['reps'],
                          Colors.deepOrange,
                        ),
                        _buildInfoCard(
                          Icons.timer,
                          'وقت الراحة',
                          shoulderExercises[_currentExercise]['rest'],
                          Colors.amber,
                        ),
                        _buildInfoCard(
                          Icons.speed,
                          'الصعوبة',
                          shoulderExercises[_currentExercise]['difficulty'],
                          Colors.orange[800]!,
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // نصائح الأداء
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.orange[50]!, Colors.amber[50]!],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.orange[200]!,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.tips_and_updates,
                                color: Colors.orange,
                                size: 24,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'نصائح الأداء',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                shoulderExercises[_currentExercise]['tips']
                                    .map<Widget>(
                                      (tip) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 8,
                                              margin: const EdgeInsets.only(
                                                top: 6,
                                                right: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                tip,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // عضلات الكتف
                    const Text(
                      'عضلات الكتف المستهدفة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMuscleCard(
                                'أمامي',
                                Icons.arrow_forward,
                                Colors.orange,
                              ),
                              _buildMuscleCard(
                                'جانبي',
                                Icons.open_with,
                                Colors.deepOrange,
                              ),
                              _buildMuscleCard(
                                'خلفي',
                                Icons.arrow_back,
                                Colors.orange[800]!,
                              ),
                              _buildMuscleCard(
                                'علوي',
                                Icons.trending_up,
                                Colors.orange[600]!,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          LinearProgressIndicator(
                            value:
                                shoulderExercises[_currentExercise]['sets'] /
                                5.0,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              shoulderExercises[_currentExercise]['color'],
                            ),
                            minHeight: 12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'مستوى الشدة: ${shoulderExercises[_currentExercise]['difficulty']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${shoulderExercises[_currentExercise]['sets']}/5',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // أزرار التنقل
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_currentExercise > 0) {
                              setState(() => _currentExercise--);
                            }
                          },
                          icon: const Icon(Icons.navigate_before),
                          label: const Text('السابق'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'تمرين ${_currentExercise + 1} من ${shoulderExercises.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_currentExercise <
                                shoulderExercises.length - 1) {
                              setState(() => _currentExercise++);
                            }
                          },
                          icon: const Icon(Icons.navigate_next),
                          label: const Text('التالي'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleCard(String muscle, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          muscle,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
