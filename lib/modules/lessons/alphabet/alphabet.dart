import 'package:flutter/material.dart';
import 'package:flutter_application/modules/lessons/alphabet/a-c/lesson_a.dart';
import 'package:flutter_application/modules/lessons/alphabet/d-f/lesson_d.dart';
import 'package:flutter_application/modules/sharedwidget/page_transition.dart';
import 'package:flutter_application/modules/widgets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Letters extends StatefulWidget {
  const Letters({Key? key}) : super(key: key);

  @override
  State<Letters> createState() => _LettersState();
}

class _LettersState extends State<Letters> {
  final List<Map<String, dynamic>> lessonLetters = [
    {'letter': 'Alphabet A-C', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet D-F', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet G-I', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet J-L', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet M-O', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet P-R', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet S-U', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet V-X', 'subtext': 'Learn new signs', 'lessonPage': 1},
    {'letter': 'Alphabet Y-Z', 'subtext': 'Learn new signs', 'lessonPage': 1},
  ];

  late SharedPreferences prefs;
  int overallProgressABC = 0;
  int overallProgressDEF = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    prefs = await SharedPreferences.getInstance();
    int progressA = prefs.getInt('lesson_a_progress') ?? 1;
    int progressB = prefs.getInt('lesson_b_progress') ?? 1;
    int progressC = prefs.getInt('lesson_c_progress') ?? 1;
    int progressD = prefs.getInt('lesson_d_progress') ?? 1;
    int progressE = prefs.getInt('lesson_e_progress') ?? 1;
    int progressF = prefs.getInt('lesson_f_progress') ?? 1;

      overallProgressABC = (progressA + progressB + progressC ) ~/ 3;
      overallProgressDEF = (progressD + progressE + progressF ) ~/ 3;
      setState(() {});
      }

  void navigateToLesson(String letter, int lessonPage) {
    switch (letter) {
      case 'Alphabet A-C':
        Navigator.push(
          context,
          SlidePageRoute(page: LessonA(lessonPage: lessonPage)),
        );
        break;
      case 'Alphabet D-F':
      Navigator.push(
          context,
          SlidePageRoute(page: LessonD(lessonPage: lessonPage)),
        );
        // Add navigation to LessonD here if you have it.
        break;
      // Add cases for other lessons here
      default:
        // Handle other cases if needed
        break;
    }
  }


Widget _buildCircularProgressIndicatorABC() {
  double progress = overallProgressABC == 0 ? 0 : overallProgressABC / 3;
  int percentage = (progress * 100).toInt();

  return Container(
    margin: const EdgeInsets.only(top: 16),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          strokeWidth: 4,
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            int displayPercentage = (value * 100).toInt();
            return Text(
              '$displayPercentage%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildCircularProgressIndicatorDEF() {
  double progress = overallProgressDEF == 0 ? 0 : overallProgressDEF / 3;
  int percentage = (progress * 100).toInt();

  return Container(
    margin: const EdgeInsets.only(top: 16),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          strokeWidth: 4,
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            int displayPercentage = (value * 100).toInt();
            return Text(
              '$displayPercentage%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            );
          },
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 100,
              maxHeight: 150,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF5A96E3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 36, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/homePage');
                          },
                        ),
                      ),
                      const Visibility(
                        child: Text(
                          'Learn Alphabets',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/lesson-icon/img1.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final lesson = lessonLetters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: const Icon(Icons.menu_book_outlined, size: 30),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              lesson['letter'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (lesson['letter'] == 'Alphabet A-C')
                            _buildCircularProgressIndicatorABC(),
                            if (lesson['letter'] == 'Alphabet D-F')
                             _buildCircularProgressIndicatorDEF(),
                        ],
                      ),
                      subtitle: Text(lesson['subtext']),
                      onTap: () {
                        navigateToLesson(lesson['letter'], lesson['lessonPage']);
                      },
                    ),
                  ),
                );
              },
              childCount: lessonLetters.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
