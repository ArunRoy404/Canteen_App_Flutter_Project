import 'dart:js_interop';

import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/home_page.dart';
import 'package:canteen_app/features/presentation/pages/sign_up_page.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:canteen_app/features/presentation/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = "", password = "";

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppPallete.greyColor,
            content: Text(
              "No User Found!!!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppPallete.greyColor,
            content: Text(
              "Password Is Incorrect!!!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.blackColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(
                hintText: "Email",
                controller: emailController,
                icon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              AuthField(
                hintText: "Password",
                controller: passController,
                isObsecureText: true,
                maxLines: 1,
                icon: const Icon(Icons.password_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              AuthGradientButton(
                buttonText: 'Sign in',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                      password = passController.text;
                    });
                  }
                  userLogin();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.blackColor,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
