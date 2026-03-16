import 'package:flutter/material.dart';

class SearchArea extends StatelessWidget {
  final bool isVegOnly;
  final ValueChanged<bool> onVegToggle;

  const SearchArea({
    super.key,
    required this.isVegOnly,
    required this.onVegToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.deepOrange),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search 'curries'",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(width: 1, height: 24, color: Colors.grey.shade300),
                  const SizedBox(width: 8),
                  const Icon(Icons.mic, color: Colors.deepOrange),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              const Text(
                'VEG',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Switch(
                value: isVegOnly,
                onChanged: onVegToggle,
                activeThumbColor: Colors.white,
                inactiveThumbColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.redAccent,
                trackOutlineColor: WidgetStateProperty.all(
                  Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
