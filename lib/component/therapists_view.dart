import 'package:aura_flutter/views/therapist_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapistView extends StatelessWidget {
  var therapistName;
  var role;
  var image;

  TherapistView({Key? key, this.therapistName, this.role, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TherapistInformation(
              therapistName: this.therapistName,
              role: this.role,
              image: this.image,
            ),
          ),
        );
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
              image,
              height: 80,
              width: 80,
            ),
            title: Text(
              therapistName,
              style: GoogleFonts.nunitoSans(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: .3,
              ),
            ),
            subtitle: Text(
              role,
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
