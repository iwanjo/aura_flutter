// ignore_for_file: prefer_const_constructors
import 'package:aura_flutter/views/home.dart';
import 'package:aura_flutter/pageroutes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aura_flutter/views/register.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _hiddenPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                    "Welcome back to Aura",
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
                                    loginToFirebase();
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
                      "Or sign in with",
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
                        "Don't have an account? Register here",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
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

  void loginToFirebase() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PageRoutes(uid: result.user!.uid)));
    });
  }
}
