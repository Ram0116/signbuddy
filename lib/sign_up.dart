import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/front-page/lessons/widgets/back_button.dart';
import 'package:flutter_application/front-page/lessons/sharedwidget/loading.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  bool loading = false;


  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading(text: 'Loading . . . ',) : SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 0, 20, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/get_started'); // Handle routing here
                    },
                  ),
                ),
                const SizedBox(height: 20),
                _header(),
                const SizedBox(height: 40),
                _inputField(),
                const SizedBox(height: 20),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    return const Column(
      children: [
        Text(
          "Sign up",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text("We would like to learn more about you"),
      ],
    );
  }

  _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                child: TextFormField(
                  controller: _firstName,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: _lastName,
                decoration: InputDecoration(
                  hintText: "Last Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _email,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.mail),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your email";
            } else if (!RegExp(
                    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                .hasMatch(value)) {
              return "Please enter a valid email";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _password,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              child: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your password";
            } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
                .hasMatch(value)) {
              return 'Password must:\n- Be at least 8 characters long\n- Contain at least one uppercase letter\n- Contain at least one digit';
            }
            return null;
          },
          obscureText: _obscurePassword,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _confirmPassword,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              child: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please re-enter your password";
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            } else if (value != _password.text) {
              return "Passwords do not match";
            }
            return null;
          },
          obscureText: _obscureConfirmPassword,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5BD8FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF5A5A5A),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text(
            "Log in",
            style: TextStyle(
              color: Color(0xFF5BD8FF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {

       //show the loading screen
      setState(() => loading = true); 

      try {

        // loading screen time
        await Future.delayed(const Duration(seconds: 2));

        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null && currentUser.isAnonymous) {
          // Convert the anonymous account to a permanent account
          AuthCredential credential = EmailAuthProvider.credential(
            email: _email.text,
            password: _password.text,
          );
          UserCredential userCredential =
              await currentUser.linkWithCredential(credential);

          // Retrieve the updated user ID
          final String userId = userCredential.user!.uid;

          // Get the existing user data (gathered before signing up)
          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('userData')
              .doc(currentUser.uid)
              .get();
          Map<String, dynamic> existingData =
              userSnapshot.data() as Map<String, dynamic>? ?? {};

          // Merge the existing data with the new data
          Map<String, dynamic> newData = {
            'firstName': _firstName.text,
            'lastName': _lastName.text,
            'email': _email.text,
            'isNewAccount': true
          };
          newData.addAll(existingData);

          // Store the merged data in Firestore with the document named after the user UID
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(userId)
              .set(newData);

          // Perform any additional actions or navigate to the desired screen
          Navigator.pushNamed(context, '/chooseLanguage');
        } else {
          // Create a new permanent Firebase account
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );

          // Retrieve the user ID
          final String userId = userCredential.user!.uid;

          // Store the data in Firestore with the document named after the user UID
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(userId)
              .set({
            'firstName': _firstName.text,
            'lastName': _lastName.text,
            'email': _email.text,
            'isNewAccount': true
          });

          // Perform any additional actions or navigate to the desired screen
          Navigator.pushNamed(context, '/chooseLanguage');
        }
      } catch (e) {

         setState(() {
          loading = false;
        });
        print(e.toString());
      }
    }
  }
}
