import 'package:flutter/material.dart';
import 'package:flutter_application/modules/assessments/assess_seven.dart';
import 'package:flutter_application/modules/sharedwidget/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application/modules/assessments/shuffle_options.dart';



class AssessmentSix extends StatefulWidget {
  final int score;

  const AssessmentSix({Key? key, required this.score}) : super(key: key);

  @override
  _AssessmentSixState createState() => _AssessmentSixState();
}

class _AssessmentSixState extends State<AssessmentSix> {
  int currentIndex = 0;
  int score = 0;
  bool answerChecked = false;
  int selectedAnswerIndex = -1;
  int correctAnswerIndex = -1;

  final List<Map<String, dynamic>> assessmentQuestions = [
    {
      'question': 'What do you think this sign means?',
      'videoUrl': 'assess-img/question-six/baby.gif',
      'options': [
        'assess-img/question-six/baby-img.png',
        'assess-img/question-six/tree-img.png',
      ],
      'correctAnswerIndex': 0,
    },
    // Add more questions as needed
  ];

  void checkAnswer() {
    setState(() {
      if (selectedAnswerIndex != -1) {
        answerChecked = true;
        correctAnswerIndex = assessmentQuestions[currentIndex]['correctAnswerIndex'];
        if (selectedAnswerIndex == correctAnswerIndex) {
          score++;
        }
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

  void navigateToNextAssessment(BuildContext context) {
    if (currentIndex < assessmentQuestions.length - 1) {
      Navigator.push(
        context,
        SlidePageRoute(
          page: AssessmentSix(score: widget.score + score),
        ),
      );
    } else {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AssessmentSeven(score: widget.score + score),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    shuffleOptions(assessmentQuestions);
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
              navigateToNextAssessment(context);
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
    String videoUrl = currentQuestion['videoUrl'];
    List<String> options = (currentQuestion['options'] as List).cast<String>();

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
            // Display Video
            GestureDetector(
              onTap: () {
                if (!answerChecked) {
                  setState(() {
                    selectedAnswerIndex = -1;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  videoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Display Image Choices in a 1x2 grid
            Expanded(
              flex: 2, // Give the grid 2/3 of the available space
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 120, // Specify the height of each grid item
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
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
                   child: SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isCorrectAnswer && answerChecked
                              ? Colors.green // Show green border when the answer is correct and checked
                              : Colors.grey, // Default border color
                          width: 2, // Add border width
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: isSelectedAnswer
                            ? Colors.grey.withOpacity(0.3) // Selected answer has a grey tint
                            : isCorrectAnswer && answerChecked
                                ? Colors.green // Correct answer turns green
                                : Colors.transparent, // Default background color
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: isSelectedAnswer
                            ? ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.grey.withOpacity(0.5), // Change the filter color here (e.g., grey tint)
                                  BlendMode.multiply
                                ),
                                child: Image.asset(
                                  options[index],
                                  fit: BoxFit.cover, // Image covers the entire container without any scaling
                                ),
                              )
                            : Image.asset(
                                options[index],
                                fit: BoxFit.cover, // Image covers the entire container without any scaling
                              ),
                      ),
                    ),
                  ),
                  );
                },
              ),
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