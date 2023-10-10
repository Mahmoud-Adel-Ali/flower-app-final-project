//to start any Application ,you should write the code
// ignore_for_file: unused_import, duplicate_import, prefer_const_constructors

import 'package:flower_app/firebase_options.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/pages/resetPassworr.dart';
import 'package:flower_app/pages/signin.dart';
import 'package:flower_app/pages/verifyEmail.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:flower_app/provider/google_signin.dart';
import 'package:flower_app/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//flower_app

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              // return VerifyEmailPage();
              return Home(); //temporiry
            } else {
              return Signin();
            }
          },
        ),
        theme: ThemeData.fallback(), // or dark or ........
      ),
    );
  }
}
