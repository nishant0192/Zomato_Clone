import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.black87),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Flexible(
                            child: Text(
                              'Hallmark Business...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, size: 20),
                        ],
                      ),
                      const Text(
                        'Sant Dnyaneshwar Nagar, Bandra...',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              _buildIconContainer(
                child: const Text(
                  'district',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                width: 45,
              ),
              const SizedBox(width: 4),
              _buildIconContainer(
                child: const Icon(Icons.card_giftcard, size: 16),
                color: Colors.white,
                borderColor: Colors.grey.shade300,
                width: 32,
              ),
              const SizedBox(width: 4),
              _buildIconContainer(
                child: const Text(
                  'N',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Colors.orange.shade100,
                borderColor: Colors.orange,
                width: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer({
    required Widget child,
    Color color = Colors.transparent,
    double? width,
    Color? borderColor,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
