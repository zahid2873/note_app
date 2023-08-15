import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/auth/auth_service.dart';
import 'package:note_app/route/route_configuration.dart';

class AuthController extends GetxController {
  User? user;
  bool isLoading = false;
  signIn() async {
    isLoading = true;
    update();
    try {
      user = await AuthService.signInWithGoogle();
      update();
      if (user != null) {
        GoRouter.of(key.currentState!.context).pushReplacementNamed('home');
      }
    } on Exception catch (e) {
      // TODO
    } finally {
      isLoading = false;
      update();
    }
  }

  signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      GoRouter.of(key.currentState!.context).pushReplacementNamed('login');
    } catch (e) {}
  }
}
