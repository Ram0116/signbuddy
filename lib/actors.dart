import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/front-page/lessons/widgets/back_button.dart';

class Actors extends StatefulWidget {
  const Actors({Key? key}) : super(key: key);

  @override
  State<Actors> createState() => _ActorsState();
}

class _ActorsState extends State<Actors> {
  final List<Map<String, dynamic>> user = [
    {'user_actor': 'User Client'},
    {'user_actor': 'PDAO Employee'},
  ];

  String? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 30, left: 14),
            child: CustomBackButton(
              onPressed: () {
                Navigator.pushNamed(context, '/'); // Handle routing here
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: const Text(
              'You are?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final userAs = user[index];
                final isSelected = selectedUser == userAs['user_actor'];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUser = userAs['user_actor'];
                      });
                    },
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        title: Text(
                          userAs['user_actor'],
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
              padding: const EdgeInsets.only(right: 30),
              child: SizedBox(
                width: 120, // Set the desired width for the button
                height: 40, // Set the desired height for the button
                child: ElevatedButton(
                  onPressed: selectedUser != null
                      ? () => _navigateToStart(context, selectedUser!)
                      : null,
                  style: ButtonStyle(
                    backgroundColor: selectedUser != null
                        ? MaterialStateProperty.all<Color>(
                            const Color(0xFF5BD8FF))
                        : MaterialStateProperty.all<Color>(const Color(
                            0xFFD3D3D3)), // Set a different color when no choice is selected
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
    );
  }

  void _navigateToStart(BuildContext context, String userAs) async {
    try {
      // Sign in the user anonymously
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      final User? currentUser = userCredential.user;

      if (currentUser != null) {
        // Retrieve the user ID
        final String userId = currentUser.uid;

        // Store the data in Firestore with the document named after the user UID
        await FirebaseFirestore.instance
            .collection('userData')
            .doc(userId)
            .set({
          // Specify the data you want to store
          'selectedUser': userAs,
        });

        // Navigate to the appropriate page based on the selected user
        switch (userAs) {
          case 'User Client': // Update the comparison here
            Navigator.pushNamed(context, '/get_started');
            break;
          case 'PDAO Employee':
            // Add the navigation logic for PDAO Employee here
            break;
          default:
            // Handle the case when the actor is not found
            break;
        }
      }
    } catch (e) {
      print('Failed to store data for anonymous user: $e');
    }
  }
}
