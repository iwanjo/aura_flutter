import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  final String? uid;
  const Profile({Key? key, this.uid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
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

    final EmailDetails = FutureBuilder(
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
              fontSize: 16.0,
            ),
          );
        } else {
          return CircularProgressIndicator(
            color: const Color(0xff9f2940),
          );
        }
      },
    );

    return Scaffold(
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
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xff9f2940),
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
                              color: Colors.white),
                        );
                      } else {
                        return CircularProgressIndicator(
                          color: const Color(0xff9f2940),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        UserDetails,
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    EmailDetails,
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
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
                              "Please Recommend Aura",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Tell your friends about us",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            child: (Text(
                              "Share Aura",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            )),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xff9f2940),
                              ),
                            ),
                            onPressed: () {
                              Share.share(
                                "I am using Aura. It's a platform providing affordable counselling and community spaces for people to join. It's launching soon on the play store, and with this code AUR@2022!, you can get 2 months free.",
                              );
                            }),
                      ]),
                  Image.asset(
                    "assets/aurabot.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Menu Drawer
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
                style:
                    GoogleFonts.nunitoSans(fontSize: 15.0, letterSpacing: .25),
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
      ),
    );
  }
}
