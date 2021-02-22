import 'package:basicAuth/Screens/auth_screen.dart';
import 'package:basicAuth/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//Relative imports
import 'Providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthenticationFirebase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: GoogleFonts.openSans(),
            headline3: GoogleFonts.openSans(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.black87,
            ),
            headline6: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            subtitle1: GoogleFonts.openSans(
              color: Colors.black54,
            ),
            caption: GoogleFonts.openSans(),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, userSnapShot) {
            if (userSnapShot.hasData) {
              return LoggedScreen();
            }
            return AuthScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
