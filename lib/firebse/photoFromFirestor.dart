import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// show AsyncSnapshot, BuildContext, Center, Column, ConnectionState, CrossAxisAlignment, FutureBuilder, SizedBox, StatelessWidget, Text, TextStyle, Widget;

class UserImg extends StatefulWidget {
  // final String documentId;
  const UserImg({super.key});

  @override
  State<UserImg> createState() => _UserImgState();
}

class _UserImgState extends State<UserImg> {
  final dialogControllar = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('userss');
  final credential = FirebaseAuth.instance.currentUser;
  myDialog(Map data, String key, int maxChar) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 200,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: dialogControllar,
                    maxLength: maxChar,
                    decoration: InputDecoration(hintText: key),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            // data[key] = dialogControllar.text;
                            if (dialogControllar.text != "") {
                              users
                                  .doc(credential!.uid)
                                  .update({key: dialogControllar.text});
                            }
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Edit"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('userss');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return CircleAvatar(
                backgroundColor: Color.fromARGB(255, 225, 225, 225),
                radius: 71,
                backgroundImage: NetworkImage(data['imgURL']),
              );
        }
        return const Center(
            child: Text("loading", style: TextStyle(fontSize: 15)));
      },
    );
  }
}
