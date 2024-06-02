import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:canteen_app/features/presentation/widgets/food_tiles.dart';
import 'package:canteen_app/models/food.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchcontroller = TextEditingController();

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  Future<List<Food>> fetchFoods() async {
    // Simulating network request with a delay
    await Future.delayed(const Duration(seconds: 2));
    // Here, you would normally fetch data from an API or database
    // For this example, we are returning a hardcoded list of foods
    return [
      Food(
        name: 'Burger',
        price: '200',
        imagepath: 'lib/images/burger.png',
        description: 'Not a Healthy Food!',
      ),
      Food(
        name: 'Pizza',
        price: '300',
        imagepath: 'lib/images/pizza.png',
        description: 'Delicious Italian Pizza!',
      ),
      Food(
        name: 'Pasta',
        price: '250',
        imagepath: 'lib/images/pasta.png',
        description: 'Tasty Pasta!',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text(
          'Welcome',
          style: TextStyle(
            color: AppPallete.blackColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order your favorite FOOD!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: AuthField(
                    hintText: 'Search',
                    controller: searchcontroller,
                    icon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(width: 10),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Icon(
                    Icons.menu_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Recommended Foods',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return FoodTiles(food: foods[index]);
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(
                top: 25,
                left: 25,
                right: 25,
              ),
              child: Divider(color: Colors.white),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppPallete.deepPurple,
        color: Colors.deepPurple.shade200,
        items: [
          const Icon(
            Icons.home_outlined,
            semanticLabel: 'Home',
            color: AppPallete.blackColor,
          ),
          const Icon(
            Icons.fastfood_outlined,
            semanticLabel: 'Menu',
            color: AppPallete.blackColor,
          ),
          const Icon(
            Icons.shopping_cart_outlined,
            semanticLabel: 'Cart',
            color: AppPallete.blackColor,
          ),
          const Icon(
            Icons.person_outline,
            semanticLabel: 'Profile',
            color: AppPallete.blackColor,
          ),
        ],
      ),
    );
  }
}
