import 'package:eventlister/loginpage.dart';
import 'package:eventlister/loginstatus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(blurRadius: 15, color: Color(0xffc9c9c9)),
                        // ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
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
                                      "https://w0.peakpx.com/wallpaper/138/244/HD-wallpaper-gray-and-black-laptop-computer-on-surface.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      margin: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            Color.fromARGB(255, 154, 56, 171),
                                      ),
                                      child: Text(
                                        "connect",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 8),
                                      margin: EdgeInsets.all(8),
                                      child: Text(
                                        "900 Interested",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 25,
                                            color:
                                                Color.fromARGB(255, 78, 78, 78),
                                          ),
                                          Text("  Bezier Stadium"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            size: 25,
                                            color:
                                                Color.fromARGB(255, 78, 78, 78),
                                          ),
                                          Text(" July 17, 2022"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 51, 49, 49),
                                  ),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Register Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 51, 49, 49),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.fromLTRB(8, 0, 20, 0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 51, 49, 49),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.upload,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginStatus())); // Handle FAB button press
        },
        child: Icon(Icons.playlist_add),
        backgroundColor: Color(0xff333131),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
