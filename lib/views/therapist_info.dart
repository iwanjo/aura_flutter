import 'package:aura_flutter/component/success_therapist_booking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';

class TherapistInformation extends StatefulWidget {
  var therapistName;
  var role;
  var image;
  final String? uid;

  TherapistInformation(
      {Key? key, this.therapistName, this.role, this.image, this.uid})
      : super(key: key);

  @override
  _TherapistInformationState createState() => _TherapistInformationState();
}

class _TherapistInformationState extends State<TherapistInformation> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  // Initial Selected Value
  String? dropdownValue = "Dec";
  // items in our dropdown
  var items = [
    "Dec",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
  ];

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
    String name = this.widget.therapistName;
    final first = name.split(" ");
    bool isLoading = false;

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
              height: 20,
            ),
            Text(
              "Book a session with " + first[0],
              style: GoogleFonts.nunitoSans(
                fontSize: 18,
                letterSpacing: .03,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton(
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      child: Text(items, style: GoogleFonts.nunitoSans()),
                      value: items,
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: GoogleFonts.nunitoSans(
                color: Colors.black,
                fontSize: 15.0,
              ),
              controller: dateController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  errorStyle: GoogleFonts.nunitoSans(
                      color: Colors.red[900], fontSize: 15.0),
                  labelText: "Date in " + dropdownValue.toString(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Enter date, e.g 10, or 18',
                  hintStyle: GoogleFonts.nunitoSans(
                      color: Colors.grey, fontSize: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(width: 3, color: Colors.grey.shade200),
                  )),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return "Please enter the support space name";
                } else if (value != null &&
                    value.length < 1 &&
                    value.length > 31) {
                  return "Invalid entry, dates should be within the range of 1 and 31";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: GoogleFonts.nunitoSans(
                color: Colors.black,
                fontSize: 15.0,
              ),
              controller: timeController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  errorStyle: GoogleFonts.nunitoSans(
                      color: Colors.red[900], fontSize: 15.0),
                  labelText: "Select Time (1 Hour Slots)",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Enter time of day in 24hr format, e.g 11, or 18',
                  hintStyle: GoogleFonts.nunitoSans(
                      color: Colors.grey, fontSize: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(width: 3, color: Colors.grey.shade200),
                  )),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return "Please enter the time";
                }
                return null;
              },
            ),
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff9f2940),
                          ),
                        ),
                        onPressed: () {
                          captureSessionData();
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SuccessCreateBooking(),
                                  type:
                                      PageTransitionType.leftToRightWithFade));
                        },
                        child: Text(
                          "Confirm Session",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  captureSessionData() {
    FirebaseFirestore.instance.collection("sessions").add({
      "month": dropdownValue.toString(),
      "date": dateController.text,
      "time": timeController.text,
      "doctor": this.widget.therapistName,
      "requestedBy": this.widget.uid,
    });
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    timeController.dispose();
  }
}
