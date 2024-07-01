import 'package:firestore_auth/controllers/register_controller.dart';
import 'package:firestore_auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  "Registration",
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
                    onPressed: submit,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Submit"),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const LoginScreen()));
                    },
                    child: const Text("LogIn"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
