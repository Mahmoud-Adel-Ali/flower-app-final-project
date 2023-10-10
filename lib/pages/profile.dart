// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, override_on_non_overriding_member, unused_import, sized_box_for_whitespace

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app/constant/colors.dart';
import 'package:flower_app/firebse/dateFromFirestor.dart';
import 'package:flower_app/firebse/photoFromFirestor.dart';
import 'package:flower_app/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  File? imgPath;
  late String imgName;
  late String url;
 //used to go firebase firestore and get data or update
  CollectionReference users = FirebaseFirestore.instance.collection('userss');
  final credential = FirebaseAuth.instance.currentUser;

  //function used to upload Image to storage in firebase
  uploadImage(ImageSource imageSource) async {
    final pickedImg = await ImagePicker().pickImage(source: imageSource);
    try {
      if (pickedImg != null) {
        setState(() {
          // to get image path from file or camera
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          // create uniqe name to each photo
          imgName = "$random$imgName";
        });

        final storageRef = FirebaseStorage.instance.ref(imgName);
        await storageRef.putFile(imgPath!);
        url = await storageRef.getDownloadURL();
        users.doc(credential!.uid).update({
          "imgURL": url,
        });
        setState(() {
          imgPath = null;
        });
      } else {
        showSnackBar(context, "NO img selected");
      }
    } catch (e) {
      showSnackBar(context, "Error => $e");
    }
  }
// function  to show dialog showing file or camera
  myDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await uploadImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.edit)),
                    Text(
                      "Camera",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await uploadImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.file_open)),
                    const Text("Files", style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          TextButton.icon(
              onPressed: () async {
                // GoogleSignIn googleSignin = GoogleSignIn();
                // if (await googleSignin.isSignedIn())
                //   await googleSignin.disconnect();
                // else
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                "logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? UserImg()
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 65,
                              backgroundImage: AssetImage('assets/img/th.jpeg'),
                            ),
                      Positioned(
                        bottom: 0,
                        right: -15,
                        child: IconButton(
                          onPressed: () {
                            myDialog();
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: const Text(
                  "info from firebae auth",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Email : ${credential?.email.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                
                "Created date : ${DateFormat("MMM d y").format(credential!.metadata.creationTime!)}",

                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                "Last sign in date : ${DateFormat("MMM d y").format(credential!.metadata.lastSignInTime!)}",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () async {
                    await credential?.delete();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Delete user",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: const Text(
                  "info from firebase firestor",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              GetDataFromFirestor(
                documentId: credential!.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
