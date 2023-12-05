import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return SafeArea(
      child: Scaffold(
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
                        SizedBox(
                          height: 50,
                        ),
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
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            image: DecorationImage(
                              image: NetworkImage(
                                eventDetails['Image URL'] ?? '',
                              ),
                              // fit: BoxFit.cover,
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
                                color: Colors.transparent,
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
                                color: Colors.transparent,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        color: Colors.transparent,
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
                            SizedBox(
                              width: 40,
                            ),
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
                                        color: Colors.transparent,
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
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            try {
                              final Uri _url =
                                  Uri.parse(eventDetails['Link'] ?? '');
                              launchUrl(_url);
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
