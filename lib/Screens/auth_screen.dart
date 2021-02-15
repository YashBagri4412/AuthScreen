import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _key = GlobalKey<FormState>();
  final _userNameController = new TextEditingController();
  final _nameFocus = new FocusNode();
  final _passWordFocus = new FocusNode();
  final _passWordController = new TextEditingController();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.bottom;
    final width = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Center(
        child: Container(
          height: height * 0.75,
          width: width * 0.95,
          child: Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 50,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: _nameFocus,
                      onFieldSubmitted: (value) {
                        print(value);
                        _passWordFocus.requestFocus();
                      },
                      controller: _userNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: _passWordFocus,
                      controller: _passWordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
