import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/widgets/auth_field.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchcontroller = TextEditingController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: AuthField(
                      hintText: 'Search',
                      controller: searchcontroller,
                    ),
                  ),
                  const SizedBox(
                      width:
                          10), // Adds some space between the text field and the icon
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
              // ignore: prefer_const_constructors
            ),
            const Icon(
              Icons.person_outline,
              semanticLabel: 'Profile',
              color: AppPallete.blackColor,
            ),
          ],
        ));
  }
}
