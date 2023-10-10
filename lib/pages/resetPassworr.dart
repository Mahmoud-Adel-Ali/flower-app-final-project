// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/constant/colors.dart';
import 'package:flower_app/pages/signin.dart';
import 'package:flower_app/widgets/decorationOfTextFormField.dart';
import 'package:flower_app/widgets/snackBar.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  resetPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress.text);

      showSnackBar(context, "Donee... : please check your email");
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    if (mounted) Navigator.pop(context);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => Signin())));
  }

  void dispose() {
    // TODO: implement dispose
    emailAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("reset password"),
        backgroundColor: appbarGreen,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "enter your email to reset password ",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 25),
              TextFormField(
                validator: (value) {
                  return value!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Enter a valid email";
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailAddress,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: decorationTextfield.copyWith(
                  hintText: "Enter Your Email : ",
                  suffix: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await resetPassword();
                    if (!mounted) return; // correct
                    // showSnackBar(context, "Done...");
                  } else {
                    showSnackBar(context, "Error....");
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen)),
                child: Text(
                  "reset password",
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
