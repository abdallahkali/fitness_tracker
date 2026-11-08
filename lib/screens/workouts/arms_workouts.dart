import 'package:flutter/material.dart';

class ArmsWorkoutsScreen extends StatefulWidget {
  const ArmsWorkoutsScreen({super.key});

  @override
  State<ArmsWorkoutsScreen> createState() => _ArmsWorkoutsScreenState();
}

class _ArmsWorkoutsScreenState extends State<ArmsWorkoutsScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> armExercises = [
    {
      'id': 1,
      'name': 'ضغط ثلاثي بالدمبل',
      'description': 'تمرين أساسي لتضخيم العضلة الثلاثية بالدمبل',
      'sets': 4,
      'reps': '10-12',
      'rest': '60s',
      'type': 'ثلاثية',
      'equipment': 'دمبل',
      'icon': Icons.arrow_upward,
      'color': Colors.redAccent,
      'intensity': 4,
      'benefits': ['تضخيم ثلاثية الرؤوس', 'تحسين الدفع'],
      'tips': 'حافظ على المرفقين ثابتين، انزل ببطء',
    },
    {
      'id': 2,
      'name': 'تمرين البايسبس بالبار',
      'description': 'تمرين تقليدي لتضخيم العضلة ذات الرأسين',
      'sets': 4,
      'reps': '8-12',
      'rest': '75s',
      'type': 'ذات الرأسين',
      'equipment': 'بار',
      'icon': Icons.fitness_center,
      'color': Colors.blueAccent,
      'intensity': 4,
      'benefits': ['تضخيم البايسبس', 'قوة السحب'],
      'tips': 'تحكم في الحركة، تجنب التأرجح',
    },
    {
      'id': 3,
      'name': 'ضغط ثلاثي بالكابل',
      'description': 'تمرين عزل للثلاثية مع مقاومة مستمرة',
      'sets': 3,
      'reps': '12-15',
      'rest': '60s',
      'type': 'ثلاثية',
      'equipment': 'كابل',
      'icon': Icons.arrow_downward,
      'color': Colors.orange,
      'intensity': 3,
      'benefits': ['عزل ثلاثية الرؤوس', 'مقاومة ثابتة'],
      'tips': 'ثبت المرفقين، انزل للأسفل ببطء',
    },
    {
      'id': 4,
      'name': 'تمرين المطرقة',
      'description': 'لتضخيم الساعد والعضلة ذات الرأسين',
      'sets': 3,
      'reps': '10-12',
      'rest': '60s',
      'type': 'ذات الرأسين',
      'equipment': 'دمبل',
      'icon': Icons.handyman,
      'color': Colors.green,
      'intensity': 3,
      'benefits': ['تنمية الساعد', 'تناسق الذراع'],
      'tips': 'حافظ على قبضة المطرقة، تحكم بالحركة',
    },
    {
      'id': 5,
      'name': 'ضغط ثلاثي بجسم',
      'description': 'تمرين مركب للتضخيم والقوة',
      'sets': 4,
      'reps': '6-10',
      'rest': '90s',
      'type': 'ثلاثية',
      'equipment': 'بار',
      'icon': Icons.compare_arrows,
      'color': Colors.purpleAccent,
      'intensity': 5,
      'benefits': ['قوة ثلاثية', 'تضخيم مركب'],
      'tips': 'استخدم قبضة ضيقة، حافظ على الثبات',
    },
    {
      'id': 6,
      'name': 'تمرين ذراع منعزل',
      'description': 'لعزل وتطوير كل ذراع بشكل منفصل',
      'sets': 3,
      'reps': '8-10',
      'rest': '60s',
      'type': 'ذات الرأسين',
      'equipment': 'دمبل',
      'icon': Icons.touch_app,
      'color': Colors.teal,
      'intensity': 3,
      'benefits': ['عزل كامل', 'تصحيح الاختلال'],
      'tips': 'ثبت المرفق على الركبة، ركز على الانقباض',
    },
    {
      'id': 7,
      'name': 'ضغط ثلاثي خلف الرأس',
      'description': 'للتضخيم العلوي للثلاثية',
      'sets': 3,
      'reps': '10-12',
      'rest': '60s',
      'type': 'ثلاثية',
      'equipment': 'دمبل',
      'icon': Icons.arrow_back,
      'color': Colors.deepOrange,
      'intensity': 4,
      'benefits': ['الثلاثية العلوية', 'تمديد كامل'],
      'tips': 'حافظ على المرفقين للأعلى، انزل خلف الرأس',
    },
    {
      'id': 8,
      'name': 'تمرين 21s',
      'description': 'تقنية متقدمة لتضخيم البايسبس',
      'sets': 3,
      'reps': '21',
      'rest': '90s',
      'type': 'ذات الرأسين',
      'equipment': 'بار',
      'icon': Icons.repeat_one,
      'color': Colors.indigo,
      'intensity': 5,
      'benefits': ['تحفيق مكثف', 'كل ألياف العضلة'],
      'tips': '7 تكرارات للنصف السفلي، 7 للعلوي، 7 كاملة',
    },
  ];

  int _currentExercise = 0;
  String _selectedType = 'الكل';
  int _timerSeconds = 60;
  bool _isTimerRunning = false;
  int _setsCompleted = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showDetails = true;

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

    final restTime =
        int.tryParse(
          armExercises[_currentExercise]['rest'].replaceAll('s', ''),
        ) ??
        60;
    _timerSeconds = restTime;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredExercises {
    if (_selectedType == 'الكل') return armExercises;
    return armExercises.where((e) => e['type'] == _selectedType).toList();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = armExercises[_currentExercise];
    final isBicep = exercise['type'] == 'ذات الرأسين';
    final totalExercises = armExercises.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // AppBar مع معلومات التمرين
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: isBicep ? Colors.blue[800] : Colors.red[800],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isBicep
                        ? [Colors.blue[900]!, Colors.blue[700]!]
                        : [Colors.red[900]!, Colors.red[700]!],
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
                                'تمارين الذراعين',
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
                                exercise['type'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        exercise['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 5),
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
                'تمرين ${_currentExercise + 1}/$totalExercises',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),

          // فلاتر التمارين
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFilterButton(
                    'الكل',
                    Icons.all_inclusive,
                    Colors.purple,
                  ),
                  _buildFilterButton(
                    'ذات الرأسين',
                    Icons.fitness_center,
                    Colors.blue,
                  ),
                  _buildFilterButton(
                    'ثلاثية',
                    Icons.sports_handball,
                    Colors.red,
                  ),
                ],
              ),
            ),
          ),

          // المحتوى الرئيسي
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // بطاقة معلومات التمرين
                  if (_showDetails)
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
                              colors: [
                                isBicep ? Colors.blue[50]! : Colors.red[50]!,
                                isBicep
                                    ? Colors.lightBlue[50]!
                                    : Colors.orange[50]!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              // معلومات سريعة
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildInfoCard(
                                    'المجموعات',
                                    '${exercise['sets']}',
                                    Icons.format_list_numbered,
                                    isBicep ? Colors.blue : Colors.red,
                                  ),
                                  _buildInfoCard(
                                    'التكرارات',
                                    exercise['reps'],
                                    Icons.repeat,
                                    isBicep ? Colors.green : Colors.orange,
                                  ),
                                  _buildInfoCard(
                                    'الراحة',
                                    exercise['rest'],
                                    Icons.timer,
                                    Colors.deepPurple,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // المعدات والشدة
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isBicep
                                          ? Colors.blue[100]
                                          : Colors.red[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.build_circle,
                                          color: isBicep
                                              ? Colors.blue
                                              : Colors.red,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          exercise['equipment'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isBicep
                                                ? Colors.blue
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'شدة ${exercise['intensity']}/5',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 25),

                  // فوائد ونصائح
                  if (_showDetails)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.emoji_events,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'الفوائد',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ...(exercise['benefits'] as List<String>)
                                          .map(
                                            (benefit) => Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 6,
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check_circle,
                                                    size: 14,
                                                    color: Colors.green,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      benefit,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          // ignore: unnecessary_to_list_in_spreads
                                          .toList(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.amber[50],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'نصائح',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        exercise['tips'],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),

                  // مؤقت الراحة
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepPurple[400]!,
                            Colors.indigo[600]!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '⏱️ مؤقت الراحة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
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
                            _timerSeconds < 20
                                ? '⏰ ابدأ الآن!'
                                : 'استعد للمجموعة التالية',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton.extended(
                                heroTag: 'timer-control',
                                onPressed: _toggleTimer,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepPurple,
                                icon: Icon(
                                  _isTimerRunning
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                label: Text(_isTimerRunning ? 'إيقاف' : 'بدء'),
                              ),
                              const SizedBox(width: 20),
                              FloatingActionButton(
                                heroTag: 'timer-reset',
                                onPressed: _resetTimer,
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.refresh,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // تقدم المجموعات
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تقدم المجموعات',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isBicep ? Colors.blue : Colors.red,
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add, size: 16),
                              label: const Text('أضف مجموعة'),
                              onPressed: _addSet,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isBicep
                                    ? Colors.blue
                                    : Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        LinearProgressIndicator(
                          value: _setsCompleted / exercise['sets'],
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isBicep ? Colors.blue : Colors.red,
                          ),
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // ignore: unnecessary_brace_in_string_interps
                              '${_setsCompleted}/${exercise['sets']} مجموعات',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: _resetSets,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // قائمة التمارين
                  _buildExercisesGrid(),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // أزرار التنقل
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.skip_previous),
              label: const Text('السابق'),
              onPressed: _currentExercise > 0 ? _previousExercise : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(_showDetails ? Icons.expand_less : Icons.expand_more),
              label: Text(_showDetails ? 'إخفاء التفاصيل' : 'عرض التفاصيل'),
              onPressed: () {
                setState(() => _showDetails = !_showDetails);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.skip_next),
              label: const Text('التالي'),
              onPressed: _nextExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: isBicep ? Colors.blue : Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String type, IconData icon, Color color) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedType = type);
        if (filteredExercises.isNotEmpty) {
          setState(
            () => _currentExercise = armExercises.indexOf(filteredExercises[0]),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? color : Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : color, size: 18),
            const SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
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

  Widget _buildExercisesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'تمارين الذراعين (${filteredExercises.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _selectedType,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.1,
          ),
          itemCount: filteredExercises.length,
          itemBuilder: (context, index) {
            final ex = filteredExercises[index];
            // ignore: unused_local_variable
            final isBicep = ex['type'] == 'ذات الرأسين';
            final isActive = armExercises.indexOf(ex) == _currentExercise;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentExercise = armExercises.indexOf(ex);
                  final restTime =
                      int.tryParse(ex['rest'].replaceAll('s', '')) ?? 60;
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
                          colors: [ex['color'], ex['color'].withOpacity(0.7)],
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.grey[50]!],
                        ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isActive ? 0.2 : 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: isActive
                      ? Border.all(color: Colors.white, width: 2)
                      : Border.all(color: Colors.grey[200]!),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(
                        ex['icon'],
                        color: isActive ? Colors.white : ex['color'],
                        size: 20,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(isActive ? 0.3 : 0.2),
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
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ex['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  isActive ? 0.2 : 0.1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${ex['sets']}×${ex['reps']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isActive ? Colors.white : ex['color'],
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
          armExercises[_currentExercise]['rest'].replaceAll('s', ''),
        ) ??
        60;
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
            content: const Text('⏰ وقت الراحة انتهى! ابدأ المجموعة التالية'),
            backgroundColor: Colors.deepPurple,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _addSet() {
    if (_setsCompleted < armExercises[_currentExercise]['sets']) {
      setState(() => _setsCompleted++);
      if (_setsCompleted >= armExercises[_currentExercise]['sets']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '🎉 أكملت كل مجموعات ${armExercises[_currentExercise]['name']}',
            ),
            backgroundColor:
                armExercises[_currentExercise]['type'] == 'ذات الرأسين'
                ? Colors.blue
                : Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _resetSets() {
    setState(() => _setsCompleted = 0);
  }

  void _nextExercise() {
    if (_currentExercise < armExercises.length - 1) {
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
