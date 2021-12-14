import 'dart:io';
import 'dart:io' as io;
import 'package:aura_flutter/component/success_support_space.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:page_transition/page_transition.dart';

class CreateSupportSpace extends StatefulWidget {
  final String? uid;

  const CreateSupportSpace({Key? key, this.uid}) : super(key: key);

  @override
  _CreateSupportSpaceState createState() => _CreateSupportSpaceState();
}

class _CreateSupportSpaceState extends State<CreateSupportSpace> {
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController spaceNameController = TextEditingController();
  final TextEditingController spaceDescriptionController =
      TextEditingController();

  File? image;

  FirebaseStorage storage = FirebaseStorage.instance;
  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  Future pickGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('logos')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(io.File(image!.path), metadata);

    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref
          .getDownloadURL()
          .then((imageUrl) => {captureData(imageUrl)});
    });

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
  }

  captureData(String imageUrl) {
    FirebaseFirestore.instance.collection("supportSpaces").add({
      'spaceName': spaceNameController.text,
      'spaceDescription': spaceDescriptionController.text,
      'logoUrl': imageUrl,
    });
  }

  runAll() {
    uploadImageToFirebase(context);
    Navigator.push(
        context,
        PageTransition(
            child: SuccessCreateSpace(),
            type: PageTransitionType.leftToRightWithFade));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff7f7f7),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
          Text(
            "Create a support space",
            style: GoogleFonts.nunitoSans(
                fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: .3),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Logo Image",
            style: GoogleFonts.nunitoSans(
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          image != null
              ? Image.file(image!, width: 200, height: 100)
              : Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: Center(
                    child: TextButton(
                      child: Text("Upload Logo",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold)),
                      onPressed: showOptions,
                    ),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            style: GoogleFonts.nunitoSans(
              color: Colors.black,
              fontSize: 15.0,
            ),
            controller: spaceNameController,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                errorStyle: GoogleFonts.nunitoSans(
                    color: Colors.red[900], fontSize: 15.0),
                labelText: "Space Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Enter your space name',
                hintStyle:
                    GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 3, color: Colors.grey.shade200),
                )),
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Please enter the support space name";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            style: GoogleFonts.nunitoSans(
              color: Colors.black,
              fontSize: 15.0,
            ),
            controller: spaceDescriptionController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                errorStyle: GoogleFonts.nunitoSans(
                    color: Colors.red[900], fontSize: 15.0),
                labelText: "Space Description",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Enter your space description',
                hintStyle:
                    GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 3, color: Colors.grey.shade200),
                )),
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Please enter the support space name";
              }
              return null;
            },
          ),
          SizedBox(
            height: 24,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff9f2940),
              ),
            ),
            onPressed: () {
              runAll();
            },
            child: Text(
              "Create Space",
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  showOptions() {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    "Gallery",
                    style: GoogleFonts.nunitoSans(),
                  ),
                  onTap: pickGallery,
                ),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    "Camera",
                    style: GoogleFonts.nunitoSans(),
                  ),
                  onTap: pickCamera,
                ),
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    spaceNameController.dispose();
    spaceDescriptionController.dispose();
  }
}
