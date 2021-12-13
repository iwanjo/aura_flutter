import 'package:aura_flutter/views/login.dart';
import 'package:aura_flutter/views/support_spaces.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class CommunitySpaces extends StatefulWidget {
  final String? uid;

  const CommunitySpaces({Key? key, this.uid}) : super(key: key);

  @override
  _CommunitySpacesState createState() => _CommunitySpacesState();
}

class _CommunitySpacesState extends State<CommunitySpaces> {
  final user = FirebaseAuth.instance.currentUser;

  bool isLoading = false;
  final TextEditingController nicknameController = TextEditingController();

  Random rnd = new Random();
  var lst = [
    "auspiciousNinja12",
    "warrior_spirit455",
    "junoSmith340",
    "king_khunt@"
  ];

  trial() {
    var element = lst[rnd.nextInt(lst.length)];
    return element;
  }

  @override
  Widget build(BuildContext context) {
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
                child:
                    Image.asset("assets/community-svg.png", fit: BoxFit.cover),
              ),
              SizedBox(
                height: 36,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Welcome to our community support space",
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
                "We embrace total anonymity in our community. Get started by choosing or setting a unique nickname.",
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
                              showDialog1();
                            },
                            child: Text(
                              "Autogenerate nickname",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            )),
                      ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    child: Text(
                      "Set my own nickname",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff9f2940),
                      ),
                    ),
                    onPressed: () {
                      showDialogBox2();
                    }),
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

  showDialog1() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Image.asset(
          "assets/success.png",
          height: 40,
          width: 40,
          // fit: BoxFit.cover,
        ),
        content: Text(
          "Success, your autogenerated nickname is " + trial(),
          style: GoogleFonts.nunitoSans(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            letterSpacing: .3,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Cancel",
                style: GoogleFonts.nunitoSans(color: Colors.black)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff9f2940),
              ),
            ),
            onPressed: () {
              captureNickname(trial());
            },
            child: Text(
              "Confirm",
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  showDialogBox2() {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                "Set your community nickname",
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: TextFormField(
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                controller: nicknameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    labelText: "Nickname",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Enter your community nickname',
                    hintStyle: GoogleFonts.nunitoSans(
                        color: Colors.grey, fontSize: 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(width: 3, color: Colors.grey.shade200),
                    )),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "Please enter your nickname";
                  }
                  return null;
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Cancel",
                      style: GoogleFonts.nunitoSans(color: Colors.black)),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff9f2940),
                    ),
                  ),
                  onPressed: () {
                    captureNickname(nicknameController.text);
                  },
                  child: Text(
                    "Set",
                    style: GoogleFonts.nunitoSans(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  captureNickname(String nickname) {
    FirebaseFirestore.instance.collection('nicknames').add({
      'userNickname': nickname,
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SupportSpaces(
                uid: user!.uid,
              )),
    );
  }
}
