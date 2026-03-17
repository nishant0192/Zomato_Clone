import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'All',
        'image':
            'https://plus.unsplash.com/premium_photo-1700677185820-c38b28c3dd06',
      },
      {
        'name': 'North Indian',
        'image':
            'https://plus.unsplash.com/premium_photo-1700677185820-c38b28c3dd06',
      },
      {
        'name': 'Biryani',
        'image':
            'https://plus.unsplash.com/premium_photo-1700677185820-c38b28c3dd06',
      },
      {
        'name': 'Chinese',
        'image':
            'https://plus.unsplash.com/premium_photo-1700677185820-c38b28c3dd06',
      },
      {
        'name': 'New',
        'image':
            'https://plus.unsplash.com/premium_photo-1700677185820-c38b28c3dd06',
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: isSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green, width: 3.0),
                      ),
                    )
                  : null,
              padding: const EdgeInsets.only(
                bottom: 4,
              ), // Padding to space out the green border
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: NetworkImage(cat['image']!),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
