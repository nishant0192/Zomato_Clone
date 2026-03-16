import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'All', 'image': 'assets/cat_all.png'},
      {'name': 'North Indian', 'image': 'assets/cat_north.png'},
      {'name': 'Biryani', 'image': 'assets/cat_biryani.png'},
      {'name': 'Chinese', 'image': 'assets/cat_chinese.png'},
      {'name': 'New', 'image': 'assets/cat_new.png'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade100,
                  child: Icon(
                    _getIconForCategory(cat['name']!),
                    color: Colors.deepOrange,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cat['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'all':
        return Icons.grid_view;
      case 'north indian':
        return Icons.soup_kitchen;
      case 'biryani':
        return Icons.rice_bowl;
      case 'chinese':
        return Icons.ramen_dining;
      case 'new':
        return Icons.fiber_new;
      default:
        return Icons.fastfood;
    }
  }
}
