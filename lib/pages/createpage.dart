import 'package:eventlister/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final user = FirebaseAuth.instance.currentUser;

  // Method to handle sign out
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home', // Use the route name for your homepage
      (route) => false, // Remove all routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is not null before accessing email
    final userEmail = user?.email ?? "No user";

    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF0991BC),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                elevation: 18,
              ),
              child: Text(
                "Tech",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            

          ],
        ),
      ),
    );
  }
}
