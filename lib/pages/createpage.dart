import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController clubController =
      TextEditingController(text: 'Connect');

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  PickedFile? _image;

  bool isLoading = false;

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    venueController.dispose();
    regLinkController.dispose();
    clubController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    clubController.text = 'Connect';
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
  }

  Future<String?> uploadImageToStorage() async {
    if (_image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('event_images/${DateTime.now()}.png');

    final metadata = SettableMetadata(
      contentType: 'image/png',
    );

    try {
      await imageRef.putFile(File(_image!.path), metadata);
      final imageUrl = await imageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addEvent(
    String eventName,
    String description,
    String venue,
    String regLink,
    String club,
    DateTime eventDateTime,
    PickedFile? image,
  ) async {
    setState(() {
      isLoading = true;
    });

    final formattedDate = DateFormat('yyyy-MM-dd').format(eventDateTime);
    final formattedTime =
        '${eventDateTime.hour.toString().padLeft(2, '0')}:${eventDateTime.minute.toString().padLeft(2, '0')}';

    final imageUrl = await uploadImageToStorage();

    try {
      await FirebaseFirestore.instance.collection('Events').add({
        'Event name': eventName,
        'Description': description,
        'Venue': venue,
        'Link': regLink,
        'Club': club,
        'Event Date': formattedDate,
        'Event Time': formattedTime,
        'Image URL': imageUrl,
        'Timestamp': FieldValue.serverTimestamp(),
      });

      showSnackBar('Event added successfully', context);
    } catch (e) {
      print('Error adding event: $e');
    } finally {
      setState(() {
        isLoading = false;
      });

      // Clear fields and reset UI
      eventNameController.clear();
      descriptionController.clear();
      venueController.clear();
      regLinkController.clear();
      setState(() {
        selectedDate = DateTime.now();
        selectedTime = TimeOfDay.now();
        _image = null;
      });
    }
  }

  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
      });
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = user?.email ?? "No user";

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Text("Signed in as: $userEmail"),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _getImage,
                    child: Text(
                      'Pick Poster',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  if (_image != null)
                    Image.file(
                      File(_image!.path),
                      height: 100,
                      width: 100,
                    ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Event Name',
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                controller: eventNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description',
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Venue',
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                controller: venueController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Registration Link',
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                controller: regLinkController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Club',
                style: TextStyle(fontSize: 15),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: clubController.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      clubController.text = newValue ?? '';
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                    filled: true,
                    fillColor: Color(0xFFe8e8e8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: [
                    'Connect',
                    'NCC',
                    'NSS',
                    'Union',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Event Date',
                        style: TextStyle(fontSize: 15),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          '${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Event Time',
                        style: TextStyle(fontSize: 15),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: Text(
                          '${selectedTime.format(context)}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  addEvent(
                    eventNameController.text.trim(),
                    descriptionController.text.trim(),
                    venueController.text.trim(),
                    regLinkController.text.trim(),
                    clubController.text.trim(),
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                    _image,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Color(0xFF3392ff),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextButton(
                onPressed: signOut,
                style: TextButton.styleFrom(
                  primary: Color(0xFF263624),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                child: Text("Log Out"),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
