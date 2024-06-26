import 'package:canteen_app/core/theme/pallet.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecureText;
  final Color fillColor;
  final Icon? icon;
  final int? maxLines;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecureText = false,
    this.fillColor = AppPallete.whiteColor,
    this.icon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        maxLines: maxLines,
        style: const TextStyle(color: AppPallete.blackColor),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: fillColor,
          filled: true,
          prefixIcon: icon,
          prefixIconColor: AppPallete.blackColor,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.transparent, // Ensure transparency
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "$hintText is missing!";
          }
          return null;
        },
        obscureText: isObsecureText,
      ),
    );
  }
}
