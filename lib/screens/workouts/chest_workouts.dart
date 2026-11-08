import 'package:flutter/material.dart';

class ChestWorkoutsScreen extends StatefulWidget {
  const ChestWorkoutsScreen({super.key});

  @override
  State<ChestWorkoutsScreen> createState() => _ChestWorkoutsScreenState();
}

class _ChestWorkoutsScreenState extends State<ChestWorkoutsScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> chestExercises = [
    {
      'id': 1,
      'name': 'ضغط بنش مائل بالدامبل',
      'description': 'يركز على الجزء العلوي من الصدر',
      'sets': 4,
      'reps': '8-12',
      'rest': '90s',
      'difficulty': 'متوسط',
      'benefits': 'تضخيم الجزء العلوي من الصدر، تحسين التناسق',
      'tips': 'أبقِ المرفقين بزاوية 45 درجة',
      'icon': Icons.fitness_center,
      'color': Colors.redAccent,
      'category': 'تضخيم علوي',
      'intensity': 4,
    },
    {
      'id': 2,
      'name': 'ضغط بنش باندا',
      'description': 'تقنية متقدمة لتحفيق ألياف الصدر',
      'sets': 3,
      'reps': '6-8',
      'rest': '120s',
      'difficulty': 'متقدم',
      'benefits': 'تحفيق كامل لعضلة الصدر، زيادة القوة',
      'tips': 'استخدم قوس خفيف في الظهر',
      'icon': Icons.flag,
      'color': Colors.deepOrange,
      'category': 'تقنية متقدمة',
      'intensity': 5,
    },
    {
      'id': 3,
      'name': 'كروس اوڤر بكابل منخفض',
      'description': 'للتضخيم الجانبي للصدر',
      'sets': 3,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'متوسط',
      'benefits': 'عزل عضلات الصدر، شكل V',
      'tips': 'حافظ على ثبات الجذع',
      'icon': Icons.open_with,
      'color': Colors.purple,
      'category': 'عزل جانبي',
      'intensity': 3,
    },
    {
      'id': 4,
      'name': 'ضغط أرضي بنصف المدى',
      'description': 'تقنية لزيادة القوة في النصف السفلي',
      'sets': 4,
      'reps': '5-7',
      'rest': '150s',
      'difficulty': 'متقدم',
      'benefits': 'زيادة قوة الدفع، تقوية الثلاثية',
      'tips': 'توقف عند منتصف الحركة',
      'icon': Icons.speed,
      'color': Colors.blue,
      'category': 'قوة وثبات',
      'intensity': 5,
    },
    {
      'id': 5,
      'name': 'فلاي بالدمبل على الأرض',
      'description': 'لتمديد عضلة الصدر بأمان',
      'sets': 3,
      'reps': '10-12',
      'rest': '75s',
      'difficulty': 'مبتدئ',
      'benefits': 'أمان للمفاصل، شد العضلة',
      'tips': 'لا تمدد أكثر من اللازم',
      'icon': Icons.expand,
      'color': Colors.green,
      'category': 'تمديد آمن',
      'intensity': 2,
    },
    {
      'id': 6,
      'name': 'ضغط آلة سميث مائل',
      'description': 'للتضخيم مع الأمان',
      'sets': 4,
      'reps': '8-10',
      'rest': '90s',
      'difficulty': 'متوسط',
      'benefits': 'مسار ثابت، أمان أكبر',
      'tips': 'استخدم قبضة متوسطة',
      'icon': Icons.security,
      'color': Colors.teal,
      'category': 'آمن ومثبت',
      'intensity': 3,
    },
    {
      'id': 7,
      'name': 'ضغط بنش مع تقنية 1.5',
      'description': 'تقنية الضغط والنصف لزيادة التوتر',
      'sets': 3,
      'reps': '6-8',
      'rest': '120s',
      'difficulty': 'متقدم',
      'benefits': 'زيادة وقت التوتر، تحفيق إضافي',
      'tips': 'نصف حركة ثم حركة كاملة',
      'icon': Icons.repeat_one,
      'color': Colors.amber,
      'category': 'تقنية متطورة',
      'intensity': 4,
    },
    {
      'id': 8,
      'name': 'كروس اوڤر بانسحاب',
      'description': 'للتضخيم السفلي والتمديد',
      'sets': 3,
      'reps': '10-12',
      'rest': '60s',
      'difficulty': 'متوسط',
      'benefits': 'تمديد عضلة الصدر، تضخيم سفلي',
      'tips': 'انسحب للخلف وللأسفل',
      'icon': Icons.arrow_downward,
      'color': Colors.indigo,
      'category': 'تمديد سفلي',
      'intensity': 3,
    },
  ];

  int _currentExercise = 0;
  int _setsCompleted = 0;
  int _timerSeconds = 90;
  bool _isTimerRunning = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentSet = 1;
  // ignore: prefer_final_fields
  bool _showStats = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = chestExercises[_currentExercise];
    final totalExercises = chestExercises.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // AppBar مع معلومات التمرين
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: Colors.red[900],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red[900]!, Colors.red[700]!],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                exercise['category'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${exercise['intensity']}/5',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
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
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.9),
                        ),
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

          // محتوى الشاشة
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // بطاقة الإحصائيات
                  if (_showStats)
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
                              colors: [Colors.orange[50]!, Colors.red[50]!],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                Icons.format_list_numbered,
                                'المجموعات',
                                '$_currentSet/${exercise['sets']}',
                                Colors.red,
                              ),
                              _buildStatItem(
                                Icons.repeat,
                                'التكرارات',
                                exercise['reps'],
                                Colors.orange,
                              ),
                              _buildStatItem(
                                Icons.timer,
                                'الراحة',
                                exercise['rest'],
                                Colors.blue,
                              ),
                              _buildStatItem(
                                Icons.speed,
                                'المستوى',
                                exercise['difficulty'],
                                Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 25),

                  // بطاقة معلومات التمرين
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
                              const Icon(Icons.emoji_events, color: Colors.red),
                              const SizedBox(width: 10),
                              const Text(
                                'الفوائد',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.red[100]!),
                            ),
                            child: Text(
                              exercise['benefits'],
                              style: const TextStyle(fontSize: 15, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // بطاقة النصائح
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
                              const Icon(Icons.lightbulb, color: Colors.amber),
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
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber[100]!),
                            ),
                            child: Text(
                              exercise['tips'],
                              style: const TextStyle(fontSize: 15, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

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
                            Colors.deepPurple[600]!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '⏱️ مؤقت الراحة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton.extended(
                                heroTag: 'timer-start',
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
                          const Text(
                            'تقدم المجموعات',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 15),
                          LinearProgressIndicator(
                            value: _setsCompleted / exercise['sets'],
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.red,
                            ),
                            minHeight: 12,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // ignore: unnecessary_brace_in_string_interps
                                '${_setsCompleted}/${exercise['sets']} مجموعات',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.check_circle, size: 18),
                                label: const Text('أكملت المجموعة'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _completeSet,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // قائمة التمارين
                  _buildExercisesList(),

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
              // ignore: deprecated_member_use
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
              icon: const Icon(Icons.skip_next),
              label: const Text('التالي'),
              onPressed: _nextExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
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

  Widget _buildStatItem(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            // ignore: deprecated_member_use
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
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

  Widget _buildExercisesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'تمارين الصدر',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: chestExercises.length,
            itemBuilder: (context, index) {
              final ex = chestExercises[index];
              bool isActive = index == _currentExercise;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentExercise = index;
                    _currentSet = 1;
                    _setsCompleted = 0;
                    _timerSeconds =
                        int.tryParse(ex['rest'].replaceAll('s', '')) ?? 90;
                  });
                },
                child: Container(
                  width: 140,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 10,
                    right: index == chestExercises.length - 1 ? 0 : 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isActive
                          ? [ex['color'], ex['color'].withOpacity(0.8)]
                          : [Colors.grey[200]!, Colors.grey[100]!],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: isActive
                        ? Border.all(color: ex['color'], width: 2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(isActive ? 0.2 : 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              ex['icon'],
                              size: 16,
                              color: isActive ? Colors.white : ex['color'],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'تمرين ${index + 1}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isActive
                                      ? Colors.white70
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
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
                        const SizedBox(height: 4),
                        Text(
                          '${ex['sets']}×${ex['reps']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isActive ? Colors.white70 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
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
          chestExercises[_currentExercise]['rest'].replaceAll('s', ''),
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
        // إشعار عند انتهاء الوقت
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('⏰ وقت الراحة انتهى! ابدأ التمرين التالي'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _completeSet() {
    if (_currentSet < chestExercises[_currentExercise]['sets']) {
      setState(() {
        _setsCompleted++;
        _currentSet++;
      });

      // إعادة ضبط المؤقت للمجموعة التالية
      _resetTimer();

      // إشعار تقدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ أكملت المجموعة $_currentSet'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // إذا كانت المجموعة الأخيرة
      if (_currentSet > chestExercises[_currentExercise]['sets']) {
        Future.delayed(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '🎉 أكملت كل مجموعات ${chestExercises[_currentExercise]['name']}',
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        });
      }
    }
  }

  void _nextExercise() {
    if (_currentExercise < chestExercises.length - 1) {
      setState(() {
        _currentExercise++;
        _currentSet = 1;
        _setsCompleted = 0;
        _resetTimer();
        _controller.reset();
        _controller.forward();
      });
    }
  }

  void _previousExercise() {
    if (_currentExercise > 0) {
      setState(() {
        _currentExercise--;
        _currentSet = 1;
        _setsCompleted = 0;
        _resetTimer();
        _controller.reset();
        _controller.forward();
      });
    }
  }
}
