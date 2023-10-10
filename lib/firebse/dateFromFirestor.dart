import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// show AsyncSnapshot, BuildContext, Center, Column, ConnectionState, CrossAxisAlignment, FutureBuilder, SizedBox, StatelessWidget, Text, TextStyle, Widget;

class GetDataFromFirestor extends StatefulWidget {
  final String documentId;
  const GetDataFromFirestor({super.key, required this.documentId});

  @override
  State<GetDataFromFirestor> createState() => _GetDataFromFirestorState();
}

class _GetDataFromFirestorState extends State<GetDataFromFirestor> {
  // to control dialog textfeaild
  final dialogControllar = TextEditingController();
  //used to go firebase firestore and get data or update
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
                    keyboardType: TextInputType.text,
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
                              dialogControllar.text = "";
                            }
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Edit"),
                      ),
                      TextButton(
                        onPressed: () {
                          dialogControllar.text = "";
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
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("User Name : ${data['userName']} ",
                      style: const TextStyle(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, "userName", 30);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"userName": FieldValue.delete()});
                            });
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Age : ${data['age']}",
                      style: const TextStyle(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, "age", 2);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Jop : ${data['jop']}",
                      style: const TextStyle(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, "jop", 35);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email:${data['email']}",
                      style: const TextStyle(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, "email", 20);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Password : ${data['password']}",
                      style: const TextStyle(fontSize: 15)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, "password", 30);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      users.doc(credential!.uid).delete();
                    });
                  },
                  child: const Text(
                    "Delete document",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
            child: Text("loading", style: TextStyle(fontSize: 15)));
      },
    );
  }
}
