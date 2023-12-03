import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  final String eventDocumentId;

  const EventPage({Key? key, required this.eventDocumentId}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Future<DocumentSnapshot> eventData;

  @override
  void initState() {
    super.initState();
    // Fetch event details when the widget is created
    eventData = fetchEventData();
  }

  Future<DocumentSnapshot> fetchEventData() async {
    // Fetch the document with the provided eventDocumentId
    return await FirebaseFirestore.instance
        .collection('Events')
        .doc(widget.eventDocumentId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: eventData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var eventDetails = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        eventDetails['Event name'] ?? '',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1531297484001-80022131f5a1?q=80&w=1420&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Color(0xFFe8e8e8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .transparent, // Add your shadow color here
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Text(
                          eventDetails['Description'] ?? '',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Venue',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Color(0xFFe8e8e8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .transparent, // Add your shadow color here
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Text(
                          eventDetails['Venue'] ?? '',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Color(0xFFe8e8e8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors
                                          .transparent, // Add your shadow color here
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  eventDetails['Event Date'] ?? '',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Color(0xFFe8e8e8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors
                                          .transparent, // Add your shadow color here
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  eventDetails['Event Time'] ?? '',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Register Link',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Color(0xFFe8e8e8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .transparent, // Add your shadow color here
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Text(
                          eventDetails['Link'] ?? '',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(onPressed: () {}, child: Text('Approve'))
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
