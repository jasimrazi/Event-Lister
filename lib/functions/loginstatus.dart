import 'package:eventlister/pages/createpage.dart';
import 'package:eventlister/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginStatus extends StatelessWidget {
  const LoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CreatePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
