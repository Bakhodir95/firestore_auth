import 'package:firebase_auth/firebase_auth.dart';

class RegisterController {
  final fireAuth = FirebaseAuth.instance;
  login(String email, String password) async {
    await fireAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  register(String email, String password) async {
    await fireAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  resetPassword(String email) async {
    await fireAuth.sendPasswordResetEmail(email: email);
  }
}
