import 'package:flutter/material.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex = 0;

  final List<Meal> favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        favoriteMeals.remove(meal);
        _showInfoMessage('Meal removed from favorites.');
      } else {
        favoriteMeals.add(meal);
        _showInfoMessage('Meal added to favorites.');
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    if (selectedPageIndex == 0) {
      activePage = CategoriesScreen(onToggleFavorite: _toggleFavorite);
    } else {
      activePage = MealsScreen(
        isFavorite: true,
        title: "Favorites",
        meals: favoriteMeals,
        onToggleFavorite: _toggleFavorite,
      );
    }

    return Scaffold(
      body: Center(child: activePage),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
