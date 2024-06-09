import 'dart:io';

import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:canteen_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class addFood extends StatefulWidget {
  const addFood({super.key});

  @override
  State<addFood> createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {
  final ImagePicker picker = ImagePicker();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? selectedImage;

  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadFood() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("Images").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addFood = {
        "image": downloadUrl,
        "name": nameController.text,
        "price": priceController.text,
        "description": descriptionController
      };
      await DatabaseMEthods()
          .addFood(
            addFood,
          )
          .then();
      selectedImage = null;
      nameController.text = "";
      priceController.text = "";
      descriptionController.text = "";
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppPallete.transparentColor,
          content: Text(
            "Food Item Uploaded!!!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppPallete.blackColor,
            ),
          )));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppPallete.transparentColor,
          content: Text(
            "No Picture Selected",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppPallete.blackColor,
            ),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            child: Form(
              key: formKey,
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
                  selectedImage == null
                      ? GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: AppPallete.whiteColor,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  const BoxShadow(
                                    color: AppPallete.deepPurple,
                                    blurRadius: 20,
                                    offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: AppPallete.blackColor,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: AppPallete.deepPurple,
                                      blurRadius: 20,
                                      offset: Offset(4, 8), // Shadow position
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthField(
                    hintText: "Name",
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthField(
                    hintText: "Price",
                    controller: priceController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthField(
                    hintText: "Description",
                    controller: descriptionController,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthGradientButton(
                      buttonText: "ADD",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                        uploadFood();
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
