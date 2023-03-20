import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  const CategoryMealsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'] ?? 'error';
    final categoryTitle = routeArgs['title'] ?? 'Unknown';
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: const Center(
        child: Text('recipi'),
      ),
    );
  }
}
