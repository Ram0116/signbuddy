import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/modules/assessments/assess_one.dart';
import 'package:flutter_application/modules/choose_language.dart';
import 'package:flutter_application/modules/english_level.dart';
import 'package:flutter_application/modules/sharedwidget/page_transition.dart';
import 'package:flutter_application/modules/widgets/back_button.dart';
import 'package:flutter_application/modules/sharedwidget/loading.dart';

class Classify extends StatefulWidget {
  const Classify({Key? key}) : super(key: key);

  @override
  State<Classify> createState() => _ClassifyState();
}

class _ClassifyState extends State<Classify> {
  final List<Map<String, dynamic>> classifyAs = [
    {'status': 'Deaf or Hard-of-Hearing'},
    {'status': 'Speech Impaired'},
    {'status': 'Non-Disabled'},
  ];

  String? selectedClassify;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading(text: 'Loading . . . ')
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/bg-signbuddy.png'), // Replace with your background image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 50, left: 16),
                    child: CustomBackButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            SlidePageRoute(
                                page:
                                    const ChooseLanguages())); // Handle routing here
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                    child: const Text(
                      'Do you classify as?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 40), // Adjust the spacing here
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: classifyAs.length,
                      itemBuilder: (context, index) {
                        final classify = classifyAs[index];
                        final isSelected =
                            selectedClassify == classify['status'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.deepPurpleAccent
                                      : Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedClassify = classify['status'];
                                  });
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15.0),
                                title: Text(
                                  classify['status'],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 28),
                      child: SizedBox(
                        width: 120, // Set the desired width for the button
                        height: 40, // Set the desired height for the button
                        child: ElevatedButton(
                          onPressed: selectedClassify != null
                              ? () =>
                                  _navigateToLevel(context, selectedClassify!)
                              : null,
                          style: ButtonStyle(
                            backgroundColor: selectedClassify != null
                                ? MaterialStateProperty.all<Color>(
                                    const Color(0xFF5BD8FF))
                                : MaterialStateProperty.all<Color>(const Color(
                                    0xFFD3D3D3)), // Set a different color when no choice is selected
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors
                                  .grey[700], // Set the desired font color
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

  Future<void> _navigateToLevel(BuildContext context, String classify) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Store the classification data in Firestore under the user's UID
        await FirebaseFirestore.instance
            .collection('userData')
            .doc(currentUser.uid)
            .set({'classification': classify}, SetOptions(merge: true));

        setState(() => loading = true);

        // Navigate to the desired page based on the classification
        switch (classify) {
          case 'Non-Disabled':
            Navigator.push(
                context, SlidePageRoute(page: const AssessmentOne()));
            break;
          case 'Deaf or Hard-of-Hearing':
            Navigator.push(
                context, SlidePageRoute(page: const AssessmentOne()));
            break;
          case 'Speech Impaired':
            Navigator.push(
                context, SlidePageRoute(page: const AssessmentOne()));
            break;
          // Add more cases for other classifications...

          default:
            // Handle the case when the classification is not found
            break;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
