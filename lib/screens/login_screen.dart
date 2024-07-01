import 'package:firestore_auth/controllers/register_controller.dart';
import 'package:firestore_auth/screens/home_screen.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:firestore_auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final registerController = RegisterController();

  String? email;
  String? password;
  submit() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      await registerController.register(email!, password!);
    }
  }

  submitLogin() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      await registerController.login(email!, password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                TextFormField(
                  onSaved: (newValue) {
                    email = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Login")),
                ),
                const Gap(10),
                TextFormField(
                  onSaved: (newValue) {
                    password = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter Password")),
                ),
                const Gap(20),
                FilledButton(
                    onPressed: submitLogin,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Submit"),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const RegisterScreen()));
                    },
                    child: const Text("SignUp"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
