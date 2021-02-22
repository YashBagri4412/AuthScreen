import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationFirebase with ChangeNotifier {
  Future<String> authRegister(String username, String password) async {
    final authInstance = FirebaseAuth.instance;
    try {
      await authInstance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> authLogin(String username, String password) async {
    final authInstance = FirebaseAuth.instance;
    try {
      await authInstance.signInWithEmailAndPassword(
          email: username, password: password);
      print("Login successfull");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> googleLogIn() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
