import 'package:flutter/material.dart';
import 'package:flutter_development_123/widgets/complaintlodge.dart';
import 'widgets/complaintstatus.dart';
import './utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/homepage.dart';
import 'registration.dart';
import 'widgets/adminchart.dart';
import 'widgets/escalationchart.dart';
import 'widgets/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      title: 'Login Page',
      routes: {
        "/": (context) => LoginPage(),
        "Login": (context) => LoginPage(),
        MyRoutes.homeRoute2: (context) => HomePage2(),
        "Escalation Report": (context) => EscalationChart(),
        "Admin Chart": (context) => AdminChart(),
        MyRoutes.registrationRoute: (context) => Register(),
        "Home": (context) => HomePage(),
        "Logout": (context) => LoginPage(),
        "Complaint": (context) => ComplaintLodge(),
      },
    );
  }
}
