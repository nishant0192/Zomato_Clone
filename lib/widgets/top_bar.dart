import 'package:flutter/material.dart';
import '../screens/profile_screen.dart' as profile_screen;
import '../screens/location_screen.dart';
import '../models/user_profile.dart';
import '../models/address_model.dart';

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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.black87),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ValueListenableBuilder<AddressModel>(
                      valueListenable: currentAddressNotifier,
                      builder: (context, currentAddress, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    currentAddress.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down, size: 20),
                              ],
                            ),
                            Text(
                              currentAddress.subtitle,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/district_logo.jpeg',
                  height: 38,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              _buildIconContainer(
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 20,
                  color: Colors.black87,
                ),
                color: Colors.white,
                borderColor: Colors.grey.shade400,
                width: 38,
                height: 38,
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const profile_screen.ProfileScreen(),
                    ),
                  );
                },
                child: _buildIconContainer(
                  child: ValueListenableBuilder<UserProfile>(
                    valueListenable: currentUserNotifier,
                    builder: (context, userProfile, child) {
                      final initial = userProfile.name.isNotEmpty
                          ? userProfile.name[0].toUpperCase()
                          : '?';
                      return Text(
                        initial,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                  color: Colors.orange.shade100,
                  borderColor: Colors.orange,
                  width: 38,
                  height: 38,
                ),
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
    double? height,
    Color? borderColor,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1.5)
            : null,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
