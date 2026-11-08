import 'package:flutter/material.dart';

class LegsWorkoutsScreen extends StatefulWidget {
  const LegsWorkoutsScreen({super.key});

  @override
  State<LegsWorkoutsScreen> createState() => _LegsWorkoutsScreenState();
}

class _LegsWorkoutsScreenState extends State<LegsWorkoutsScreen> {
  final List<Map<String, dynamic>> legsExercises = [
    {
      'id': 1,
      'name': 'قرفصاء عالية التردد (High Frequency Squats)',
      'description': 'تقنية جديدة لزيادة حجم الساقين',
      'sets': 5,
      'reps': '10-15',
      'rest': '90s',
      'difficulty': 'متقدم',
      'muscles': 'فخذ أمامي, خلفي, أرداف',
      'icon': Icons.fitness_center,
      'color': Colors.deepOrange,
    },
    {
      'id': 2,
      'name': 'ديدلفت روماني (Romanian Deadlift)',
      'description': 'للتضخيم الخلفي للساقين',
      'sets': 4,
      'reps': '8-12',
      'rest': '120s',
      'difficulty': 'متوسط',
      'muscles': 'فخذ خلفي, أرداف',
      'icon': Icons.trending_up,
      'color': Colors.purple,
    },
    {
      'id': 3,
      'name': 'لانجز متدرج (Step-up Lunges)',
      'description': 'لتحسين التوازن والتضخيم',
      'sets': 3,
      'reps': '12-15 كل رجل',
      'rest': '75s',
      'difficulty': 'متوسط',
      'muscles': 'فخذ أمامي, أرداف',
      'icon': Icons.directions_walk,
      'color': Colors.teal,
    },
    {
      'id': 4,
      'name': 'ضغط ساق بقدم منخفضة (Low Foot Leg Press)',
      'description': 'يركز على الفخذ الأمامي',
      'sets': 4,
      'reps': '10-12',
      'rest': '90s',
      'difficulty': 'مبتدئ',
      'muscles': 'فخذ أمامي',
      'icon': Icons.arrow_circle_down,
      'color': Colors.blue,
    },
    {
      'id': 5,
      'name': 'سحب ساق منحنٍ (Curtsy Lunge)',
      'description': 'للتضخيم الجانبي للأرداف',
      'sets': 3,
      'reps': '10-12 كل رجل',
      'rest': '60s',
      'difficulty': 'متوسط',
      'muscles': 'أرداف, فخذ جانبي',
      'icon': Icons.open_with,
      'color': Colors.pink,
    },
    {
      'id': 6,
      'name': 'رفع ربلة جالس (Seated Calf Raise)',
      'description': 'لتضخيم ربلة الساق',
      'sets': 5,
      'reps': '15-20',
      'rest': '45s',
      'difficulty': 'مبتدئ',
      'muscles': 'ربلة الساق',
      'icon': Icons.arrow_upward,
      'color': Colors.amber,
    },
    {
      'id': 7,
      'name': 'نشر ساق آلة (Hip Abductor Machine)',
      'description': 'للتضخيم الخارجي للأرداف',
      'sets': 4,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'مبتدئ',
      'muscles': 'أرداف خارجية',
      'icon': Icons.open_in_full,
      'color': Colors.indigo,
    },
    {
      'id': 8,
      'name': 'جسر أرداف مع ثقل (Barbell Hip Thrust)',
      'description': 'لتضخيم الأرداف',
      'sets': 4,
      'reps': '8-10',
      'rest': '90s',
      'difficulty': 'متقدم',
      'muscles': 'أرداف, فخذ خلفي',
      'icon': Icons.waterfall_chart,
      'color': Colors.deepPurple,
    },
    {
      'id': 9,
      'name': 'قرفصاء بولغاري (Bulgarian Split Squat)',
      'description': 'للعزل والتضخيم',
      'sets': 3,
      'reps': '8-10 كل رجل',
      'rest': '75s',
      'difficulty': 'متقدم',
      'muscles': 'فخذ أمامي, أرداف',
      'icon': Icons.account_balance,
      'color': Colors.cyan,
    },
    {
      'id': 10,
      'name': 'تمديد ساق آلة (Leg Extension)',
      'description': 'لعزل الفخذ الأمامي',
      'sets': 4,
      'reps': '12-15',
      'rest': '60s',
      'difficulty': 'مبتدئ',
      'muscles': 'فخذ أمامي',
      'icon': Icons.straighten,
      'color': Colors.lightGreen,
    },
  ];

  int _currentExercise = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تمارين الساقين المتقدمة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.green[700],
        elevation: 5,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sports_gymnastics),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with current exercise
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.green[700]!, Colors.green[500]!],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        legsExercises[_currentExercise]['icon'],
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
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
                        '${_currentExercise + 1}/${legsExercises.length}',
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
                  legsExercises[_currentExercise]['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  legsExercises[_currentExercise]['description'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Exercise details card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[50]!, Colors.grey[100]!],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Exercise stats card
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green[50]!, Colors.blue[50]!],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'معلومات التمرين',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 15),
                          _buildModernInfoRow(
                            Icons.format_list_numbered,
                            'المجموعات',
                            '${legsExercises[_currentExercise]['sets']}',
                            Colors.green,
                          ),
                          _buildModernInfoRow(
                            Icons.repeat,
                            'التكرارات',
                            legsExercises[_currentExercise]['reps'],
                            Colors.blue,
                          ),
                          _buildModernInfoRow(
                            Icons.timer,
                            'الراحة',
                            legsExercises[_currentExercise]['rest'],
                            Colors.orange,
                          ),
                          _buildModernInfoRow(
                            Icons.bolt,
                            'المستوى',
                            legsExercises[_currentExercise]['difficulty'],
                            Colors.purple,
                          ),
                          _buildModernInfoRow(
                            Icons.psychology,
                            'العضلات المستهدفة',
                            legsExercises[_currentExercise]['muscles'],
                            Colors.red,
                          ),
                        ],
                      ),
                    ),

                    // All exercises list header
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          const Icon(Icons.list, color: Colors.green, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'جميع تمارين الساقين',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${legsExercises.length} تمرين',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Exercises horizontal list
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: legsExercises.length,
                        itemBuilder: (context, index) {
                          final exercise = legsExercises[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentExercise = index;
                              });
                            },
                            child: Container(
                              width: 140,
                              margin: EdgeInsets.only(
                                left: 8,
                                right: index == legsExercises.length - 1
                                    ? 8
                                    : 0,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _currentExercise == index
                                      ? [
                                          exercise['color'].withOpacity(0.9),
                                          exercise['color'].withOpacity(0.7),
                                        ]
                                      : [Colors.white, Colors.grey[100]!],
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                border: _currentExercise == index
                                    ? Border.all(
                                        color: exercise['color'],
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
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
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      exercise['name'].split(' ')[0],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _currentExercise == index
                                            ? Colors.white
                                            : Colors.grey[800],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${exercise['sets']} × ${exercise['reps']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _currentExercise == index
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Detailed exercises list
                    const SizedBox(height: 20),
                    ...legsExercises.map(
                      (exercise) => Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color:
                                _currentExercise ==
                                    legsExercises.indexOf(exercise)
                                ? exercise['color']
                                : Colors.grey.withOpacity(0.1),
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  exercise['color'].withOpacity(0.2),
                                  exercise['color'].withOpacity(0.1),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                exercise['icon'],
                                color: exercise['color'],
                              ),
                            ),
                          ),
                          title: Text(
                            exercise['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentExercise ==
                                      legsExercises.indexOf(exercise)
                                  ? exercise['color']
                                  : Colors.grey[800],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                exercise['description'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: exercise['color'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${exercise['sets']} مجموعات',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: exercise['color'],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: exercise['color'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      exercise['reps'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: exercise['color'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  _currentExercise ==
                                      legsExercises.indexOf(exercise)
                                  ? exercise['color']
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              exercise['difficulty'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    _currentExercise ==
                                        legsExercises.indexOf(exercise)
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _currentExercise = legsExercises.indexOf(
                                exercise,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'prev',
              onPressed: () {
                setState(() {
                  _currentExercise = _currentExercise > 0
                      ? _currentExercise - 1
                      : legsExercises.length - 1;
                });
              },
              backgroundColor: Colors.green[700],
              // ignore: sort_child_properties_last
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'تمرين ${_currentExercise + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                setState(() {
                  _currentExercise =
                      (_currentExercise + 1) % legsExercises.length;
                });
              },
              backgroundColor: Colors.green[700],
              // ignore: sort_child_properties_last
              child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInfoRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
