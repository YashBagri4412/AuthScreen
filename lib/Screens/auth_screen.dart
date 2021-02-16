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
  String _userName;
  String _passWord;

  void validateTheData() {
    FocusScope.of(context).unfocus();
    if (_key.currentState.validate()) {
      _userName = _userNameController.text.toString();
      _passWord = _passWordController.text.toString();
      print(_userName);
      print(_passWord);
    }
  }

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
                      keyboardType: TextInputType.emailAddress,
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
                      validator: (value) {
                        value = value.toLowerCase();
                        if (value.isNotEmpty &&
                            value.contains("@") &&
                            value.contains(".com")) {
                          print("Value is correct");
                          return null;
                        } else {
                          _userNameController.clear();
                        }
                        return "Enter Again";
                      },
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
                      validator: (value) {
                        if (value.isEmpty) {
                          _passWordController.clear();
                          return "Enter a Valid password";
                        } else if (value.length < 4) {
                          _passWordController.clear();
                          return "enter a password more than 4 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        onPressed: validateTheData,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Or Login With",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton.icon(
                          icon: Icon(Icons.android),
                          label: Text("Login with google"),
                          onPressed: () {},
                        ),
                      ],
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
