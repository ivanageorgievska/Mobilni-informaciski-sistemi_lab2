import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'meal_detail_screen.dart';

class MealsByCategoryScreen extends StatefulWidget {
  final String category;

  const MealsByCategoryScreen({super.key, required this.category});

  @override
  _MealsByCategoryScreenState createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  final ApiService api = ApiService();

  List<Meal> meals = [];
  List<Meal> filtered = [];

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  void loadMeals() async {
    meals = await api.getMealsByCategory(widget.category);
    filtered = meals;
    setState(() {});
  }

  void searchMeals(String query) async {
    if (query.trim().isEmpty) {
      filtered = meals;
      setState(() {});
      return;
    }

    final searchResults = await api.searchMeals(query);

    // само јадењата што припаѓаат на оваа категорија
    filtered = searchResults
        .where((meal) => meal.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: searchMeals,
              decoration: InputDecoration(
                hintText: "Пребарувај јадења...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final meal = filtered[index];
                return GestureDetector(
                  onTap: () async {
                    final fullMeal = await api.getMealDetail(meal.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailScreen(meal: fullMeal),
                      ),
                    );
                  },
                  child: MealItem(meal: meal),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
