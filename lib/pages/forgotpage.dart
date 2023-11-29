import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Show success message or navigate to another screen if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      // Show error message in Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 15, fontFamily: 'Roboto Mono'),
            ),
            SizedBox(height: 20.0),
            TextField(
              style: TextStyle(),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFFb7b7b7))),
                  hintText: "test@gmail.com"),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        passwordReset();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color(0xFF3392ff),
                      ),
                      child: Text('Reset',
                          style: TextStyle(
                            fontFamily: 'Roboto Mono',
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
