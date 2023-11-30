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
  bool passwordVisible = true;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                "Email",
                style: TextStyle(fontSize: 15, fontFamily: 'Roboto Mono'),
              ),
            ),
            TextField(
              style: TextStyle(height: 1),
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xFFb7b7b7))),
                filled: true,
                fillColor: Color(0xFFe8e8e8),
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 10.0),
              child: Text(
                "Password",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              child: TextField(
                style: TextStyle(height: 1),
                controller: passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFFb7b7b7),
                      )),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 10.0),
              child: Text(
                "Confirm Password",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              child: TextField(
                style: TextStyle(height: 1),
                controller: confirmpasswordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFFb7b7b7),
                      )),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  signUp();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Color(0xFF3392ff),
                ),
                child: Text('Sign Up',
                    style: TextStyle(
                      
                      fontSize: 17,
                    )),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 38, 36, 36),
              )),
              child: Text(
                'Back to Login',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
