import 'dart:ffi';
import 'dart:ui';

import 'package:eventlister/pages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        setState(() {
          errorMessage = e.code;
        });
      } else {
        setState(() {
          errorMessage = e.code;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: TextStyle(color: Color.fromARGB(255, 154, 56, 171)),
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 154, 56, 171)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 154, 56, 171)))),
            ),
            SizedBox(height: 16.0),
            TextField(
              style: TextStyle(color: Color.fromARGB(255, 154, 56, 171)),
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 154, 56, 171)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 154, 56, 171))),
                  suffixIcon: new Icon(Icons.remove_red_eye,
                    
                  ),
                  ),
            ),
            SizedBox(height: 8.0),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  signIn();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 154, 56, 171),
                  ),
                ),
                child: Text('Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    )),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 154, 56, 171),
                )),
                child: Text(
                  'Register Now',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
