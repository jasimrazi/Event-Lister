import 'package:eventlister/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController regLinkController = TextEditingController();

  // Method to handle sign out
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home', // Use the route name for your homepage
      (route) => false, // Remove all routes from the stack
    );
  }

  //Method to add events

  Future addEvent(String eventName, String description, String venue,
      String regLink) async {
    await FirebaseFirestore.instance.collection('Events').add({
      'Event name': eventName,
      'Description': description,
      'Venue': venue,
      'Link': regLink,
    });
  }

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    venueController.dispose();
    regLinkController.dispose();
    super.dispose();
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
            Text("Signed in as: $userEmail"),
            SizedBox(height: 20),
            TextField(
              controller: eventNameController,
              decoration: InputDecoration(
                hintText: 'Enter Event Name',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter Description',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Venue',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: venueController,
              decoration: InputDecoration(
                hintText: 'Enter Venue',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Registration Link',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: regLinkController,
              decoration: InputDecoration(
                hintText: 'Enter Registration Link',
              ),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  // Implement your save logic here
                  addEvent(
                    eventNameController.text.trim(),
                    descriptionController.text.trim(),
                    venueController.text.trim(),
                    regLinkController.text.trim(),
                  );
                },
                child: Text('Save')),
            TextButton(
              onPressed: signOut,
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
