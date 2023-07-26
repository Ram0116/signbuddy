import 'package:flutter/material.dart';
import 'package:flutter_application/modules/sharedwidget/page_transition.dart';
import 'package:flutter_application/sign_up.dart';

class AssessmentResult extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const AssessmentResult({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  String getLanguageKnowledge() {
    if (score >= 1 && score <= 3) {
      return "I’m new to English Sign Language";
    } else if (score >= 4 && score <= 5) {
      return "I know some sign language words and phrases";
    } else if (score >= 6 && score <= 8) {
      return "I can have a simple conversation using English Sign Language";
    } else {
      return "Assessment not completed";
    }
  }

  String getCongratulatoryMessage() {
    if (score == totalQuestions) {
      return "Congratulations! You got a perfect score!";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  'Assessment Completed!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'You score: $score/$totalQuestions',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getLanguageKnowledge(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              getCongratulatoryMessage(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  width: 120, // Set the desired width for the button
                  height: 40, // Set the desired height for the button
                  child: ElevatedButton(
                    onPressed: () {
                       Navigator.push(context, SlidePageRoute(page: const SignupPage())); // Handle routing here
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        score == totalQuestions
                            ? Colors.green // Use green color for perfect score
                            : const Color(0xFF5BD8FF),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.grey[700], // Set the desired font color
                      ),
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