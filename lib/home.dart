import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String? uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
    );
  }
}




// class Home extends StatelessWidget {
//   Home({this.uid});
//   final String? uid;
  

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
