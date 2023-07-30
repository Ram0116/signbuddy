// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/actors.dart';
import 'package:flutter_application/forgot_pass.dart';
import 'package:flutter_application/modules/assessments/assess_one.dart';
import 'package:flutter_application/modules/assessments/assess_two.dart';
import 'package:flutter_application/modules/assessments/result.dart';
import 'package:flutter_application/modules/choose_language.dart';
import 'package:flutter_application/modules/classify_as.dart';
import 'package:flutter_application/modules/english_level.dart';
import 'package:flutter_application/modules/get_started.dart';
import 'package:flutter_application/modules/home_page.dart';
import 'package:flutter_application/modules/lessons/color.dart';
import 'package:flutter_application/modules/lessons/family.dart';
import 'package:flutter_application/modules/lessons/numbers.dart';
import 'package:flutter_application/modules/lessons/shape.dart';
import 'package:flutter_application/modules/lessons/animals.dart';
import 'package:flutter_application/modules/lessons/nature.dart';
import 'package:flutter_application/modules/lessons/food.dart';
import 'package:flutter_application/modules/lessons/time-and-days.dart';
import 'package:flutter_application/modules/lessons/greeting.dart';

import 'package:flutter_application/login_screen.dart';
import 'package:flutter_application/sign_up.dart';
import 'package:flutter_application/modules/lessons/alphabet.dart';

import 'firebase_options.dart';
import 'modules/front_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int score = 3;
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      child: MaterialApp(
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
        initialRoute: '/',
        routes: {
          '/f': (context) => FrontPage(),
          '/actors': (context) => Actors(),
          '/One': (context) => AssessmentOne(),
          '/get_started': (context) => GetStartedPage(),
          '/signup': (context) => SignupPage(),
          '/chooseLanguage': (context) => ChooseLanguages(),
          '/classify': (context) => Classify(),
          '/langLevel': (context) => Level(),
          '/homePage': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/forgotPass': (context) => ForgotPass(),
          '/basic': (context) => Letters(),
          '/numbers': (context) => Numbers(),
          '/family': (context) => Family(),
          '/colors': (context) => ColorLesson(),
          '/shapes': (context) => Shapes(),
          '/animals': (context) => Animals(),
          '/nature': (context) => Nature(),
          '/food': (context) => Food(),
          '/timeAndDays': (context) => TimeAndDays(),
          '/greeting': (context) => Greetings(),
        },
        home: FrontPage(),
        // // home: AssessmentEight(score: score),
        // home: AssessmentResult(
        //   score: score,
        //   totalQuestions: score,
        // ),
      ),
    );
  }
}
