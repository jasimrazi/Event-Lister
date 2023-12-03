import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [
          Align(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'TITLE',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1531297484001-80022131f5a1?q=80&w=1420&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Container(
                    height: 80,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 10,
                        height: 6.0,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 204, 204, 204),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Venue',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 204, 204, 204),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                        ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 204, 204, 204),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                        ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 204, 204, 204),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Registration Link',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 204, 204, 204),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Approve'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}