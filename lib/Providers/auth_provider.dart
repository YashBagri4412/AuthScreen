import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthenticationFirebase with ChangeNotifier {
  Future<void> authRegister(String username, String password) async {
    final authInstance = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await authInstance
          .createUserWithEmailAndPassword(email: username, password: password);
      print(userCredential.user.email);
      print(userCredential.user.uid);
      print("user entered");
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("Password Provided is weak");
      } else if (e.code == "email-already-exists") {
        print("email already in use");
      }
    } catch (e) {
      print(e);
    }
  }
}
