import 'package:flutter/material.dart';

class AssessmentResult extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const AssessmentResult({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Assessment Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $score/$totalQuestions',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the assessment
              },
              child: const Text('Restart Assessment'),
            ),
          ],
        ),
      ),
    );
  }
}
