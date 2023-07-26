// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/forgot_pass.dart';
import 'package:flutter_application/modules/front_page.dart';
import 'package:flutter_application/modules/home_page.dart';
import 'package:flutter_application/modules/widgets/back_button.dart';
import 'package:flutter_application/modules/sharedwidget/loading.dart';

import 'modules/sharedwidget/page_transition.dart';

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

  bool loading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(text: 'Loading . . . ') : Scaffold(
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
                    child: CustomBackButton(
                      onPressed: () {
                         Navigator.push(context, SlidePageRoute(page: FrontPage()));
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
         Navigator.push(context, SlidePageRoute(page: ForgotPass()));
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
             Navigator.push(context, SlidePageRoute(page: FrontPage()));
          },
          child: Text("Sign up"),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => loading = true); // Show the loading screen

      try {
        await Future.delayed(Duration(seconds: 1)); // Simulate a 1-second delay
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        
        _email.clear();
        _password.clear();

        Navigator.push(context, SlidePageRoute(page: HomePage()));

        setState(() {
          _obscurePassword = true;
        });
      } catch (e) {
        setState(() {
          loading = false;
          errorMessage = 'Please check your email and password';
        });
        _showErrorDialog(errorMessage);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 10),
              Text('Unable to Login',
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontWeight: FontWeight.bold,
              )),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'FiraSans',
              fontWeight: FontWeight.normal,
            )),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
