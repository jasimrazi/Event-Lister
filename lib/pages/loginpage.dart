import 'package:eventlister/pages/forgotpage.dart';
import 'package:eventlister/pages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
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
                      width: 1,
                      color: Color.fromARGB(255, 38, 36, 36),
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 38, 36, 36),
                    )),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 10.0),
              child: Text(
                "Password",
                style: TextStyle(fontSize: 15, fontFamily: 'Roboto Mono'),
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
                      width: 1,
                      color: Color.fromARGB(255, 38, 36, 36),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 38, 36, 36),
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
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()));
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 38, 36, 36),
                )),
                child: Text('Forgot Password?')),
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 38, 36, 36),
                ),
                child: Text('Login',
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      fontSize: 17,
                    )),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 38, 36, 36),
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
