class Meal {
  final String id;
  final String name;
  final String thumb;
  final String? instructions;
  final String? youtube;
  final Map<String, String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumb,
    this.instructions,
    this.youtube,
    required this.ingredients,
  });

  // кратка форма (filter.php)
  factory Meal.fromSimple(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumb: json['strMealThumb'],
      instructions: null,
      youtube: null,
      ingredients: {},
    );
  }

  // целосна форма (lookup.php)
  factory Meal.fromFull(Map<String, dynamic> json) {
    Map<String, String> ingreds = {};

    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ing != null && ing.toString().trim().isNotEmpty) {
        ingreds[ing] = measure;
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumb: json['strMealThumb'],
      instructions: json['strInstructions'],
      youtube: json['strYoutube'],
      ingredients: ingreds,
    );
  }
}
