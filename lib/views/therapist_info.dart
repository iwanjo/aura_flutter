import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TherapistInformation extends StatefulWidget {
  var therapistName;
  var role;
  var image;
  TherapistInformation({Key? key, this.therapistName, this.role, this.image})
      : super(key: key);

  @override
  _TherapistInformationState createState() => _TherapistInformationState();
}

class _TherapistInformationState extends State<TherapistInformation> {
  @override
  Widget build(BuildContext context) {
    String name = this.widget.therapistName;
    final first = name.split(" ");
    bool isLoading = false;
    final _formKey = GlobalKey<FormState>();
    FirebaseAuth fbaseAuth = FirebaseAuth.instance;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("TherapySessions");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f7f7),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset("assets/aura.png",
            fit: BoxFit.contain, height: 26.0, width: 26.0),
        centerTitle: true,
        // title: Text("Choose " + this.widget.therapistName),
      ),
      body: Container(
        color: const Color(0xfff7f7f7),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xfff7f7f7),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    this.widget.image,
                    width: 110.0,
                    height: 110.0,
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
                            Text(
                              this.widget.therapistName,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(this.widget.role,
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700])),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nairobi, Kenya",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        )
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "About " + first[0],
              style: GoogleFonts.nunitoSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .03),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "" +
                  first[0] +
                  " is an experienced therapist on Aura with 4+ years of mental healthcare treatment in Africa. " +
                  first[0] +
                  "'s mission is to enable widespread access to therapy services and eliminate its associated stigma in Africa",
              style: GoogleFonts.nunitoSans(
                fontSize: 15,
                letterSpacing: .03,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 16,
            ),
            Form(
              child: Text("Choose a Date"),
              key: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}
