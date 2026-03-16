import 'package:flutter/material.dart';

class SelectableBoxOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showCloseIcon;
  final VoidCallback? onClose;

  const SelectableBoxOption({
    super.key,
    required this.icon,
    required this.text,
    this.color = Colors.black87,
    required this.isSelected,
    required this.onTap,
    this.showCloseIcon = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 100),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.deepOrange.shade50 : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
                width: isSelected ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.deepOrange : color,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.deepOrange : Colors.black87,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        if (showCloseIcon && isSelected)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onClose ?? onTap,
              child: const Icon(Icons.close, size: 16, color: Colors.black54),
            ),
          ),
      ],
    );
  }
}
