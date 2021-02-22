import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//Relative Imports
import '../Providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _key = GlobalKey<FormState>();

  final _nameFocus = new FocusNode();
  final _passWordFocus = new FocusNode();
  final _confirmPswFocus = new FocusNode();
  final _passWordController = new TextEditingController();
  final _confirmPswController = new TextEditingController();
  final _userNameController = new TextEditingController();

  bool _isLogin = true;
  bool _progressReq = false;
  bool _gButtonHighlightState = false;
  bool _sButtonHighlightState = false;

  String _userName;
  String _passWord;

  Future<String> _validateTheData(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_key.currentState.validate()) {
      _userName = _userNameController.text.toString();
      _passWord = _passWordController.text.toString();
      if (!_isLogin) {
        try {
          String message =
              await Provider.of<AuthenticationFirebase>(context, listen: false)
                  .authRegister(_userName, _passWord);
          return message;
        } catch (e) {
          print(e);
        }
      } else {
        try {
          String message = await Provider.of<AuthenticationFirebase>(
            context,
            listen: false,
          ).authLogin(_userName, _passWord);
          return message;
        } catch (e) {
          print(e);
        }
      }
      return null;
    }
  }

  void googleSignIn() async {
    String errorMessage;
    setState(() {
      _progressReq = true;
    });
    try {
      errorMessage =
          await Provider.of<AuthenticationFirebase>(context, listen: false)
              .googleLogIn();
    } catch (e) {
      print(e);
    }
    if (errorMessage != null) {
      setState(() {
        _progressReq = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            errorMessage,
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    setState(() {
      _progressReq = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.bottom;
    final width = size.width;
    final widthOfContainer = width * 0.95;
    double heightOfContainer = _isLogin ? height * 0.68 : height * 0.80;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: _progressReq
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                            _isLogin ? "LOGIN" : "SIGN UP!",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
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
                                  return null;
                                } else {
                                  _userNameController.clear();
                                }
                                return "Enter Again";
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              obscureText: true,
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
                          ),
                          if (!_isLogin)
                            SizedBox(
                              height: 5,
                            ),
                          if (!_isLogin)
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                obscureText: true,
                                focusNode: _confirmPswFocus,
                                controller: _confirmPswController,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
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
                                    return "Enter a password more than 4 characters";
                                  } else if (_passWordController.text.isEmpty) {
                                    return "Enter Password Before Confirming it!!";
                                  } else if (_passWordController.text.compareTo(
                                              _confirmPswController.text) <
                                          0 ||
                                      _passWordController.text.compareTo(
                                              _confirmPswController.text) >
                                          0) {
                                    return "Passwords dont match!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                _isLogin ? "Login" : "Sign Up",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              onPressed: () async {
                                String errorMessage =
                                    await _validateTheData(context);
                                if (errorMessage != null) {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        errorMessage,
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Or Sign Up Using",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                            child: FlatButton.icon(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
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
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.topCenter,
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
                                    highlightColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      _isLogin ? "Sign Up" : "Login",
                                      style: (_sButtonHighlightState)
                                          ? GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            )
                                          : GoogleFonts.openSans(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                    ),
                                    onHighlightChanged: (value) {
                                      setState(() {
                                        _sButtonHighlightState = value;
                                      });
                                    },
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                      _passWordController.clear();
                                      _userNameController.clear();
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
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
