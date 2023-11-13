import 'package:eventlister/pages/loginpage.dart';
import 'package:eventlister/functions/loginstatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  String? errorMessage;

  Future signUp() async {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // If signup is successful, navigate to another screen (e.g., Home screen)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginStatus()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          // Handle the case where the email is already in use.
          setState(() {
            errorMessage =
                'The email address is already in use. Please use a different email address.';
          });
        } else if (e.code == 'weak-password') {
          // Handle the case where the password is too weak.
          setState(() {
            errorMessage =
                'The password provided is too weak. Please choose a stronger password.';
          });
        } else {
          // Handle other Firebase Auth errors.
          setState(() {
            errorMessage = 'An error occurred. Please try again later.';
          });
        }
      }
    } else {
      setState(() {
        errorMessage = 'The passwords doesn\'t match';
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
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
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: confirmpasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 8.0),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                signUp();
              },
              child: Text('Sign Up'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('Back to Login'))
          ],
        ),
      ),
    );
  }
}
