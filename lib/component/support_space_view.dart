import 'package:aura_flutter/views/support_space_info.dart';
import 'package:aura_flutter/views/therapist_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportSpaceView extends StatefulWidget {
  var spaceImg;
  var spaceName;
  var spaceCategory;
  var spaceDescription;

  SupportSpaceView({
    Key? key,
    this.spaceImg,
    this.spaceName,
    this.spaceCategory,
    this.spaceDescription,
  }) : super(key: key);

  @override
  _SupportSpaceViewState createState() => _SupportSpaceViewState();
}

class _SupportSpaceViewState extends State<SupportSpaceView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SupportSpaceInfo(
                      spaceName: this.widget.spaceName,
                      spaceDescription: this.widget.spaceDescription,
                      spaceImg: this.widget.spaceImg,
                      spaceCategory: this.widget.spaceCategory,
                    )));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListTile(
            leading: Image.network(
              this.widget.spaceImg,
              height: 50,
              width: 50,
            ),
            title: Text(
              this.widget.spaceName,
              style: GoogleFonts.nunitoSans(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: .3,
              ),
            ),
            subtitle: Text(
              this.widget.spaceCategory,
              style: GoogleFonts.nunitoSans(
                fontSize: 13.0,
                letterSpacing: .1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
