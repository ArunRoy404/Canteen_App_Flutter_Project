import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/home_page.dart';
import 'package:canteen_app/features/presentation/pages/sign_in_page.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:canteen_app/features/presentation/widgets/nav_bar.dart';
import 'package:canteen_app/services/database.dart';
import 'package:canteen_app/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? name, email, password;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppPallete.transparentColor,
            content: Text(
              "Registered Succesfully!",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppPallete.blackColor,
              ),
            )));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BottomNav()));
        String Id = randomAlphaNumeric(10);

        await SharedPreferencesHelper().saveUserID(Id);
        await SharedPreferencesHelper().saveUserName(nameController.text);
        await SharedPreferencesHelper().saveUserEmail(emailController.text);

        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Id": Id,
        };
        await DatabaseMEthods().addUserDetails(userInfoMap, Id);
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: AppPallete.greyColor,
              content: Text(
                "Enter a Strong Password!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: AppPallete.greyColor,
              content: Text(
                "Account Already Exist!!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )));
        }
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const Icon(Icons.arrow_back_ios_new_outlined),),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign UP',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.blackColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AuthField(
                    hintText: "Name",
                    controller: nameController,
                    icon: const Icon(Icons.person_2_outlined),
                  ),
                  const SizedBox(
                    height: 10,
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
                    buttonText: 'Sign UP',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          email = emailController.text;
                          password = passController.text;
                        });
                      }
                      registration();
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
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account? ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                          children: [
                            TextSpan(
                                text: 'Sign In',
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
