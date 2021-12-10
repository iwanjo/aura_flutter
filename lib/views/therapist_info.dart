import 'package:flutter/material.dart';
import 'package:aura_flutter/views/therapy.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f7f7),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Image.asset("assets/aura.png",
            fit: BoxFit.contain, height: 26.0, width: 26.0),
        centerTitle: true,
      ),
    );
  }
}
