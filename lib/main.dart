// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application/actors.dart';
import 'package:flutter_application/forgot_pass.dart';
import 'package:flutter_application/front-page/choose_language.dart';
import 'package:flutter_application/front-page/classify_as.dart';
import 'package:flutter_application/front-page/english_level.dart';
import 'package:flutter_application/front-page/get_started.dart';
import 'package:flutter_application/front-page/home_page.dart';
import 'package:flutter_application/login_screen.dart';
import 'package:flutter_application/sign_up.dart';
import 'package:flutter_application/front-page/lessons/alphabet.dart';

import 'front-page/front-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyB11pipHQpR1ndV2Uai-yQ2mASvFNBkeGg",
    projectId: "signbuddy-7bced",
    messagingSenderId: "144171204328",
    appId: "1:144171204328:web:2c0a4088029f320aae935d",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sign Buddy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            displayLarge: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            labelLarge: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            // Add more text styles here as needed.
          ),
        ),
        routes: {
          '/f': (context) => FrontPage(),
          '/actors': (context) => Actors(),
          '/get_started': (context) => GetStartedPage(),
          '/signup': (context) => SignupPage(),
          '/chooseLanguage': (context) => ChooseLanguages(),
          '/classify': (context) => Classify(),
          '/langLevel': (context) => Level(),
          '/homePage': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/forgotPass': (context) => ForgotPass(),
          '/basic': (context) => Letters(),
        },
        home: HomePage());
  }
}
