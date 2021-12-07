// ignore_for_file: prefer_const_constructors

import 'package:aura_flutter/component/therapists_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class TherapyHome extends StatefulWidget {
  final String? uid;

  const TherapyHome({Key? key, this.uid}) : super(key: key);

  @override
  _TherapyHomeState createState() => _TherapyHomeState();
}

class _TherapyHomeState extends State<TherapyHome>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBarController = TabController(length: 6, vsync: this);
    final box = Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: const Color(0xff9f2940),
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      child: Icon(Icons.search, color: Colors.white),
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
          decoration: BoxDecoration(color: const Color(0xfff7f7f7)),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Text(
                "Browse our list of therapists",
                style: GoogleFonts.nunitoSans(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .3),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 44.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xffebebeb),
                ),
                child: Stack(
                  children: <Widget>[
                    TextField(
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 14.0, letterSpacing: .2),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: const Color(0xffebebeb),
                        filled: true,
                        hintText: 'Search for therapists',
                        hintStyle: GoogleFonts.nunitoSans(
                            color: Colors.grey,
                            fontSize: 15.0,
                            letterSpacing: .3),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 3, color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                    Positioned(child: box, right: 0, top: 0),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: 25.0,
                child: TabBar(
                  controller: _tabBarController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.nunitoSans(
                      fontSize: 13.0,
                      letterSpacing: .3,
                      fontWeight: FontWeight.w600),
                  unselectedLabelColor: Colors.grey,
                  indicator: RectangularIndicator(
                      color: const Color(0xff9f2940),
                      bottomLeftRadius: 5,
                      bottomRightRadius: 5,
                      paintingStyle: PaintingStyle.fill),
                  tabs: [
                    Tab(text: "All"),
                    Tab(text: "Anxiety"),
                    Tab(text: "Depression"),
                    Tab(text: "Stress"),
                    Tab(text: "Relationship"),
                    Tab(text: "Marital"),
                  ],
                ),
              ),
              Container(
                height: 500,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: TabBarView(
                  controller: _tabBarController,
                  children: [
                    allTherapistListView(),
                    Text("data2"),
                    Text("data3"),
                    Text("data4"),
                    Text("data5"),
                    Text("data6"),
                  ],
                ),
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
        ));
  }

  allTherapistListView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        children: <Widget>[
          TherapistView(
            therapistName: 'Chisom Ikenna',
            role: 'Clinical Therapist',
            image: 'assets/therapist1.jpg',
          ),
          SizedBox(
            height: 20,
          ),
          TherapistView(
            therapistName: 'Nana Njiru',
            role: 'General Counsellor',
            image: 'assets/therapist5.jpg',
          ),
          SizedBox(
            height: 20,
          ),
          TherapistView(
            therapistName: 'Sarah Mwale',
            role: 'Psychiatrist',
            image: 'assets/therapist3.jpg',
          ),
        ],
      ),
    );
  }
}
