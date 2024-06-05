import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/cart_page.dart';
import 'package:canteen_app/features/presentation/pages/home_page.dart';
import 'package:canteen_app/features/presentation/pages/menu_page.dart';
import 'package:canteen_app/features/presentation/pages/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNAvState();
}

class _BottomNAvState extends State<BottomNav> {
  late List<Widget> pages;
  late HomePage home;
  late MenuPage menu;
  late CartPage cart;
  late ProfilePage profile;
  int currentIndex = 0;

  @override
  void initState() {
    home = const HomePage();
    menu = const MenuPage();
    cart = const CartPage();
    profile = const ProfilePage();

    pages = [home, menu, cart, profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppPallete.deepPurple,
          color: AppPallete.purple,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
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
          ]),
      body: pages[currentIndex],
    );
  }
}
