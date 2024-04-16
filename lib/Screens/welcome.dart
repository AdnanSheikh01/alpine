import 'package:alpine/Screens/login.dart';
import 'package:alpine/Screens/signup.dart';
import 'package:alpine/Services/auth_services.dart';
import 'package:alpine/animation/fade_in_slide.dart';
import 'package:alpine/helpers/helpers_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    return MyContainer(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                CupertinoIcons.chat_bubble,
                size: 80,
                color: Colors.white,
              ),
              const Spacer(),
              const Center(
                child: FadeInSlide(
                  duration: .4,
                  child: Text(
                    "Let's Get Started",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              const FadeInSlide(
                duration: .5,
                child: Text(
                  "Let's go into your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              FadeInSlide(
                duration: .6,
                child: MyButton(
                  foreground: Theme.of(context).colorScheme.primary,
                  background: Theme.of(context).colorScheme.background,
                  callback: () => AuthServices().signInwithGoogle(),
                  name: 'Continue with Google',
                  child: Image.asset(
                    'assets/Images/google.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              FadeInSlide(
                duration: .7,
                child: MyButton(
                  foreground: Theme.of(context).colorScheme.primary,
                  background: Theme.of(context).colorScheme.background,
                  callback: () {},
                  name: 'Continue with Apple',
                  child: Image.asset(
                    'assets/Images/apple.png',
                    color: Theme.of(context).colorScheme.primary,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              FadeInSlide(
                duration: .8,
                child: MyButton(
                  foreground: Theme.of(context).colorScheme.primary,
                  background: Theme.of(context).colorScheme.background,
                  callback: () {},
                  name: 'Continue with Facebook',
                  child: Image.asset(
                    'assets/Images/facebook.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              FadeInSlide(
                duration: .9,
                child: MyButton(
                  foreground: Theme.of(context).colorScheme.primary,
                  background: Theme.of(context).colorScheme.background,
                  callback: () {},
                  name: 'Continue with Github',
                  child: Image.asset(
                    'assets/Images/github.png',
                    color: Theme.of(context).colorScheme.primary,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              const Spacer(),
              FadeInSlide(
                duration: 1.0,
                child: MyButton(
                  foreground: Colors.white,
                  background: Colors.deepPurple,
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  name: 'Log In',
                  child: null,
                ),
              ),
              SizedBox(height: height * 0.02),
              FadeInSlide(
                duration: 1.1,
                child: MyButton(
                  foreground: Theme.of(context).colorScheme.primary,
                  background: Theme.of(context).colorScheme.background,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  name: 'Sign Up',
                  child: null,
                ),
              ),
              const Spacer(),
              const FadeInSlide(
                duration: 1.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '  -  ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Terms of Service',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ));
  }
}
