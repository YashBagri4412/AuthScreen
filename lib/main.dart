import 'package:basicAuth/Screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.openSans(),
          headline3: GoogleFonts.openSans(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Colors.black87,
          ),
        ),
      ),
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
