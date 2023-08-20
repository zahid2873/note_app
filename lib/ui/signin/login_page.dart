import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(child: GetBuilder<AuthController>(builder: (authController) {
          return authController.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    authController.signIn();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://cdn-icons-png.flaticon.com/128/300/300221.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 5,),
                      const Text("Sign in with Google")
                    ],
                  ));
        })),
      ),
    );
  }
}
