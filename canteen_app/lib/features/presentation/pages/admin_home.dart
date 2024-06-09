import 'package:canteen_app/admin/admin_sign_in.dart';
import 'package:canteen_app/core/theme/pallet.dart';
import 'package:canteen_app/features/presentation/pages/add_items.dart';
import 'package:canteen_app/features/presentation/pages/admin_food_list.dart';
import 'package:canteen_app/features/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.admin_panel_settings_outlined,
            color: AppPallete.blackColor,
          ),
          backgroundColor: AppPallete.purple,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                color: AppPallete.blackColor,
              ),
              tooltip: 'Sign Out',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminSignIn(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthGradientButton(
                    buttonText: 'Add Food',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const addFood(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthGradientButton(
                    buttonText: 'View All Foods',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddminFoodList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
