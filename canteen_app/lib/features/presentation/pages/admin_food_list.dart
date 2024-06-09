import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/foodtile_admin.dart';
import 'package:canteen_app/models/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddminFoodList extends StatefulWidget {
  const AddminFoodList({super.key});

  @override
  State<AddminFoodList> createState() => _AddminFoodListState();
}

class _AddminFoodListState extends State<AddminFoodList> {
  Future<List<Food>> fetchFoods() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('foods').get();
    return snapshot.docs.map((doc) {
      return Food(
        name: doc['name'],
        price: doc['price'],
        imagepath: doc['image'],
        description: doc['description'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.deepPurple,
      appBar: AppBar(
        backgroundColor: AppPallete.purple,
        title: const Text(
          ' Food Lists',
          style: TextStyle(
            color: AppPallete.blackColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Food>>(
                future: fetchFoods(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No food items available'));
                  } else {
                    final foods = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return FoodTilesAdmin(food: foods[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
