import 'package:aura_flutter/views/therapist_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportSpaceInfo extends StatefulWidget {
  var spaceName;
  var spaceDescription;
  var spaceCategory;
  var spaceImg;
  SupportSpaceInfo(
      {Key? key,
      this.spaceName,
      this.spaceDescription,
      this.spaceCategory,
      this.spaceImg})
      : super(key: key);

  @override
  _SupportSpaceInfoState createState() => _SupportSpaceInfoState();
}

class _SupportSpaceInfoState extends State<SupportSpaceInfo> {
  @override
  Widget build(BuildContext context) {
    String name = this.widget.spaceName;

    bool? joinedCommunity;

    showJoiningDialog() {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Image.asset(
            "assets/success.png",
            height: 40,
            width: 40,
          ),
          content: Text(
            "You're joining ' " + this.widget.spaceName,
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
                setState(() {
                  joinedCommunity = true;
                });
                Navigator.of(ctx).pop();
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f7f7),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset("assets/aura.png",
            fit: BoxFit.contain, height: 26.0, width: 26.0),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
        ],
      ),
      body: Container(
        color: const Color(0xfff5f5f5),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Image.network(
                this.widget.spaceImg,
                width: 55,
                height: 55,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              this.widget.spaceName,
              style: GoogleFonts.nunitoSans(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "About Space",
              style: GoogleFonts.nunitoSans(
                  fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              this.widget.spaceDescription,
              style: GoogleFonts.nunitoSans(
                fontSize: 15.0,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Welcome to " + this.widget.spaceName,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Community Activity",
              style: GoogleFonts.nunitoSans(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                height: 150,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue[800],
                          child: Text(
                            "NA",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "NarutoAtano4",
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .03,
                              ),
                            ),
                            Text(
                              "1h ago",
                              style: GoogleFonts.nunitoSans(fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "I'm Really excited to join this group and learn from everyone.",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15.0,
                        letterSpacing: .2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            joinedCommunity != true
                ? ElevatedButton(
                    onPressed: () {
                      showJoiningDialog();
                    },
                    child: Text(
                      "Join Community",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff9f2940),
                      ),
                    ),
                  )
                : Container(
                    child: Text(
                      "Welcome",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
