import 'package:flutter/material.dart';
import 'package:flutter_application/modules/lessons/alphabet/a-c/lesson_c.dart';
import 'package:flutter_application/modules/lessons/alphabet/alphabet.dart';
import 'package:flutter_application/modules/sharedwidget/page_transition.dart';
import 'package:flutter_application/modules/widgets/back_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application/modules/assessments/shuffle_options.dart';

class LessonB extends StatefulWidget {
    const LessonB({Key? key, required int lessonPage}) : super(key: key);

  @override
  State<LessonB> createState() => _LessonBState();
}

class _LessonBState extends State<LessonB> {
  int lessonPage = 1;
  int maxPages = 3; // Change this to the maximum number of pages in the lesson
  SharedPreferences? prefs;
  int score = 0;
  int currentIndex = 0;
  bool answerChecked = false;
  int selectedAnswerIndex = -1;
  int correctAnswerIndex = -1;

  final List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'Which one here is the "B" sign language?',
      'options': [
        'assets/alphabet-lesson/a-c-img/a.png',
        'assets/alphabet-lesson/a-c-img/h.png',
        'assets/alphabet-lesson/a-c-img/b.png',
        'assets/alphabet-lesson/a-c-img/m.png',
      ],
      'correctAnswerIndex': 2,
    },
  ];

@override
  void initState() {
    super.initState();
    _loadProgress();
    shuffleOptions(quizQuestions);
  }

  Future<void> _loadProgress() async {
    prefs = await SharedPreferences.getInstance();
    int? savedPage = prefs?.getInt('lesson_b_progress') ?? 1;
    setState(() {
      lessonPage = savedPage;
      // Additional logic to navigate to a specific page based on the saved progress.
      if (lessonPage == maxPages) {
        Navigator.push(
          context,
          SlidePageRoute(
            page: LessonC(lessonPage: lessonPage,),
          ),
        );
      }
    });
  }

  void _saveProgress() async {
    prefs?.setInt('lesson_b_progress', lessonPage);
  }

  void _nextPage() {
    setState(() {
      lessonPage++;
      if (lessonPage > maxPages) {
        lessonPage = maxPages;
      }
      _saveProgress();

      if (lessonPage > maxPages) {
        Navigator.push(
          context,
          SlidePageRoute(
            page: LessonC(lessonPage: lessonPage,),
          ),
        );
      }
    });
  }

  void navigateToNextLesson(BuildContext context) {
    if (currentIndex < quizQuestions.length - 1) {
      _nextPage();
    } else {
      if (score == quizQuestions.length) {
        Navigator.push(
          context,
          SlidePageRoute(
            page: LessonC(lessonPage: lessonPage,),
          ),
        );
      } else {
        setState(() {
          lessonPage = 1;
          currentIndex = 0;
          score = 0;
          answerChecked = false;
          selectedAnswerIndex = -1;
          correctAnswerIndex = -1;
        });
      }
    }
  }

  void showResultSnackbar(BuildContext context, String message, IconData icon) {
    Color backgroundColor;
    Color fontColor;
    TextStyle textStyle;

    if (message == 'Correct') {
      backgroundColor = Colors.green.shade100;
      fontColor = Colors.green;
      textStyle = TextStyle(
        color: fontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'FiraSans',
      );
    } else {
      backgroundColor = Colors.red.shade100;
      fontColor = Colors.red;
      textStyle = TextStyle(
        color: fontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'FiraSans',
      );
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: fontColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    message,
                    style: textStyle,
                  ),
                ],
              ),
            ),
            backgroundColor: backgroundColor,
            duration: const Duration(days: 365), // Change duration as needed
            dismissDirection: DismissDirection.none,
            action: SnackBarAction(
              label: 'Next',
              textColor: Colors.grey.shade700,
              backgroundColor: Colors.blue.shade200,
              onPressed: () {
                if (currentIndex < quizQuestions.length - 1) {
                  _nextPage();
                } else {
                  navigateToNextLesson(context);
                }
              },
            ),
          ),
        )
        .closed
        .then((reason) {
          setState(() {
            answerChecked = false;
          });
        });
  }

  Widget _buildPageContent() {
    switch (lessonPage) {
      case 1:
        return _buildSignLanguageVideo();
      case 2:
        return _buildWordStartsWithA();
      case 3:
        return _buildQuiz(); // Show the quiz on the 3rd page
      default:
        return Container(); // Replace this with an appropriate default content widget
    }
  }

  Widget _buildSignLanguageVideo() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'This is the sign language for letter "B"',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/alphabet-lesson/a-c-img/b.png',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWordStartsWithA() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'This is how you sign "Baby"',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/alphabet-lesson/a-c-img/baby.gif',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuiz() {
    Map<String, dynamic> currentQuestion = quizQuestions[currentIndex];
    List<String> options = currentQuestion['options'];
    int correctAnswerIndex = currentQuestion['correctAnswerIndex'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          currentQuestion['question'],
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 50),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return _buildOption(index, options[index], correctAnswerIndex);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildOption(int index, String option, int correctAnswerIndex) {
    bool isCorrectAnswer = index == correctAnswerIndex;
    bool isSelected = index == selectedAnswerIndex;
    Color tileColor =
        isSelected ? Colors.grey.withOpacity(0.5) : Colors.transparent;
    if (answerChecked) {
      if (isCorrectAnswer) {
        tileColor = Colors.green.withOpacity(0.3); // Correct answer color
      } else if (isSelected) {
        tileColor =
            Colors.red.withOpacity(0.3); // Incorrect selected answer color
      }
    }

    return GestureDetector(
      onTap: () {
        if (!answerChecked) {
          setState(() {
            selectedAnswerIndex = index;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: tileColor,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(
              option,
            ),
          ),
        ),
      ),
    );
  }

  void _checkAnswer() {
    Map<String, dynamic> currentQuestion = quizQuestions[currentIndex];
    correctAnswerIndex = currentQuestion['correctAnswerIndex'];

    setState(() {
      answerChecked = true;
      if (selectedAnswerIndex == correctAnswerIndex) {
        score++;
      }
    });
  }


// Parent widget Tree
  @override
  Widget build(BuildContext context) {
    Widget nextButton;
    if (lessonPage < maxPages) {
      nextButton = TextButton(
        onPressed: _nextPage,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.arrowRight,
              color: Color(0xFF5BD8FF),
            ),
            SizedBox(height: 7),
            Text(
              'Next',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else {
      bool isOptionSelected = selectedAnswerIndex != -1;
      bool isButtonEnabled = answerChecked || isOptionSelected;
      double iconOpacity = isButtonEnabled ? 1.0 : 0.6;

      nextButton = TextButton(
        onPressed: () {
          if (answerChecked) {
            _nextPage();
          } else {
            if (isOptionSelected) {
              _checkAnswer();
              if (selectedAnswerIndex == correctAnswerIndex) {
                showResultSnackbar(
                  context,
                  'Correct',
                  FontAwesomeIcons.solidCheckCircle,
                );
              } else {
                showResultSnackbar(
                  context,
                  'Incorrect',
                  FontAwesomeIcons.solidTimesCircle,
                );
              }
            }
          }
        },
        // Disable the button if no option is selected
        style: ButtonStyle(
          backgroundColor: isButtonEnabled
              ? MaterialStateProperty.all<Color>(Colors.transparent)
              : MaterialStateProperty.all<Color>(Colors.transparent),
          overlayColor: isButtonEnabled
              ? MaterialStateProperty.all<Color>(Colors.transparent)
              : MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: iconOpacity,
              child: Icon(
                answerChecked
                    ? FontAwesomeIcons.arrowRight
                    : FontAwesomeIcons.check,
                color: const Color(0xFF5BD8FF),
              ),
            ),
            const SizedBox(height: 7),
            Opacity(
              opacity: isButtonEnabled ? 1.0 : 0.6,
              child: Text(
                answerChecked ? 'Next' : 'Check',
                style: TextStyle(
                  color: Colors.black.withOpacity(isButtonEnabled ? 1.0 : 0.6),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      SlidePageRoute(
                        page: const Letters(),
                      ));
                },
              ),
            ),
            const SizedBox(height: 70),
            LinearProgressIndicator(
              value: lessonPage / maxPages,
            ),
            const SizedBox(height: 20),
            _buildPageContent(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Material(
                    borderRadius: BorderRadius.zero,
                    child: SizedBox(
                      width: 100,
                      height: 60,
                      child: nextButton,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
