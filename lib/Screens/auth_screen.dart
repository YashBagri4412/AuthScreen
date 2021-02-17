import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool _gButtonHighlightState = false;
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

  void googleSignIn() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.bottom;
    final width = size.width;
    final widthOfContainer = width * 0.95;
    final heightOfContainer = height * 0.59;
    print("$heightOfContainer + $widthOfContainer");
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Center(
        child: Container(
          height: heightOfContainer,
          width: widthOfContainer,
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
                      height: heightOfContainer * 0.035,
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
                      height: heightOfContainer * 0.020,
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
                      height: heightOfContainer * 0.035,
                    ),
                    Container(
                      width: double.infinity,
                      height: heightOfContainer * 0.077,
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
                      height: heightOfContainer * 0.050,
                    ),
                    Text(
                      "Or Sign Up Using",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Container(
                      child: FlatButton.icon(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: Colors.white,
                        icon: Icon(
                          Icons.android,
                          color: _gButtonHighlightState
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Sign Up With Google",
                          style: (_gButtonHighlightState)
                              ? GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                )
                              : GoogleFonts.openSans(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                        ),
                        highlightColor: Colors.blue,
                        onHighlightChanged: (value) {
                          setState(() {
                            _gButtonHighlightState = value;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: googleSignIn,
                      ),
                    ),
                    SizedBox(
                      height: heightOfContainer * 0.015,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "No Account Yet!",
                              style: Theme.of(context).textTheme.caption,
                            ),
                            FlatButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.openSans(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {},
                            )
                          ],
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
