import 'package:fitness_tracker/screens/age_selection.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fitness_tracker/utils/app_language.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? _selectedGender;
  bool _isLoading = false;
  bool _isEnglish = false; // false = عربي, true = English

  final List<Map<String, dynamic>> _genders = [
    {
      'type': 'male',
      'title_ar': 'ذكر',
      'title_en': 'Male',
      'icon': Icons.male,
      'color': Color(0xFF2196F3),
      'gradient': [Color(0xFF2196F3), Color(0xFF21CBF3)],
      'image': 'assets/gender/male.png',
      'description_ar': 'تمارين مخصصة للرجال',
      'description_en': 'Custom exercises for men',
      'features_ar': [
        "تمارين تركيز على القوة العضلية",
        "برامج تضخيم وتنمية العضلات",
        "تمارين تحمل القوة",
        "نظام غذائي عالي البروتين",
        "تتبع نمو العضلات",
      ],
      'features_en': [
        "Strength-focused exercises",
        "Muscle building programs",
        "Strength endurance exercises",
        "High protein diet",
        "Muscle growth tracking",
      ],
    },
    {
      'type': 'female',
      'title_ar': 'أنثى',
      'title_en': 'Female',
      'icon': Icons.female,
      'color': Color(0xFFE91E63),
      'gradient': [Color(0xFFE91E63), Color(0xFFF48FB1)],
      'image': 'assets/gender/female.png',
      'description_ar': 'تمارين مخصصة للنساء',
      'description_en': 'Custom exercises for women',
      'features_ar': [
        "تمارين تركيز على التناسق والتوازن",
        "برامج شد وتنحيف",
        "تمارين مرونة وليونة",
        "نظام غذائي متوازن",
        "تتبع القياسات والتناسق",
      ],
      'features_en': [
        "Coordination and balance exercises",
        "Toning and slimming programs",
        "Flexibility exercises",
        "Balanced diet",
        "Measurements and coordination tracking",
      ],
    },
  ];

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Stack(
          children: [
            // خلفية متدرجة
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 1.5,
                    colors: [
                      // ignore: deprecated_member_use
                      Color(0xFF1D1E33).withOpacity(0.9),
                      Color(0xFF0A0E21),
                    ],
                  ),
                ),
              ),
            ),

            // المحتوى الرئيسي
            Column(
              children: [
                // الهيدر مع زر اللغة
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white70,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isEnglish ? "Welcome!" : "أهلاً وسهلاً!",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _isEnglish ? "Select Your Gender" : "اختر نوعك",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // زر تبديل اللغة
                      IconButton(
                        onPressed: _toggleLanguage,
                        icon: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              // ignore: deprecated_member_use
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isEnglish ? Icons.language : Icons.translate,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                _isEnglish ? "EN" : "AR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // نص توضيحي
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Text(
                    _isEnglish
                        ? "Select your gender to get customized exercises and recommendations that suit your needs"
                        : "اختر نوعك للحصول على تمارين وتوصيات مخصصة تناسب احتياجاتك",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // خيارات النوع
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ..._genders.map((gender) {
                        bool isSelected = _selectedGender == gender['type'];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = gender['type'];
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                colors: isSelected
                                    ? gender['gradient']
                                    : [
                                        // ignore: deprecated_member_use
                                        Colors.white.withOpacity(0.05),
                                        // ignore: deprecated_member_use
                                        Colors.white.withOpacity(0.02),
                                      ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? gender['color'].withOpacity(0.5)
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: gender['color'].withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset: Offset(0, 10),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // الأيقونة والاسم
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: gender['color'].withOpacity(
                                            0.2,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          gender['icon'],
                                          color: gender['color'],
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _isEnglish
                                                  ? gender['title_en']
                                                  : gender['title_ar'],
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              _isEnglish
                                                  ? gender['description_en']
                                                  : gender['description_ar'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: gender['color'],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                    ],
                                  ),

                                  SizedBox(height: 20),

                                  // صورة النوع
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: AssetImage(gender['image']),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  // ميزات النوع
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: gender['color'],
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              _isEnglish
                                                  ? "Features"
                                                  : "المميزات",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Column(
                                          children:
                                              (_isEnglish
                                                      ? gender['features_en']
                                                      : gender['features_ar'])
                                                  .map<Widget>(
                                                    (feature) => Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: 10,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              color: gender['color']
                                                                  .withOpacity(
                                                                    0.2,
                                                                  ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Icon(
                                                              Icons.check,
                                                              size: 14,
                                                              color:
                                                                  gender['color'],
                                                            ),
                                                          ),
                                                          SizedBox(width: 12),
                                                          Expanded(
                                                            child: Text(
                                                              feature,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 14,
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
                                ],
                              ),
                            ),
                          ),
                        );
                        // ignore: unnecessary_to_list_in_spreads
                      }).toList(),

                      SizedBox(height: 30),
                    ],
                  ),
                ),

                // قسم الزر السفلي
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (_selectedGender != null)
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: _getSelectedColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              // ignore: deprecated_member_use
                              color: _getSelectedColor().withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getSelectedIcon(),
                                color: _getSelectedColor(),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _isEnglish
                                      ? "Selected ${_getSelectedTitle(_isEnglish)}"
                                      : "تم اختيار ${_getSelectedTitle(_isEnglish)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: _getSelectedColor().withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _isEnglish ? "Selected" : "محدد",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // زر المتابعة
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _selectedGender != null ? _continue : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getSelectedColor(),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            // ignore: deprecated_member_use
                            shadowColor: _getSelectedColor().withOpacity(0.5),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      _isEnglish
                                          ? "Continue"
                                          : "متابعة إلى التطبيق",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }

  String _getSelectedTitle(bool isEnglish) {
    if (_selectedGender == 'male') {
      return isEnglish ? 'Male' : 'ذكر';
    }
    if (_selectedGender == 'female') {
      return isEnglish ? 'Female' : 'أنثى';
    }
    return '';
  }

  Color _getSelectedColor() {
    if (_selectedGender == 'male') return Color(0xFF2196F3);
    if (_selectedGender == 'female') return Color(0xFFE91E63);
    return Colors.grey;
  }

  IconData _getSelectedIcon() {
    if (_selectedGender == 'male') return Icons.male;
    if (_selectedGender == 'female') return Icons.female;
    return Icons.person;
  }

  void _continue() async {
    setState(() => _isLoading = true);

    // محاكاة عملية الحفظ
    await Future.delayed(Duration(milliseconds: 800));

    // هنا يمكنك حفظ اللغة المختارة إذا أردت
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isEnglish', _isEnglish);
    // await prefs.setString('gender', _selectedGender!);

    setState(() => _isLoading = false);

    // الانتقال للشاشة التالية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AgeSelectionScreen(
          isEnglish: _isEnglish,
          selectedGender: _selectedGender,
        ),
      ),
    );
  }
}
