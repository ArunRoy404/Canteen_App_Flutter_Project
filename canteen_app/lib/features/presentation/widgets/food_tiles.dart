import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/food_viiew.dart';
import 'package:canteen_app/models/food.dart';
import 'package:flutter/material.dart';

class FoodTiles extends StatelessWidget {
  Food food;
  FoodTiles({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(left: 25),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color: AppPallete.blackColor,
            blurRadius: 20,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodViiew(food: food),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  food.imagepath,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error_outline,
                      color: AppPallete.blackColor,
                      size: 100,
                    );
                  },
                ),
              ),
            ),
          ),
          Text(
            food.description,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        color: AppPallete.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      'BDT ' + food.price,
                      style: const TextStyle(
                        color: AppPallete.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: AppPallete.blackColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: const Icon(
                    Icons.add_outlined,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
