import 'dart:developer';

import 'package:alpine/Screens/home.dart';
import 'package:alpine/Screens/login.dart';
import 'package:alpine/animation/fade_in_slide.dart';

import 'package:alpine/helpers/helpers_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passObsecure = true;
  String? email;
  String? password;
  String? confirmpassword;

  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 13),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: FadeInSlide(
                  duration: .4,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
              ),
              FadeInSlide(
                duration: .5,
                child: Center(
                  child: Lottie.asset('assets/animations/signup.json',
                      height: 200),
                ),
              ),
              Form(
                key: key,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  children: [
                    FadeInSlide(
                      duration: .6,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(focus1),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        validator:
                            ValidationBuilder().email().maxLength(50).build(),
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            errorStyle: const TextStyle(color: Colors.red),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.email_outlined),
                            prefixIconColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInSlide(
                      duration: .7,
                      child: TextFormField(
                        focusNode: focus1,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(focus2),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        obscureText: passObsecure,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be Empty";
                          } else if (value.length < 6) {
                            return "Password must contain atleast 6 characters";
                          } else {
                            password = value;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(color: Colors.red),
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIconColor: Colors.white,
                            prefixIconColor: Colors.white,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passObsecure = !passObsecure;
                                  });
                                },
                                icon: Icon(passObsecure
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye_outlined)),
                            prefixIcon: const Icon(Icons.password_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInSlide(
                      duration: .8,
                      child: TextFormField(
                        focusNode: focus2,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(focus3),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        obscureText: passObsecure,
                        onChanged: (value) {
                          confirmpassword = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be Empty";
                          } else if (value.length < 6) {
                            return "Password must contain atleast 6 characters";
                          } else if (password != confirmpassword) {
                            return "Password doesn't match";
                          } else {
                            confirmpassword = value;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(color: Colors.red),
                            labelText: 'Confirm Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIconColor: Colors.white,
                            prefixIconColor: Colors.white,
                            prefixIcon: const Icon(Icons.password_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInSlide(
                      duration: .9,
                      child: MyButton(
                        focusNode: focus3,
                        callback: () async {
                          if (key.currentState!.validate()) {
                            showDialog(
                                builder: (context) => Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'Please wait...',
                                            style: GoogleFonts.lato(
                                                fontSize: 16,
                                                decoration: TextDecoration.none,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                context: context);

                            try {
                              UserCredential userCred = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: email!, password: password!);
                              if (userCred.user != null) {
                                var data = {
                                  'email': email,
                                  'createdAt': DateTime.now(),
                                };

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCred.user!.uid)
                                    .set(data);
                              }

                              if (mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                log('The Password is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                log('Given Email Already in use');
                              }
                            } catch (e) {
                              log('$e');
                            }
                          }
                        },
                        name: 'Sign Up',
                        child: null,
                        foreground: Colors.deepPurple,
                        background: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInSlide(
                      duration: 1.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an Account?",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInSlide(
                      duration: 1.1,
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'OR',
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  indent: 10,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          FadeInSlide(
                            duration: 1.2,
                            child: MyButton(
                              callback: () {},
                              name: 'Continue with Google',
                              foreground: Theme.of(context).colorScheme.primary,
                              background:
                                  Theme.of(context).colorScheme.background,
                              child: Image.asset(
                                'assets/Images/google.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInSlide(
                            duration: 1.3,
                            child: MyButton(
                              callback: () {},
                              name: 'Continue with Apple',
                              foreground: Theme.of(context).colorScheme.primary,
                              background:
                                  Theme.of(context).colorScheme.background,
                              child: Image.asset(
                                'assets/Images/apple.png',
                                color: Theme.of(context).colorScheme.primary,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInSlide(
                            duration: 1.4,
                            child: MyButton(
                              callback: () {},
                              name: 'Continue with Facebook',
                              foreground: Theme.of(context).colorScheme.primary,
                              background:
                                  Theme.of(context).colorScheme.background,
                              child: Image.asset(
                                'assets/Images/facebook.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInSlide(
                            duration: 1.5,
                            child: MyButton(
                              callback: () {},
                              name: 'Continue with Github',
                              foreground: Theme.of(context).colorScheme.primary,
                              background:
                                  Theme.of(context).colorScheme.background,
                              child: Image.asset(
                                'assets/Images/github.png',
                                color: Theme.of(context).colorScheme.primary,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
