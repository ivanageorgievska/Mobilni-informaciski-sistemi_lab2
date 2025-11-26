import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(MealApp());
}

class MealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meal Recipes",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: CategoriesScreen(),
    );
  }
}
