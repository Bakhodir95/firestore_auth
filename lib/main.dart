import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_auth/controllers/quiz_controller.dart';
import 'package:firestore_auth/firebase_options.dart';
import 'package:firestore_auth/models/quiz.dart';
import 'package:firestore_auth/screens/home_screen.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:firestore_auth/screens/quiz_screen.dart';
import 'package:firestore_auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return QuizController();
    }, builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoginScreen();
              }
              return const QuizScreen();
            }),
      );
    });
  }
}
