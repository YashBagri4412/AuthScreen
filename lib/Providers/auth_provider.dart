import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationFirebase with ChangeNotifier {
  Future<void> authRegister(String username, String password) async {
    final authInstance = FirebaseAuth.instance;
    try {
      await authInstance.createUserWithEmailAndPassword(
          email: username, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("Password Provided is weak");
      } else if (e.code == "email-already-exists") {
        print("email already in use");
      } else if (e.code == "invalid-email") {
        print("invalid email");
      } else if (e.code == "operation-not-allowed") {
        print("Operation not allowed");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> authLogin(String username, String password) async {
    final authInstance = FirebaseAuth.instance;
    try {
      await authInstance.signInWithEmailAndPassword(
          email: username, password: password);
      print("Login successfull");
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("user not found!!");
      } else if (e.code == "invalid-email") {
        print("invalid-email");
      } else if (e.code == "user-disabled") {
        print("user-disabled");
      } else if (e.code == "wrong-password") {
        print("wrong-password");
      }
    } catch (e) {
      print(e);
    }
  }
}
