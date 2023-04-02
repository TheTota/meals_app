import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> currentFilters;
  final Function saveFilters;

  const FiltersScreen({
    super.key,
    required this.currentFilters,
    required this.saveFilters,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Map<String, bool> selectedFiltersData = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
              };
              widget.saveFilters(selectedFiltersData);
            },
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (newValue) => setState(() {
                    _glutenFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                  (newValue) => setState(() {
                    _lactoseFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                  (newValue) => setState(() {
                    _vegetarian = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegan free',
                  'Only include vegan meals',
                  _vegan,
                  (newValue) => setState(() {
                    _vegan = newValue;
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(
    String title,
    String desc,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(desc),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
