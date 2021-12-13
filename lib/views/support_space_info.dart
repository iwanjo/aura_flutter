import 'package:aura_flutter/views/therapist_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportSpaceInfo extends StatefulWidget {
  var spaceName;
  var spaceCategory;
  var spaceMembers;
  var spaceImg;
  SupportSpaceInfo(
      {Key? key,
      this.spaceName,
      this.spaceCategory,
      this.spaceMembers,
      this.spaceImg})
      : super(key: key);

  @override
  _SupportSpaceInfoState createState() => _SupportSpaceInfoState();
}

class _SupportSpaceInfoState extends State<SupportSpaceInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
