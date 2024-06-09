import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/models/food.dart';
import 'package:flutter/material.dart';

class FoodTilesAdmin extends StatelessWidget {
  Food food;
  FoodTilesAdmin({super.key, required this.food});

  @override
  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 180,
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  food.imagepath,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            const SizedBox(
              width: 70,
            ),
            Text(
              food.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
