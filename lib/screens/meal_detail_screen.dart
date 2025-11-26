import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(meal.thumb),
            ),

            SizedBox(height: 16),

            /// NAME
            Text(
              meal.name,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 16),

            /// INGREDIENTS
            Text(
              "Состојки",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),

            ...meal.ingredients.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "• ${entry.key} — ${entry.value}",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }).toList(),

            SizedBox(height: 20),

            /// INSTRUCTIONS
            Text(
              "Инструкции",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              meal.instructions ?? "",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),

            /// YOUTUBE LINK
            if (meal.youtube != null && meal.youtube!.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () async {
                  final url = Uri.parse(meal.youtube!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                icon: Icon(Icons.video_library),
                label: Text("Погледни на YouTube"),
              ),
          ],
        ),
      ),
    );
  }
}
