import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  ApiService api = ApiService();
  List<Category> categories = [];
  List<Category> filtered = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    categories = await api.getCategories();
    filtered = categories;
    setState(() {});
  }

  void search(String query) {
    query = query.toLowerCase();
    filtered = categories.where((c) =>
        c.name.toLowerCase().contains(query)
    ).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Категории"),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () async {
              final meal = await api.getRandomMeal();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MealDetailScreen(meal: meal)),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Пребарувај категории...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (_) => MealsByCategoryScreen(category: filtered[i].name),
                      ),
                    );
                  },
                  child: CategoryCard(category: filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
