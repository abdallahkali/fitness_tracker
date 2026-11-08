import 'package:flutter/material.dart';
import 'body_type_selection.dart';
// ignore: unused_import
import 'package:fitness_tracker/utils/app_language.dart';

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({
    super.key,
    required bool isEnglish,
    String? selectedGender,
  });

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  double selectedAge = 25;
  String _ageCategory = 'شباب';

  final List<Map<String, dynamic>> _ageCategories = [
    {
      'min': 10,
      'max': 12,
      'label': 'طفل',
      'color': Color(0xFF4AC6E9),
      'icon': Icons.child_care,
    },
    {
      'min': 13,
      'max': 19,
      'label': 'مراهق',
      'color': Color(0xFF00C9FF),
      'icon': Icons.emoji_people,
    },
    {
      'min': 20,
      'max': 34,
      'label': 'شباب',
      'color': Color(0xFF92FE9D),
      'icon': Icons.self_improvement,
    },
    {
      'min': 35,
      'max': 49,
      'label': 'راشد',
      'color': Color(0xFFFFC107),
      'icon': Icons.person,
    },
    {
      'min': 50,
      'max': 64,
      'label': 'ناضج',
      'color': Color(0xFFFF9800),
      'icon': Icons.elderly,
    },
    {
      'min': 65,
      'max': 80,
      'label': 'كبير',
      'color': Color(0xFFFF6B6B),
      'icon': Icons.accessible_forward,
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateAgeCategory();
  }

  void _updateAgeCategory() {
    for (var category in _ageCategories) {
      if (selectedAge >= category['min'] && selectedAge <= category['max']) {
        _ageCategory = category['label'];
        break;
      }
    }
  }

  void _onAgeChanged(double value) {
    setState(() {
      selectedAge = value;
      _updateAgeCategory();
    });
  }

  Color _getCurrentColor() {
    for (var category in _ageCategories) {
      if (selectedAge >= category['min'] && selectedAge <= category['max']) {
        return category['color'];
      }
    }
    return Color(0xFF00C9FF);
  }

  IconData _getCurrentIcon() {
    for (var category in _ageCategories) {
      if (selectedAge >= category['min'] && selectedAge <= category['max']) {
        return category['icon'];
      }
    }
    return Icons.person;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          children: [
            // هيدر مضغوط
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // ignore: deprecated_member_use
                  colors: [Colors.transparent, Colors.black.withOpacity(0.2)],
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
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "اختيار العمر",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "حدد عمرك للبدء",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: _getCurrentColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: _getCurrentColor()),
                    ),
                    child: Text(
                      _ageCategory,
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

            Expanded(
              child: SingleChildScrollView(
                // أضف هذا لتفادي الـ Overflow
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // دائرة العمر المضغوطة
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            // ignore: deprecated_member_use
                            _getCurrentColor().withOpacity(0.3),
                            // ignore: deprecated_member_use
                            _getCurrentColor().withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            _getCurrentIcon(),
                            size: 60,
                            color: _getCurrentColor(),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Column(
                              children: [
                                Text(
                                  selectedAge.toInt().toString(),
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  _ageCategory,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // السلايدر المضغوط
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // مؤشرات العمر
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _ageCategories.map((category) {
                                bool isActive =
                                    selectedAge >= category['min'] &&
                                    selectedAge <= category['max'];

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAge = category['min'].toDouble();
                                      _updateAgeCategory();
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? category['color'].withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isActive
                                            ? category['color']
                                            // ignore: deprecated_member_use
                                            : Colors.white.withOpacity(0.1),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          category['icon'],
                                          size: 16,
                                          color: isActive
                                              ? category['color']
                                              : Colors.white70,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          category['label'],
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: isActive
                                                ? category['color']
                                                : Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          SizedBox(height: 20),

                          // السلايدر
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 8,
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 15,
                              ),
                              overlayShape: RoundSliderOverlayShape(
                                overlayRadius: 25,
                              ),
                              activeTrackColor: _getCurrentColor(),
                              // ignore: deprecated_member_use
                              inactiveTrackColor: Colors.white.withOpacity(0.1),
                              thumbColor: Colors.white,
                              // ignore: deprecated_member_use
                              overlayColor: _getCurrentColor().withOpacity(0.2),
                            ),
                            child: Slider(
                              value: selectedAge,
                              min: 10,
                              max: 80,
                              divisions: 70,
                              label: selectedAge.round().toString(),
                              onChanged: _onAgeChanged,
                            ),
                          ),

                          SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "10",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "العمر الحالي: ${selectedAge.toInt()}",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "80",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // زر التالي
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BodyTypeSelectionScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getCurrentColor(),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "متابعة",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_ios_rounded, size: 18),
                          ],
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
  }
}
