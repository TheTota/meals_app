import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  const CategoryMealsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'] ?? 'error';
    final categoryTitle = routeArgs['title'] ?? 'Unknown';
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            final meal = categoryMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              affordability: meal.affordability,
              complexity: meal.complexity,
            );
          }),
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
