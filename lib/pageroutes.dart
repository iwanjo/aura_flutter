// ignore_for_file: prefer_const_constructors

import 'package:aura_flutter/community.dart';
import 'package:aura_flutter/home.dart';
import 'package:aura_flutter/profile.dart';
import 'package:aura_flutter/therapy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class PageRoutes extends StatefulWidget {
  final String? uid;
  const PageRoutes({Key? key, this.uid}) : super(key: key);

  @override
  _PageRoutesState createState() => _PageRoutesState();
}

class _PageRoutesState extends State<PageRoutes> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  // ignore: prefer_final_fields
  late final List<Widget> _widgetOptions = <Widget>[
    Home(
      uid: user!.uid,
    ),
    CommunitySpaces(),
    TherapyHome(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Home",
              style: GoogleFonts.nunitoSans(fontSize: 14.0),
            ),
            selectedColor: const Color(0xff9f2940),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.call),
            title: Text(
              "Therapy",
              style: GoogleFonts.nunitoSans(fontSize: 14.0),
            ),
            selectedColor: const Color(0xff9f2940),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.grid_view_rounded),
            title: Text(
              "Community",
              style: GoogleFonts.nunitoSans(fontSize: 14.0),
            ),
            selectedColor: const Color(0xff9f2940),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text(
              "Profile",
              style: GoogleFonts.nunitoSans(fontSize: 14.0),
            ),
            selectedColor: const Color(0xff9f2940),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}