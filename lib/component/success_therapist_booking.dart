import 'package:aura_flutter/pageroutes.dart';
import 'package:aura_flutter/views/home.dart';
import 'package:aura_flutter/views/support_spaces.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SuccessCreateBooking extends StatefulWidget {
  final String? uid;

  const SuccessCreateBooking({Key? key, this.uid}) : super(key: key);

  @override
  _SuccessCreateBookingState createState() => _SuccessCreateBookingState();
}

class _SuccessCreateBookingState extends State<SuccessCreateBooking> {
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final sessionDetails = FutureBuilder(
        future: FirebaseFirestore.instance.collection("sessions").get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Text(snapshot.data!.docs[index].data()["doctor"]);
                  return Text(
                    snapshot.data!.docs[index].data()["doctor"],
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data for you");
          }
          return CircularProgressIndicator();
        });

    final monthDetails = FutureBuilder(
        future: FirebaseFirestore.instance.collection("sessions").get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Text(snapshot.data!.docs[index].data()["month"]);
                  return Text(
                    snapshot.data!.docs[index].data()["month"],
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data for you");
          }
          return CircularProgressIndicator();
        });

    final dateDetails = FutureBuilder(
        future: FirebaseFirestore.instance.collection("sessions").get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Text(snapshot.data!.docs[index].data()["date"]);
                  return Text(
                    snapshot.data!.docs[index].data()["date"],
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data for you");
          }
          return CircularProgressIndicator();
        });

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff7f7f7),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset("assets/aura.png",
              fit: BoxFit.contain, height: 26.0, width: 26.0),
          centerTitle: true,
          actions: <Widget>[]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              // replace with higher quality png
              child: Image.asset(
                "assets/congrats.png",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Session Confirmed Successfully",
                style: GoogleFonts.nunitoSans(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .3),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Your session with ",
              style: GoogleFonts.nunitoSans(fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            sessionDetails,
            Text(
              "will occur on ",
              style: GoogleFonts.nunitoSans(fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            monthDetails,
            dateDetails,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
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
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         child: PageRoutes(),
                            //         type: PageTransitionType
                            //             .leftToRightWithFade));
                          },
                          child: Text(
                            "Return Home",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
