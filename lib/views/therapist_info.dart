import 'package:flutter/material.dart';

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
    return Scaffold();
  }
}
