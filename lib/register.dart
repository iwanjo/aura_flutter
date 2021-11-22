import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // ignore: prefer_const_constructors
            SizedBox(
              height: 50,
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
                child: Text(
                  "Create an account with Aura",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 24.0,
                      letterSpacing: .3,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            labelText: "Full Name",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: 'Enter your full name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 3, color: Colors.grey.shade200),
                            )),
                        controller: fullNameController,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                    )
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
