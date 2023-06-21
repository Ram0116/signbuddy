// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/front-page/lessons/back_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(18, 50, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 50, left: 16),
                    child: CustomBackButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/'); // Handle routing here
                      },
                    ),
                  ),
                  _header(),
                  _inputField(),
                  SizedBox(height: 10),
                  _forgotPassword(),
                  SizedBox(height: 10),
                  _signup(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    return Column(
      children: [
        SizedBox(height: 40),
        Text(
          "Login",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text("Enter your credentials to login"),
      ],
    );
  }

  _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30),
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
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your email";
            } else if (!value.contains("@")) {
              return "Please enter a valid email";
            }
            return null;
          },
          onSaved: (value) => _email.text = value!.trim(),
        ),
        SizedBox(height: 10),
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
            prefixIcon: Icon(Icons.lock),
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
            }
            return null;
          },
          onSaved: (value) => _password.text = value!.trim(),
          obscureText: _obscurePassword,
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF5A5A5A),
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF5BD8FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
        )
      ],
    );
  }

  _forgotPassword() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/forgotPass');
      },
      child: Text("Forgot Password"),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: Text("Sign up"),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );

        _email.clear();
        _password.clear();

        Navigator.pushNamed(context, '/homePage');

        setState(() {
          _obscurePassword = true;
        });
      } catch (e) {
        // Handle login errors here
        print(e);
      }
    }
  }
}
