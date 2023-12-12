import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlister/functions/loginstatus.dart';
import 'package:eventlister/pages/eventpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f6f6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 15, color: Color(0xffc9c9c9)),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    prefixIcon:
                        Icon(Icons.search, size: 35, color: Colors.black45),
                    suffixIcon:
                        Icon(Icons.cancel_outlined, color: Colors.black45),
                  ),
                  cursorColor: Colors.black45,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Events')
                      .orderBy('Timestamp', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var eventData = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventPage(eventDocumentId: eventData.id),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15, color: Color(0xffc9c9c9)),
                              ],
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${eventData['Image URL'] ?? ''}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xff3392ff),
                                              ),
                                              child: Text(
                                                "${eventData['Club'] ?? ''}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin:
                                            EdgeInsets.fromLTRB(20, 20, 10, 10),
                                        child: Text(
                                          "${eventData['Event name'] ?? ''}",
                                          style: TextStyle(
                                            color: Color(0xff161616),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.near_me,
                                              size: 20,
                                              color: Color(0xFFb7b7b7),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "${eventData['Venue'] ?? ''}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 20,
                                              color: Color(0xFFb7b7b7),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "${eventData['Event Date'] ?? ''}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginStatus())); // Handle FAB button press
        },
        label: Text(
          'Add',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        icon: Icon(
          Icons.add,
          size: 25,
        ),
        backgroundColor: Color(0xff3392ff),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
