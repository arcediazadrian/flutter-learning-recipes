import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-recipes';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      _displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (builderContext, index) {
          return MealItem(
            id: _displayedMeals[index].id,
            title: _displayedMeals[index].title,
            imageUrl: _displayedMeals[index].imageUrl,
            duration: _displayedMeals[index].duration,
            affordability: _displayedMeals[index].affordability,
            complexity: _displayedMeals[index].complexity,
            //removeItem: _removeMeal,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
