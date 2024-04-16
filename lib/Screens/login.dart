import 'dart:developer';
import 'package:alpine/Screens/forget_password.dart';
import 'package:alpine/Screens/home.dart';
import 'package:alpine/Screens/signup.dart';
import 'package:alpine/Services/auth_services.dart';
import 'package:alpine/animation/fade_in_slide.dart';

import 'package:alpine/helpers/helpers_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passObsecure = true;
  String? email;
  String? password;
  final focus1 = FocusNode();
  final focus2 = FocusNode();
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
                    'Login',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FadeInSlide(
                duration: .5,
                child: Center(
                  child: Lottie.asset('assets/animations/login_page.json',
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
                    const FadeInSlide(
                      duration: .6,
                      child: Text(
                        'Email',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeInSlide(
                      duration: .7,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(focus1),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        validator: ValidationBuilder().email().build(),
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            errorStyle: const TextStyle(color: Colors.red),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintStyle: const TextStyle(color: Colors.white54),
                            prefixIcon: const Icon(Icons.email_rounded),
                            prefixIconColor: Colors.white,
                            suffixIconColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const FadeInSlide(
                      duration: .8,
                      child: Text(
                        'Password',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FadeInSlide(
                      duration: .9,
                      child: TextFormField(
                        obscureText: passObsecure,
                        focusNode: focus1,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(focus2),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        validator: ValidationBuilder().minLength(6).build(),
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            errorStyle: const TextStyle(color: Colors.red),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintStyle: const TextStyle(color: Colors.white54),
                            prefixIcon: const Icon(Icons.password_rounded),
                            prefixIconColor: Colors.white,
                            suffixIconColor: Colors.white,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passObsecure = !passObsecure;
                                });
                              },
                              icon: Icon(passObsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: FadeInSlide(
                        duration: 1.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: passObsecure,
                                  onChanged: (value) {},
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPass()));
                              },
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeInSlide(
                      duration: 1.1,
                      child: MyButton(
                          focusNode: focus2,
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
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                  context: context);

                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email!, password: password!);

                                if (mounted) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'wrong-password') {
                                  log('The Password is wrong.');
                                }
                                if (e.code == 'invalid-email') {
                                  log('Invalid Email.');
                                }
                                if (e.code == 'user-not-found') {
                                  log('User not found.');
                                }
                              } catch (e) {
                                log('$e');
                              }
                            }
                          },
                          name: 'Log In',
                          child: null,
                          foreground: Colors.white,
                          background: Colors.deepPurple),
                    ),
                    const SizedBox(height: 30),
                    FadeInSlide(
                      duration: 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account?",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
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
                      duration: 1.3,
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
                            duration: 1.4,
                            child: MyButton(
                              callback: () => AuthServices().signInwithGoogle(),
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
                            duration: 1.5,
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
                            duration: 1.6,
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
                            duration: 1.7,
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
