import 'package:aura_flutter/views/support_space_info.dart';
import 'package:aura_flutter/views/therapist_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportSpaceView extends StatefulWidget {
  var spaceName;
  var spaceCategory;
  var spaceMembers;
  var spaceImg;

  SupportSpaceView(
      {Key? key,
      this.spaceName,
      this.spaceCategory,
      this.spaceMembers,
      this.spaceImg})
      : super(key: key);

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
                      spaceImg: this.widget.spaceImg,
                      spaceCategory: this.widget.spaceCategory,
                      spaceMembers: this.widget.spaceMembers,
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
            leading: Image.asset(
              this.widget.spaceImg,
              height: 80,
              width: 80,
            ),
            title: Text(
              this.widget.spaceName,
              style: GoogleFonts.nunitoSans(
                fontSize: 18.0,
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
