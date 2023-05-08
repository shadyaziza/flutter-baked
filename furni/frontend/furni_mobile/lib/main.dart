import 'package:flutter/material.dart';

import 'core/core.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black54,
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0.0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(
              Size(double.infinity, 66),
            ),
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            foregroundColor: const MaterialStatePropertyAll(
              Color(
                0xff514970,
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        FurnitureItemDetailsScreen.routeName: (context) =>
            const FurnitureItemDetailsScreen(),
      },
    );
  }
}
