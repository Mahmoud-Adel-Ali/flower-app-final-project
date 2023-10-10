// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/constant/colors.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/pages/resetPassworr.dart';
import 'package:flower_app/provider/google_signin.dart';
import 'package:flower_app/widgets/decorationOfTextFormField.dart';
import 'package:flower_app/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final password = TextEditingController();
  final emailAddress = TextEditingController();
  bool hiddinPassword = true;
  signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text, password: password.text);
      // showSnackBar(context, "waite to verify your email");
      showSnackBar(context, "Done...");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => Home())));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.toString());
    }
    // Stop indicator
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        title: const Text("Sign in"),
        backgroundColor: appbarGreen,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your Email : ",
                    suffix: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: hiddinPassword,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your Password : ",
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          hiddinPassword = !hiddinPassword;
                        });
                      },
                      icon: !hiddinPassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ResetPassword())));
                      },
                      child: const Text(
                        "forgot password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await signIn();
                    if (!mounted) return;
                    // showSnackBar(context, "done");
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen)),
                  child: const Text(
                    "sign in",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "if you don't have acount ",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Register())));
                        },
                        child: const Text(
                          "register",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.8,
                      )),
                      Text(
                        "OR",
                        style: TextStyle(),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.8,
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: appbarGreen, width: 2)),
                  child: GestureDetector(
                    onTap: () {
                      // googleSignInProvider.signInWithGoogle();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        "assets/img/google-plus.svg",
                        // ignore: deprecated_member_use
                        color: const Color.fromARGB(255, 0, 0, 0),
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
