import 'package:aura_flutter/views/home.dart';
import 'package:aura_flutter/views/support_spaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SuccessCreateSpace extends StatelessWidget {
  final String? uid;

  const SuccessCreateSpace({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    bool isLoading = false;

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
                "Community Space Created Successfully",
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
              "Congratulations, your space is ready to take off. It will take 2-3 minutes to go live",
              style: GoogleFonts.nunitoSans(fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
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
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: SupportSpaces(
                                      uid: user!.uid,
                                    ),
                                    type: PageTransitionType
                                        .leftToRightWithFade));
                          },
                          child: Text(
                            "View Space Home",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )),
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  child: Text(
                    "Return to Home",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff9f2940),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Home(
                              uid: user!.uid,
                            ),
                            type: PageTransitionType.leftToRightWithFade));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
