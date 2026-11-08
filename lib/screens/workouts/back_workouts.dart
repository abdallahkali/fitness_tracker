import 'package:flutter/material.dart';

class BackWorkoutsScreen extends StatefulWidget {
  const BackWorkoutsScreen({super.key});

  @override
  State<BackWorkoutsScreen> createState() => _BackWorkoutsScreenState();
}

class _BackWorkoutsScreenState extends State<BackWorkoutsScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> backExercises = [
    {
      'id': 1,
      'name': 'سحب أمامي واسع',
      'description': 'تمارين متقدمة لتوسيع الظهر العلوي',
      'sets': 4,
      'reps': '8-12',
      'rest': '90s',
      'difficulty': 'متقدم',
      'grip': 'واسع',
      'icon': Icons.zoom_out_map,
      'color': Colors.blueAccent,
      'muscles': ['الظهر العلوي', 'اللاتس'],
      'tips': 'شد الكتفين للأسفل والخلف، حافظ على صدر مرفوع',
    },
    {
      'id': 2,
      'name': 'ديدلفت تقليدي',
      'description': 'ملك التمارين لتضخيم كامل الظهر',
      'sets': 3,
      'reps': '5-8',
      'rest': '180s',
      'difficulty': 'متقدم',
      'grip': 'مختلط',
      'icon': Icons.fitness_center,
      'color': Colors.deepPurple,
      'muscles': ['الظهر الكامل', 'الألوية'],
      'tips': 'حافظ على ظهر مستقيم، ابدأ من الركبتين',
    },
    {
      'id': 3,
      'name': 'سحب آلة',
      'description': 'أساسي لتضخيم العضلة الظهرية',
      'sets': 4,
      'reps': '10-15',
      'rest': '75s',
      'difficulty': 'مبتدئ',
      'grip': 'متوسط',
      'icon': Icons.arrow_downward,
      'color': Colors.teal,
      'muscles': ['اللاتس', 'الظهر الأوسط'],
      'tips': 'اسحب المقبض نحو الصدر، تجنب استخدام الزخم',
    },
    {
      'id': 4,
      'name': 'صف دمبل على بنش',
      'description': 'لعزل وتطوير كل جانب بشكل منفصل',
      'sets': 4,
      'reps': '10-12',
      'rest': '60s',
      'difficulty': 'متوسط',
      'grip': 'محايد',
      'icon': Icons.compare_arrows,
      'color': Colors.orange,
      'muscles': ['الظهر الأوسط', 'الرومبويد'],
      'tips': 'حافظ على استقامة الظهر، شد الشفرات معاً',
    },
    {
      'id': 5,
      'name': 'سحب خلفي رقبة',
      'description': 'لتطوير عرض وتفصيل الظهر العلوي',
      'sets': 3,
      'reps': '10-12',
      'rest': '75s',
      'difficulty': 'متقدم',
      'grip': 'واسع',
      'icon': Icons.arrow_back,
      'color': Colors.indigo,
      'muscles': ['الظهر العلوي', 'الترابيس'],
      'tips': 'للمتقدمين فقط، تجنب ثني الرقبة للأمام',
    },
    {
      'id': 6,
      'name': 'شك دمبل بيد واحدة',
      'description': 'لتصحيح عدم التوازن بين الجانبين',
      'sets': 3,
      'reps': '8-10 كل ذراع',
      'rest': '60s',
      'difficulty': 'متوسط',
      'grip': 'محايد',
      'icon': Icons.line_weight,
      'color': Colors.green,
      'muscles': ['اللاتس', 'الظهر الأوسط'],
      'tips': 'ثبت الجسم على الركبة واليد، حافظ على الثبات',
    },
    {
      'id': 7,
      'name': 'سحب وجه',
      'description': 'لتقوية وتدوير الكتفين للخلف',
      'sets': 4,
      'reps': '15-20',
      'rest': '45s',
      'difficulty': 'مبتدئ',
      'grip': 'ضيق',
      'icon': Icons.arrow_upward,
      'color': Colors.redAccent,
      'muscles': ['الظهر الخلفي', 'الترابيس'],
      'tips': 'اسحب نحو الوجه، قسم الحبل إلى جانبين',
    },
    {
      'id': 8,
      'name': 'جسر أرضي',
      'description': 'للتضخيم مع تعزيز الاستقرار الأساسي',
      'sets': 3,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'متوسط',
      'grip': 'محايد',
      'icon': Icons.horizontal_rule,
      'color': Colors.blueGrey,
      'muscles': ['الظهر السفلي', 'المؤخرة'],
      'tips': 'حافظ على الجسم مستقيم، تجنب هبوط الوركين',
    },
  ];

  int _currentExercise = 0;
  bool _showFormTips = true;
  int _timerSeconds = 90;
  bool _isTimerRunning = false;
  int _setsCompleted = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    // تعيين وقت الراحة الأولي
    final restTime =
        int.tryParse(
          backExercises[_currentExercise]['rest'].replaceAll('s', ''),
        ) ??
        90;
    _timerSeconds = restTime;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = backExercises[_currentExercise];
    final totalExercises = backExercises.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // AppBar قابل للتمدد
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blue[800],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[900]!, Colors.blue[700]!],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: _animation,
                        child: Row(
                          children: [
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
                                'تمارين الظهر',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                'تمرين ${_currentExercise + 1}/$totalExercises',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        exercise['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        exercise['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              title: Text(
                exercise['name'].split(' ').take(2).join(' '),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),

          // المحتوى الرئيسي
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // بطاقة المعلومات الرئيسية
                  FadeTransition(
                    opacity: _animation,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blue[50]!, Colors.lightBlue[50]!],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // معلومات سريعة
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildInfoCard(
                                  'المجموعات',
                                  '${exercise['sets']}',
                                  Icons.format_list_numbered,
                                  Colors.blue,
                                ),
                                _buildInfoCard(
                                  'التكرارات',
                                  exercise['reps'],
                                  Icons.repeat,
                                  Colors.green,
                                ),
                                _buildInfoCard(
                                  'الراحة',
                                  exercise['rest'],
                                  Icons.timer,
                                  Colors.orange,
                                ),
                                _buildInfoCard(
                                  'المستوى',
                                  exercise['difficulty'],
                                  Icons.speed,
                                  Colors.red,
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // نوع القبضة
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.handshake,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'نوع القبضة: ${exercise['grip']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // العضلات المستهدفة
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.sports, color: Colors.blue),
                              const SizedBox(width: 10),
                              const Text(
                                'العضلات المستهدفة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: (exercise['muscles'] as List<String>)
                                .map(
                                  (muscle) => Chip(
                                    label: Text(muscle),
                                    backgroundColor: Colors.blue[50],
                                    side: BorderSide(color: Colors.blue[100]!),
                                    avatar: const Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // نصائح الأداء
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.lightbulb,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'نصائح الأداء',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  _showFormTips
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _showFormTips = !_showFormTips,
                                  );
                                },
                              ),
                            ],
                          ),

                          if (_showFormTips) ...[
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.amber[100]!),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    exercise['tips'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.6,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text('حافظ على ظهر مستقيم'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text('شد الكتفين للخلف'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text('تنفس أثناء الجهد'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // مؤتمر الراحة
                  _buildTimerCard(exercise),

                  const SizedBox(height: 40),

                  // قائمة جميع التمارين
                  _buildExercisesList(),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // أزرار التنقل في الأسفل
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.skip_previous),
                  label: const Text('السابق'),
                  onPressed: _currentExercise > 0 ? _previousExercise : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue[100]!),
                ),
                child: Text(
                  // ignore: unnecessary_brace_in_string_interps
                  '${_setsCompleted}/${exercise['sets']} مجموعات',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.skip_next),
                  label: const Text('التالي'),
                  onPressed: _nextExercise,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTimerCard(Map<String, dynamic> exercise) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple[400]!, Colors.indigo[600]!],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.timer, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'مؤقت الراحة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    exercise['rest'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '$_timerSeconds',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Digital',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _timerSeconds < 30 ? '⏰ وقتك ينفذ!' : 'استعد للجولة التالية',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isTimerRunning ? 'إيقاف' : 'بدء'),
                  onPressed: _toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                OutlinedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة'),
                  onPressed: _resetTimer,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
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

  Widget _buildExercisesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'جميع تمارين الظهر',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
          ),
          itemCount: backExercises.length,
          itemBuilder: (context, index) {
            final ex = backExercises[index];
            bool isActive = index == _currentExercise;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentExercise = index;
                  _setsCompleted = 0;
                  final restTime =
                      int.tryParse(ex['rest'].replaceAll('s', '')) ?? 90;
                  _timerSeconds = restTime;
                  _animationController.reset();
                  _animationController.forward();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: isActive
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [ex['color'], ex['color'].withOpacity(0.8)],
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[200]!, Colors.grey[100]!],
                        ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isActive ? 0.2 : 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: isActive
                      ? Border.all(color: Colors.white, width: 2)
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                isActive ? 0.3 : 0.2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              ex['icon'],
                              size: 16,
                              color: isActive ? Colors.white : ex['color'],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                isActive ? 0.3 : 0.2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isActive ? Colors.white : ex['color'],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ex['name'].split(' ').take(2).join(' '),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${ex['sets']}×${ex['reps']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? Colors.white70 : Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      if (isActive)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              'نشط',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
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
          },
        ),
      ],
    );
  }

  void _toggleTimer() {
    setState(() => _isTimerRunning = !_isTimerRunning);
    if (_isTimerRunning) {
      _startTimer();
    }
  }

  void _resetTimer() {
    final restTime =
        int.tryParse(
          backExercises[_currentExercise]['rest'].replaceAll('s', ''),
        ) ??
        90;
    setState(() {
      _timerSeconds = restTime;
      _isTimerRunning = false;
    });
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isTimerRunning && mounted && _timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
          _startTimer();
        });
      } else if (_timerSeconds == 0) {
        setState(() => _isTimerRunning = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('⏰ وقت الراحة انتهى! جاهز للمجموعة التالية'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _nextExercise() {
    if (_currentExercise < backExercises.length - 1) {
      setState(() {
        _currentExercise++;
        _setsCompleted = 0;
        _resetTimer();
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  void _previousExercise() {
    if (_currentExercise > 0) {
      setState(() {
        _currentExercise--;
        _setsCompleted = 0;
        _resetTimer();
        _animationController.reset();
        _animationController.forward();
      });
    }
  }
}
