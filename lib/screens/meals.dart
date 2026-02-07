import 'package:flutter/material.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  final String title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (meals.isEmpty) {
      bodyContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    } else {
      bodyContent = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          final meal = meals[index];
          return MealItem(meal: meal, onToggleFavorite: onToggleFavorite);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: isFavorite ? MainDrawer() : null,
      body: bodyContent,
    );
  }
}
