import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () async {
                User? user =
                    await AuthService.signInWithGoogle(context: context);

                if (user != null) {
                  GoRouter.of(context).pushReplacementNamed('home');
                } else {
                  print('error');
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.logo_dev), Text("Sign in with Google")],
              ))),
    );
  }
}
