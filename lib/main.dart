import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/category_meals_screen.dart';
import '../screens/meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodySmall: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) {
          return TabsScreen(
            favoriteMeals: _favoriteMeals,
          );
        },
        CategoryMealsScreen.routeName: (context) {
          return CategoryMealsScreen(
            availableMeals: _availableMeals,
          );
        },
        MealDetailScreen.routeName: (context) {
          return MealDetailScreen(
            toggleFavorite: _toggleFavorite,
            isMealFavorite: _isMealFavorite,
          );
        },
        FiltersScreen.routeName: (context) {
          return FiltersScreen(
            currentFilters: _filters,
            saveFilters: _setFilters,
          );
        },
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => const CategoriesScreen()),
    );
  }

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters.containsKey('gluten') &&
            _filters['gluten']! &&
            !meal.isGlutenFree) {
          return false;
        }
        if (_filters.containsKey('lactose') &&
            _filters['lactose']! &&
            !meal.isLactoseFree) {
          return false;
        }
        if (_filters.containsKey('vegetarian') &&
            _filters['vegetarian']! &&
            !meal.isVegetarian) {
          return false;
        }
        if (_filters.containsKey('vegan') &&
            _filters['vegan']! &&
            !meal.isVegan) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => mealId == meal.id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => mealId == meal.id);
  }
}
