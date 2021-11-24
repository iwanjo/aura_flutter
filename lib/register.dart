// ignore_for_file: prefer_const_constructors
import 'package:aura_flutter/home.dart';
import 'package:aura_flutter/pageroutes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aura_flutter/plan.dart';
import 'package:aura_flutter/login.dart';

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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbReference =
      FirebaseDatabase.instance.reference().child("AuraUsers");
  bool _hiddenPass = true;
  bool _checked = false;
  bool isLoading = false;

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
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your full name',
                          hintStyle: GoogleFonts.nunitoSans(
                              color: Colors.grey, fontSize: 15.0),
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
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelText: "Email Address",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter your email address',
                          hintStyle: GoogleFonts.nunitoSans(
                              color: Colors.grey, fontSize: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                width: 3, color: Colors.grey.shade200),
                          )),
                      controller: emailController,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter your email address";
                        } else if (value != null && !value.contains('@')) {
                          return "Please enter an email address with an @ symbol";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: _passwordVisible,
                            child: Icon(Icons.visibility),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Minimum of 8 characters',
                          hintStyle: GoogleFonts.nunitoSans(
                              color: Colors.grey, fontSize: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                width: 3, color: Colors.grey.shade200),
                          )),
                      controller: passwordController,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      obscureText: _hiddenPass,
                      textCapitalization: TextCapitalization.words,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter a password";
                        } else if (value != null && value.length < 8) {
                          return "Please enter a password at least 8 characters long.";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          activeColor: const Color(0xff9f2940),
                          value: _checked,
                          onChanged: (value) {
                            setState(() {
                              _checked = !_checked;
                            });
                          }),
                      Text(
                        "I agree to Aura's terms and conditions",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 14.0,
                            letterSpacing: .3),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    registerToFirebase();
                                  }
                                },
                                child: Text(
                                  "Continue",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // ignore: prefer_const_constructors
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or register with",
                      style: GoogleFonts.nunitoSans(
                        color: Colors.grey[600],
                        fontSize: 14.0,
                        letterSpacing: .3,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 28,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        "assets/google.png",
                        width: 36.0,
                        height: 36.0,
                      ),
                      Image.asset(
                        "assets/facebook.png",
                        width: 36.0,
                        height: 36.0,
                      ),
                      Image.asset(
                        "assets/twitter.png",
                        width: 36.0,
                        height: 36.0,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 36,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text(
                        "Already have an account? Login here",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _passwordVisible() {
    setState(() {
      _hiddenPass = !_hiddenPass;
    });
  }

  void registerToFirebase() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      dbReference.child(result.user!.uid).set({
        "fullname": fullNameController.text,
        "email": emailController.text,
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PageRoutes(
                    uid: result.user!.uid,
                  )),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sorry, there's an error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
