import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Category>> getCategories() async {
    final res = await http.get(Uri.parse("$baseUrl/categories.php"));
    final data = jsonDecode(res.body);
    return (data['categories'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final res = await http.get(Uri.parse("$baseUrl/filter.php?c=$category"));
    final data = jsonDecode(res.body);
    return (data['meals'] as List)
        .map((json) => Meal.fromSimple(json))
        .toList();
  }

  Future<Meal> getMealDetail(String id) async {
    final res = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));
    final data = jsonDecode(res.body);
    return Meal.fromFull(data['meals'][0]);
  }

  Future<Meal> getRandomMeal() async {
    final res = await http.get(Uri.parse("$baseUrl/random.php"));
    final data = jsonDecode(res.body);
    return Meal.fromFull(data['meals'][0]);
  }

Future<List<Meal>> searchMeals(String query) async {
  final res = await http.get(Uri.parse("$baseUrl/search.php?s=$query"));
  final data = jsonDecode(res.body);

  if (data['meals'] == null) return [];

  return (data['meals'] as List)
      .map((json) => Meal.fromSimple(json))
      .toList();
}
}