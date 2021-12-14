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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f7f7),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset("assets/aura.png",
            fit: BoxFit.contain, height: 26.0, width: 26.0),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xfff7f7f7),
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
                width: 75,
                height: 75,
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   this.widget.spaceMembers,
                //   style: GoogleFonts.nunitoSans(),
                // )
              ],
            ),
            SizedBox(
              height: 20,
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
            )
          ],
        ),
      ),
    );
  }
}
