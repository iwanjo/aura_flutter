// ignore_for_file: prefer_const_constructors
import 'package:aura_flutter/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class Home extends StatefulWidget {
  final String? uid;
  const Home({Key? key, this.uid}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final UserDetails = FutureBuilder(
      future: FirebaseDatabase.instance
          .reference()
          .child("AuraUsers")
          .child(widget.uid!)
          .once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.value['fullname'],
            style: GoogleFonts.nunitoSans(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return CircularProgressIndicator(
            color: const Color(0xff9f2940),
          );
        }
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color(0xfff7f7f7),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              title: Image.asset("assets/aura.png",
                  fit: BoxFit.contain, height: 26.0, width: 26.0),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    tooltip: 'Check your notifications',
                    onPressed: () {}),
              ]),
          body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                  // margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xfffce9ef),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Welcome, ",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                UserDetails,
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Aurabot is coming soon",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                child: (Text(
                                  "Coming Soon",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                )),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff9f2940),
                                  ),
                                ),
                                onPressed: () {}),
                          ]),
                      Image.asset(
                        "assets/aurabot.png",
                        width: 110.0,
                        height: 110.0,
                      ),
                    ],
                  ),
                ),
                // Start of Books Section

                SizedBox(
                  height: 28,
                ),

                Text(
                  "Daily Reads",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 28,
                ),

                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  // margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        "assets/book1.jpeg",
                        width: 80.0,
                        height: 80.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "The Art of Loving",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Erich Fromm",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  // margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        "assets/book2.jpeg",
                        width: 80.0,
                        height: 80.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "The Miracle Morning",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Hal Elrod",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  // margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        "assets/book3.jpeg",
                        width: 80.0,
                        height: 80.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Unbeatable Mind",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Mark Divine",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
                    ],
                  ),
                ),

                SizedBox(
                  height: 28,
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: FutureBuilder(
                      future: FirebaseDatabase.instance
                          .reference()
                          .child("AuraUsers")
                          .child(widget.uid!)
                          .once(),
                      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.value['email'],
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0, letterSpacing: .3),
                          );
                        } else {
                          return CircularProgressIndicator(
                            color: const Color(0xff9f2940),
                          );
                        }
                      }),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FutureBuilder(
                      future: FirebaseDatabase.instance
                          .reference()
                          .child("AuraUsers")
                          .child(widget.uid!)
                          .once(),
                      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.value['fullname']
                                .split(" ")
                                .map((l) => l[0])
                                .take(2)
                                .join(),
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff9f2940)),
                          );
                        } else {
                          return CircularProgressIndicator(
                            color: const Color(0xff9f2940),
                          );
                        }
                      },
                    ),
                  ),
                  accountName: FutureBuilder(
                      future: FirebaseDatabase.instance
                          .reference()
                          .child("AuraUsers")
                          .child(widget.uid!)
                          .once(),
                      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.value['fullname'],
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0,
                                letterSpacing: .3,
                                fontWeight: FontWeight.bold),
                          );
                        } else {
                          return CircularProgressIndicator(
                            color: const Color(0xff9f2940),
                          );
                        }
                      }),
                  decoration: BoxDecoration(
                    color: const Color(0xff9f2940),
                  ),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.settings, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.logout, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text(
                    'Sign Out',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 15.0, letterSpacing: .25),
                  ),
                  onTap: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth.signOut().then((res) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false);
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
