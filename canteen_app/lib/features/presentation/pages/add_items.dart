import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class addFood extends StatefulWidget {
  const addFood({super.key});

  @override
  State<addFood> createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios_new_outlined),
          title: const Text(
            "Add Food Items",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppPallete.blackColor,
            ),
          ),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 350),
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Upload the image.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.blackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppPallete.blackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthField(hintText: "Name", controller: nameController),
          
                const SizedBox(
                  height: 20,
                ),
                AuthField(hintText: "Price", controller: priceController),
          
                const SizedBox(
                  height: 20,
                ),
                AuthField(hintText: "Description", controller: descriptionController, ),

                const SizedBox(
                  height: 20,
                ),

                AuthGradientButton(buttonText: "ADD", onPressed: (){
                  
                })
              ],
            ),
          ),
        ));
  }
}
