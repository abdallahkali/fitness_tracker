// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';

class AbsWorkoutsScreen extends StatefulWidget {
  const AbsWorkoutsScreen({super.key});

  @override
  State<AbsWorkoutsScreen> createState() => _AbsWorkoutsScreenState();
}

class _AbsWorkoutsScreenState extends State<AbsWorkoutsScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> absExercises = [
    {
      'id': 1,
      'name': 'رفع رجل معلق',
      'description': 'تمرين متقدم للبطن السفلي باستخدام بار التعلق',
      'sets': 4,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'متقدم',
      'icon': Icons.fitness_center,
      'color': Colors.blueAccent,
      'benefits': ['البطن السفلي', 'القوة الأساسية'],
    },
    {
      'id': 2,
      'name': 'بلانك جانبي',
      'description': 'تقوية عضلات البطن الجانبية والمائلة',
      'sets': 3,
      'reps': '30-60s',
      'rest': '30s',
      'difficulty': 'مبتدئ',
      'icon': Icons.accessibility_new,
      'color': Colors.green,
      'benefits': ['البطن الجانبي', 'التوازن'],
    },
    {
      'id': 3,
      'name': 'تمرين الدراجة',
      'description': 'حركة دائرية تحرق الدهون وتقوي البطن الكامل',
      'sets': 3,
      'reps': '20-30',
      'rest': '45s',
      'difficulty': 'متوسط',
      'icon': Icons.directions_bike,
      'color': Colors.orange,
      'benefits': ['البطن الكامل', 'حرق الدهون'],
    },
    {
      'id': 4,
      'name': 'رفع رجل على الأرض',
      'description': 'تمرين أساسي لتقوية البطن السفلي',
      'sets': 4,
      'reps': '15-20',
      'rest': '60s',
      'difficulty': 'مبتدئ',
      'icon': Icons.airline_seat_legroom_extra,
      'color': Colors.purple,
      'benefits': ['البطن السفلي', 'القوة الأساسية'],
    },
    {
      'id': 5,
      'name': 'كرنش بالكابل',
      'description': 'تمرين مقاومة للتضخيم العلوي',
      'sets': 4,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'متوسط',
      'icon': Icons.cable,
      'color': Colors.redAccent,
      'benefits': ['البطن العلوي', 'التضخيم'],
    },
    {
      'id': 6,
      'name': 'بلانك',
      'description': 'تمرين ثبات وتقوية للبطن الكامل',
      'sets': 3,
      'reps': '60-90s',
      'rest': '30s',
      'difficulty': 'مبتدئ',
      'icon': Icons.horizontal_rule,
      'color': Colors.teal,
      'benefits': ['البطن الكامل', 'الثبات'],
    },
    {
      'id': 7,
      'name': 'تمرين الجلوس',
      'description': 'تقوية وتضخيم عضلات البطن العلوية',
      'sets': 4,
      'reps': '15-20',
      'rest': '60s',
      'difficulty': 'متوسط',
      'icon': Icons.arrow_upward,
      'color': Colors.amber,
      'benefits': ['البطن العلوي', 'القوة'],
    },
    {
      'id': 8,
      'name': 'رفع رجل بالكابل',
      'description': 'تمرين مقاومة متغيرة للبطن السفلي',
      'sets': 3,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'متقدم',
      'icon': Icons.trending_up,
      'color': Colors.deepOrange,
      'benefits': ['البطن السفلي', 'المقاومة'],
    },
  ];

  int _currentExercise = 0;
  int _timerSeconds = 0;
  bool _isTimerRunning = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showDetails = true;

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
    final exercise = absExercises[_currentExercise];
    bool isTimedExercise = exercise['reps'].toString().contains('s');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // AppBar مخصص
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[900]!, Colors.teal[700]!],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  // ignore: duplicate_ignore
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'تمارين البطن',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            // ignore: duplicate_ignore
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _showDetails ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() => _showDetails = !_showDetails);
                      },
                    ),
                  ],
                ),
                if (_showDetails)
                  FadeTransition(
                    opacity: _animation,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          '${absExercises.length} تمرين • 8 أسابيع',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        LinearProgressIndicator(
                          value: (_currentExercise + 1) / absExercises.length,
                          // ignore: deprecated_member_use
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          minHeight: 6,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _showDetails
                  ? _buildDetailedView(exercise, isTimedExercise)
                  : _buildCompactView(exercise, isTimedExercise),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedView(
    Map<String, dynamic> exercise,
    bool isTimedExercise,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // بطاقة التمرين الرئيسية
          Hero(
            tag: 'exercise-${exercise['id']}',
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      exercise['color'].withOpacity(0.9),
                      exercise['color'].withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            exercise['icon'],
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise['name'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Chip(
                                label: Text(
                                  exercise['difficulty'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                // ignore: deprecated_member_use
                                backgroundColor: Colors.white.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '#${_currentExercise + 1}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Arial',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      exercise['description'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // المؤقت
          if (isTimedExercise) _buildTimerCard(exercise),

          // فوائد التمرين
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
                    'فوائد التمرين',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: (exercise['benefits'] as List<String>)
                        .map(
                          (benefit) => Chip(
                            label: Text(benefit),
                            backgroundColor: Colors.teal[50],
                            side: BorderSide(color: Colors.teal[100]!),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          // معلومات التمرين
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'تفاصيل التمرين',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildInfoRow(
                    Icons.format_list_numbered,
                    'المجموعات',
                    '${exercise['sets']}',
                  ),
                  _buildInfoRow(Icons.repeat, 'التكرارات', exercise['reps']),
                  _buildInfoRow(Icons.timer, 'الراحة', exercise['rest']),
                  _buildInfoRow(Icons.speed, 'المستوى', exercise['difficulty']),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // قائمة جميع التمارين
          _buildAllExercisesList(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCompactView(
    Map<String, dynamic> exercise,
    bool isTimedExercise,
  ) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(exercise['icon'], size: 80, color: exercise['color']),
                const SizedBox(height: 20),
                Text(
                  exercise['name'],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  exercise['description'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                if (isTimedExercise) _buildTimerCard(exercise),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.skip_previous),
                  label: const Text('السابق'),
                  onPressed: _currentExercise > 0
                      ? () {
                          setState(() {
                            _currentExercise--;
                            _timerSeconds = 0;
                            _isTimerRunning = false;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('تم إنجازه'),
                  onPressed: () {
                    if (_currentExercise < absExercises.length - 1) {
                      setState(() => _currentExercise++);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.skip_next),
                  label: const Text('التالي'),
                  onPressed: _currentExercise < absExercises.length - 1
                      ? () {
                          setState(() {
                            _currentExercise++;
                            _timerSeconds = 0;
                            _isTimerRunning = false;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
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
            colors: [Colors.deepPurple[300]!, Colors.deepPurple[500]!],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Text(
              '⏱️ مؤقت التمرين',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'الهدف: ${exercise['reps']}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            Text(
              '$_timerSeconds ثانية',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Digital',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'play-pause',
                  onPressed: _toggleTimer,
                  backgroundColor: Colors.white,
                  child: Icon(
                    _isTimerRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: 'reset',
                  onPressed: _resetTimer,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllExercisesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'جميع التمارين',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: absExercises.length,
            itemBuilder: (context, index) {
              final ex = absExercises[index];
              bool isActive = index == _currentExercise;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentExercise = index;
                    _timerSeconds = 0;
                    _isTimerRunning = false;
                  });
                },
                child: Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 10,
                    right: index == absExercises.length - 1 ? 0 : 10,
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
                        color: Colors.black.withOpacity(isActive ? 0.2 : 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          ex['icon'],
                          size: 30,
                          color: isActive ? Colors.white : ex['color'],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ex['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.white : Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${ex['sets']} × ${ex['reps']}',
                          style: TextStyle(
                            fontSize: 14,
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
    setState(() {
      _timerSeconds = 0;
      _isTimerRunning = false;
    });
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isTimerRunning && mounted) {
        setState(() {
          _timerSeconds++;
          _startTimer();
        });
      }
    });
  }
}
