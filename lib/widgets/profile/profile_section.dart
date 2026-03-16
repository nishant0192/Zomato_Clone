import 'package:flutter/material.dart';

class ProfileSectionContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSectionContainer({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 20, bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E3333),
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
