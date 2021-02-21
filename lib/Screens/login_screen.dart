import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("Logged In !!!"),
          ),
          FlatButton(
            child: Text("Logout"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
