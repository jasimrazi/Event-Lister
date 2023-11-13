import 'package:eventlister/functions/firebase_options.dart';
import 'package:eventlister/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Lister',
      theme: ThemeData(fontFamily: GoogleFonts.anekMalayalam().fontFamily),
      routes: {
        '/home': (context) => HomePage(),
        // Add other routes as needed
      },
      home: HomePage(), // Set your LoginPage as the initial page
    );
  }
}
