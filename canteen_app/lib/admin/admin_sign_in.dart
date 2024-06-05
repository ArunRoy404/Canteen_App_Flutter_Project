import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/admin_home.dart';
import 'package:canteen_app/features/presentation/pages/sign_in_page.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final usernameController = TextEditingController();
  final userpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Admin Panel',
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
                  hintText: "Username",
                  controller: usernameController,
                  icon: const Icon(Icons.person_2_outlined),
                ),
                const SizedBox(
                  height: 10,
                ),
                
                AuthField(
                  hintText: "Password",
                  controller: userpasswordController,
                  isObsecureText: true,
                  icon: const Icon(Icons.password_outlined),
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthGradientButton(
                  buttonText: 'Log IN',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                          
                        }
                        loginAdmin();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  loginAdmin() {
    FirebaseFirestore.instance.collection("admin").get().then((snapshot) {
      snapshot.docs.forEach((result){
        if(result.data()['username']!= usernameController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppPallete.transparentColor,
            content: Text(
              "Invalid username!!!",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppPallete.blackColor,
              ),
            )));
        }
        else if(result.data()['password'] != userpasswordController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppPallete.transparentColor,
            content: Text(
              "Invalid Password!!!",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppPallete.blackColor,
              ),
            )));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminHome() ));
        }
      });
    });
  }
}
