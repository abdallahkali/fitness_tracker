import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:fitness_tracker/utils/app_language.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key});

  @override
  State<CalorieCalculatorScreen> createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  // متغيرات الإدخال
  String _gender = 'male';
  double _height = 170.0;
  double _weight = 70.0;
  int _age = 25;
  String _activityLevel = 'moderate';
  String _goal = 'maintain';

  // نتائج الحساب
  double? _bmr;
  double? _tdee;
  double? _calorieGoal;
  double? _proteinGoal;
  double? _carbsGoal;
  double? _fatGoal;

  // خيارات النشاط
  final List<Map<String, dynamic>> _activityLevels = [
    {
      'value': 'sedentary',
      'label': 'قليل النشاط',
      'factor': 1.2,
      'description': 'عمل مكتبي، لا تمارين',
    },
    {
      'value': 'light',
      'label': 'خفيف النشاط',
      'factor': 1.375,
      'description': 'تمارين خفيفة 1-3 أيام/أسبوع',
    },
    {
      'value': 'moderate',
      'label': 'متوسط النشاط',
      'factor': 1.55,
      'description': 'تمارين متوسطة 3-5 أيام/أسبوع',
    },
    {
      'value': 'active',
      'label': 'نشيط',
      'factor': 1.725,
      'description': 'تمارين قوية 6-7 أيام/أسبوع',
    },
    {
      'value': 'very_active',
      'label': 'نشيط جداً',
      'factor': 1.9,
      'description': 'تمرين قوي يومياً أو عمل بدني',
    },
  ];

  // خيارات الهدف
  final List<Map<String, dynamic>> _goals = [
    {
      'value': 'lose_fast',
      'label': 'خسارة سريعة',
      'calorieAdjust': -500,
      'description': 'خسارة 0.5-1 كجم أسبوعياً',
    },
    {
      'value': 'lose_slow',
      'label': 'خسارة بطيئة',
      'calorieAdjust': -250,
      'description': 'خسارة 0.25-0.5 كجم أسبوعياً',
    },
    {
      'value': 'maintain',
      'label': 'الحفاظ على الوزن',
      'calorieAdjust': 0,
      'description': 'الحفاظ على الوزن الحالي',
    },
    {
      'value': 'gain_slow',
      'label': 'زيادة بطيئة',
      'calorieAdjust': 250,
      'description': 'زيادة 0.25-0.5 كجم أسبوعياً',
    },
    {
      'value': 'gain_fast',
      'label': 'زيادة سريعة',
      'calorieAdjust': 500,
      'description': 'زيادة 0.5-1 كجم أسبوعياً',
    },
  ];

  @override
  void initState() {
    super.initState();
    _calculateCalories();
  }

  void _calculateCalories() {
    // حساب BMR (معدل الأيض الأساسي)
    if (_gender == 'male') {
      _bmr = 88.362 + (13.397 * _weight) + (4.799 * _height) - (5.677 * _age);
    } else {
      _bmr = 447.593 + (9.247 * _weight) + (3.098 * _height) - (4.330 * _age);
    }

    // حساب TDEE (إجمالي الإنفاق اليومي للطاقة)
    final activity = _activityLevels.firstWhere(
      (a) => a['value'] == _activityLevel,
    );
    _tdee = _bmr! * activity['factor'];

    // حساب هدف السعرات حسب الهدف
    final goal = _goals.firstWhere((g) => g['value'] == _goal);
    _calorieGoal = _tdee! + goal['calorieAdjust'];

    // حساب المغذيات الكبرى
    // بروتين: 2.2 جرام لكل كجم من وزن الجسم للتنحيف/تضخيم، 1.6 جرام للحفاظ
    if (_goal.contains('lose') || _goal.contains('gain')) {
      _proteinGoal = (_weight * 2.2).roundToDouble();
    } else {
      _proteinGoal = (_weight * 1.6).roundToDouble();
    }

    // دهون: 25% من السعرات الحرارية
    _fatGoal = ((_calorieGoal! * 0.25) / 9)
        .roundToDouble(); // 9 سعرات لكل جرام دهون

    // كربوهيدرات: الباقي
    final proteinCalories = _proteinGoal! * 4; // 4 سعرات لكل جرام بروتين
    final fatCalories = _fatGoal! * 9; // 9 سعرات لكل جرام دهون
    final remainingCalories = _calorieGoal! - proteinCalories - fatCalories;
    _carbsGoal = (remainingCalories / 4)
        .roundToDouble(); // 4 سعرات لكل جرام كارب

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('حاسبة السعرات الحرارية'),
        centerTitle: true,
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة النتائج
            if (_calorieGoal != null) _buildResultsCard(),

            SizedBox(height: 24),

            // بيانات الإدخال
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'أدخل بياناتك',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 20),

                    // النوع
                    _buildGenderSelector(),

                    SizedBox(height: 20),

                    // الطول
                    _buildHeightSelector(),

                    SizedBox(height: 20),

                    // الوزن
                    _buildWeightSelector(),

                    SizedBox(height: 20),

                    // العمر
                    _buildAgeSelector(),

                    SizedBox(height: 20),

                    // مستوى النشاط
                    _buildActivitySelector(),

                    SizedBox(height: 20),

                    // الهدف
                    _buildGoalSelector(),

                    SizedBox(height: 20),

                    // زر الحساب
                    ElevatedButton.icon(
                      onPressed: _calculateCalories,
                      icon: Icon(Icons.calculate),
                      label: Text('احسب سعراتي'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // معلومات إضافية
            _buildInfoSection(),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Color(0xFF4CAF50),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'نتائج حساب السعرات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // نتائج الحساب
            _buildResultRow(
              'معدل الأيض الأساسي (BMR)',
              '${_bmr!.round()} سعرة/يوم',
              Icons.favorite,
            ),
            _buildResultRow(
              'إجمالي الإنفاق اليومي (TDEE)',
              '${_tdee!.round()} سعرة/يوم',
              Icons.directions_run,
            ),
            _buildResultRow(
              'هدف السعرات اليومي',
              '${_calorieGoal!.round()} سعرة/يوم',
              Icons.flag,
            ),

            SizedBox(height: 20),

            // المغذيات الكبرى
            Text(
              'توزيع المغذيات الكبرى:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMacroCard(
                  'بروتين',
                  '${_proteinGoal!.round()} جم',
                  Color(0xFF2196F3),
                ),
                _buildMacroCard(
                  'كربوهيدرات',
                  '${_carbsGoal!.round()} جم',
                  Color(0xFFFF9800),
                ),
                _buildMacroCard(
                  'دهون',
                  '${_fatGoal!.round()} جم',
                  Color(0xFFF44336),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: Colors.white70)),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'النوع',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ChoiceChip(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.male, size: 18),
                    SizedBox(width: 8),
                    Text('ذكر'),
                  ],
                ),
                selected: _gender == 'male',
                onSelected: (selected) {
                  setState(() => _gender = 'male');
                },
                selectedColor: Colors.blue,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: _gender == 'male' ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ChoiceChip(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.female, size: 18),
                    SizedBox(width: 8),
                    Text('أنثى'),
                  ],
                ),
                selected: _gender == 'female',
                onSelected: (selected) {
                  setState(() => _gender = 'female');
                },
                selectedColor: Colors.pink,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: _gender == 'female' ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeightSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الطول',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${_height.round()} سم',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Slider(
          value: _height,
          min: 100,
          max: 250,
          divisions: 150,
          label: '${_height.round()} سم',
          onChanged: (value) {
            setState(() => _height = value);
          },
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('100 سم', style: TextStyle(color: Colors.grey)),
            Text('250 سم', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الوزن',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${_weight.round()} كجم',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Slider(
          value: _weight,
          min: 30,
          max: 200,
          divisions: 170,
          label: '${_weight.round()} كجم',
          onChanged: (value) {
            setState(() => _weight = value);
          },
          activeColor: Colors.green,
          inactiveColor: Colors.grey[300],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('30 كجم', style: TextStyle(color: Colors.grey)),
            Text('200 كجم', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'العمر',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '$_age سنة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Slider(
          value: _age.toDouble(),
          min: 15,
          max: 80,
          divisions: 65,
          label: '$_age سنة',
          onChanged: (value) {
            setState(() => _age = value.round());
          },
          activeColor: Colors.orange,
          inactiveColor: Colors.grey[300],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('15 سنة', style: TextStyle(color: Colors.grey)),
            Text('80 سنة', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildActivitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مستوى النشاط',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _activityLevels.map((activity) {
            bool isSelected = _activityLevel == activity['value'];
            return ChoiceChip(
              label: Text(activity['label']),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _activityLevel = activity['value']);
              },
              selectedColor: Colors.purple,
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        Text(
          _activityLevels.firstWhere(
            (a) => a['value'] == _activityLevel,
          )['description'],
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildGoalSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الهدف',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _goals.map((goal) {
            bool isSelected = _goal == goal['value'];
            Color chipColor;
            switch (goal['value']) {
              case 'lose_fast':
                chipColor = Colors.red;
                break;
              case 'lose_slow':
                chipColor = Colors.orange;
                break;
              case 'maintain':
                chipColor = Colors.green;
                break;
              case 'gain_slow':
                chipColor = Colors.blue;
                break;
              case 'gain_fast':
                chipColor = Colors.purple;
                break;
              default:
                chipColor = Colors.grey;
            }

            return ChoiceChip(
              label: Text(goal['label']),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _goal = goal['value']);
              },
              selectedColor: chipColor,
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        Text(
          _goals.firstWhere((g) => g['value'] == _goal)['description'],
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معلومات مهمة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 15),

            _buildInfoItem(
              Icons.info,
              'معدل الأيض الأساسي (BMR):',
              'عدد السعرات التي يحرقها جسمك في حالة الراحة التامة.',
            ),

            _buildInfoItem(
              Icons.local_fire_department,
              'إجمالي الإنفاق اليومي (TDEE):',
              'مجموع السعرات التي تحرقها يومياً بما في ذلك الأنشطة والتمارين.',
            ),

            _buildInfoItem(
              Icons.trending_up,
              'نصائح لتحقيق هدفك:',
              _getGoalTips(),
            ),

            _buildInfoItem(
              Icons.water_drop,
              'تذكر شرب الماء:',
              'اشرب 8-10 أكواب ماء يومياً للمساعدة في حرق الدهون.',
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _shareResults();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 10),
                  Text('شارك النتائج'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getGoalTips() {
    switch (_goal) {
      case 'lose_fast':
        return '• قلل من الكربوهيدرات المكررة\n• زد من البروتين والألياف\n• تمارين الكارديو 5-6 أيام أسبوعياً\n• نم 7-8 ساعات يومياً';
      case 'lose_slow':
        return '• اتّبع نظاماً غذائياً متوازناً\n• تمارين متوسطة 3-4 أيام أسبوعياً\n• تجنب الأكل قبل النوم\n• امشِ 10000 خطوة يومياً';
      case 'maintain':
        return '• حافظ على تناول السعرات المستهدفة\n• واصل ممارسة التمارين\n• راقب وزنك أسبوعياً\n• حافظ على رطوبة الجسم';
      case 'gain_slow':
        return '• زد من تناول البروتين\n• تمارين قوة 3-4 أيام أسبوعياً\n• وجبات صغيرة متكررة\n• نوّع مصادر الكربوهيدرات الصحية';
      case 'gain_fast':
        return '• تناول 5-6 وجبات يومياً\n• تمارين قوة مكثفة\n• مكملات البروتين (اختياري)\n• نوم كافي للتعافي';
      default:
        return 'حافظ على نظام غذائي متوازن ونمط حياة نشط';
    }
  }

  void _shareResults() {
    String results =
        '''
🔥 نتائج حساب السعرات الحرارية 🔥

👤 البيانات المدخلة:
• النوع: ${_gender == 'male' ? 'ذكر' : 'أنثى'}
• الطول: ${_height.round()} سم
• الوزن: ${_weight.round()} كجم
• العمر: $_age سنة
• مستوى النشاط: ${_activityLevels.firstWhere((a) => a['value'] == _activityLevel)['label']}
• الهدف: ${_goals.firstWhere((g) => g['value'] == _goal)['label']}

📊 النتائج:
• معدل الأيض الأساسي: ${_bmr!.round()} سعرة/يوم
• إجمالي الإنفاق اليومي: ${_tdee!.round()} سعرة/يوم
• هدف السعرات اليومي: ${_calorieGoal!.round()} سعرة/يوم

🥩 المغذيات الكبرى:
• بروتين: ${_proteinGoal!.round()} جم
• كربوهيدرات: ${_carbsGoal!.round()} جم
• دهون: ${_fatGoal!.round()} جم

💪 تم الحساب بواسطة Fitness Tracker
''';

    // يمكنك استخدام حزمة للشارة مثل share_plus
    // أو عرض النتائج في AlertDialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('شارك النتائج'),
        content: SingleChildScrollView(child: Text(results)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
          TextButton(
            onPressed: () {
              // نسخ النتائج للحافظة
              Clipboard.setData(ClipboardData(text: results));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('تم نسخ النتائج')));
              Navigator.pop(context);
            },
            child: Text('نسخ'),
          ),
        ],
      ),
    );
  }
}
