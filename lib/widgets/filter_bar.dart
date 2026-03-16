import 'package:flutter/material.dart';
import 'filter_sheet.dart';
import '../models/filter_options.dart';

class FilterBar extends StatelessWidget {
  final FilterOptions currentFilters;
  final ValueChanged<FilterOptions> onApplyFilters;

  const FilterBar({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['Near & Fast', 'Gourmet', 'Top Rated'];

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<FilterOptions>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>
                    FilterSheet(initialFilters: currentFilters),
              );

              if (result != null) {
                onApplyFilters(result);
              }
            },
            child: _buildFilterChip(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.tune, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Filters',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_drop_down, size: 18),
                ],
              ),
            ),
          ),
          ...filters.map(
            (filter) => Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _buildFilterChip(
                child: Text(
                  filter,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required Widget child}) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
