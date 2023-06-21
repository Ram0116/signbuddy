import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/front-page/lessons/back_button.dart';

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  int? selectedLevelIndex;

  final List<Map<String, dynamic>> levels = [
    {
      'level': 'I’m new to English Sign Language',
      'iconlevel': 'level1.png',
    },
    {
      'level': 'I know some sign language words and phrases',
      'iconlevel': 'level2.png',
    },
    {
      'level': 'I can have simple conversation using English Sign Language',
      'iconlevel': 'level3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.pushNamed(
                      context, '/classify'); // Handle routing here
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: const Text(
                'How much English Sign Language do you know?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  final level = levels[index];
                  final isSelected = selectedLevelIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
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
                              selectedLevelIndex = index;
                            });
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              'assets/${level['iconlevel']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            level['level'],
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
                padding: const EdgeInsets.only(right: 33, bottom: 120),
                child: SizedBox(
                  width: 120, // Set the desired width for the button
                  height: 40,
                  child: ElevatedButton(
                    onPressed: selectedLevelIndex != null
                        ? () => _navigateToHomePage(context)
                        : null,
                    child: const Text('Continue'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToHomePage(BuildContext context) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String selectedLevel = levels[selectedLevelIndex!]['level'];

        // Store the selected level data in Firestore under the user's UID
        await FirebaseFirestore.instance
            .collection('userData')
            .doc(currentUser.uid)
            .set({'selectedLevel': selectedLevel}, SetOptions(merge: true));

        // Navigate to the home page
        Navigator.pushNamed(context, '/homePage');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
