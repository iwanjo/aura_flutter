// ignore_for_file: prefer_const_constructors

import 'package:aura_flutter/community.dart';
import 'package:aura_flutter/home.dart';
import 'package:aura_flutter/profile.dart';
import 'package:aura_flutter/therapy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageRoutes extends StatefulWidget {
  const PageRoutes({Key? key}) : super(key: key);

  @override
  _PageRoutesState createState() => _PageRoutesState();
}

class _PageRoutesState extends State<PageRoutes> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    CommunitySpaces(),
    TherapyHome(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
