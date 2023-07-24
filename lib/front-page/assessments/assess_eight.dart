import 'package:flutter/material.dart';
import 'package:flutter_application/front-page/assessments/result.dart';
import 'package:flutter_application/front-page/assessments/shuffle_options.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssessmentEight extends StatefulWidget {
  final int score;

  const AssessmentEight({Key? key, required this.score}) : super(key: key);

  @override
  _AssessmentEightState createState() => _AssessmentEightState();
}

class _AssessmentEightState extends State<AssessmentEight> {
  int currentIndex = 0;
  int score = 0;
  bool answerChecked = false;
  int selectedAnswerIndex = -1;
  int correctAnswerIndex = -1;

  final List<Map<String, dynamic>> assessmentQuestions = [
    {
      'question': 'Select the correct sign for "Z"',
      'options': [
        'assess-img/question-eight/s.png',
        'assess-img/question-eight/v.png',
        'assess-img/question-eight/x.png',
        'assess-img/question-eight/z.png',
      ],
      'correctAnswerIndex': 3,
    },
  ];

  void checkAnswer() {
    setState(() {
      answerChecked = true;
      correctAnswerIndex = assessmentQuestions[currentIndex]['correctAnswerIndex'];
      if (selectedAnswerIndex == correctAnswerIndex) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      currentIndex++;
      answerChecked = false;
      selectedAnswerIndex = -1;
      correctAnswerIndex = -1;
    });
  }

  void navigateToResult(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssessmentResult(
          score: widget.score + score,
          totalQuestions: 8,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    shuffleOptions(assessmentQuestions); // Shuffle options when the widget is first initialized
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
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
        duration: const Duration(days: 365),
        dismissDirection: DismissDirection.none,
        action: SnackBarAction(
          label: 'Next',
          textColor: Colors.grey.shade700,
          backgroundColor: Colors.blue.shade200,
          onPressed: () {
            if (currentIndex < assessmentQuestions.length - 1) {
              nextQuestion();
            } else {
              navigateToResult(context);
            }
          },
        ),
      ),
    ).closed.then((reason) {
      setState(() {
        answerChecked = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion = assessmentQuestions[currentIndex];
    String question = currentQuestion['question'];
    List<String> options = currentQuestion['options'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              children: List.generate(options.length, (index) {
                bool isCorrectAnswer = (answerChecked && correctAnswerIndex == index);
                bool isSelectedAnswer = (selectedAnswerIndex == index);

                return GestureDetector(
                  onTap: () {
                    if (!answerChecked) {
                      setState(() {
                        selectedAnswerIndex = index;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isCorrectAnswer
                          ? Colors.green.withOpacity(0.3)
                          : (isSelectedAnswer ? Colors.grey.withOpacity(0.3) : null),
                    ),
                    child: Image.asset(options[index]),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            if (!answerChecked)
              ElevatedButton(
                onPressed: selectedAnswerIndex != -1
                    ? () {
                        checkAnswer();
                        if (selectedAnswerIndex == correctAnswerIndex) {
                          showResultSnackbar(
                            context,
                            'Correct',
                            FontAwesomeIcons.solidCircleCheck,
                          );
                        } else {
                          showResultSnackbar(
                            context,
                            'Incorrect',
                            FontAwesomeIcons.solidCircleXmark,
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color(0xFF5BD8FF),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'FiraSans',
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: const Color(0xFF5A5A5A),
                ),
                child: const Text('Check'),
              ),
          ],
        ),
      ),
    );
  }
}
