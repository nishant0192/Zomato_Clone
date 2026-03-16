import 'package:flutter/material.dart';
import '../models/address_model.dart';
import '../models/user_profile.dart';

class CheckoutGoldHeader extends StatelessWidget {
  const CheckoutGoldHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [Colors.blue.shade50.withOpacity(0.5), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C64D4),
              ),
              children: [
                TextSpan(text: 'You saved ₹45 with '),
                TextSpan(
                  text: 'Gold',
                  style: TextStyle(color: Color(0xFFD6A95B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutSpecialOffer extends StatelessWidget {
  const CheckoutSpecialOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pink.shade50),
        gradient: RadialGradient(
          colors: [Colors.orange.shade50.withOpacity(0.3), Colors.white],
          radius: 2,
          center: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Special offer for you',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text('🎁', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF3B1D6D),
                ),
                child: const Center(
                  child: Text(
                    'OTTplay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Get 30+ OTTs at ₹149!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Claim voucher after order is placed',
                      style: TextStyle(color: Color(0xFF1C64D4), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          'ADDED',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.close, color: Colors.green, size: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'FREE',
                    style: TextStyle(
                      color: Color(0xFF1C64D4),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckoutCancellationPolicy extends StatelessWidget {
  const CheckoutCancellationPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CANCELLATION POLICY',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us reduce food waste by avoiding cancellations after placing your order. A 100% cancellation fee will be applied.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutDeliveryDetails extends StatelessWidget {
  final double totalBill;
  const CheckoutDeliveryDetails({super.key, required this.totalBill});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AddressModel>(
      valueListenable: currentAddressNotifier,
      builder: (context, currentAddress, _) {
        return ValueListenableBuilder<UserProfile>(
          valueListenable: currentUserNotifier,
          builder: (context, currentUser, _) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.location_on_outlined,
                    title: currentAddress.title,
                    subtitle: currentAddress.subtitle,
                    showArrow: true,
                    bottomChild: Text(
                      'Add instructions for delivery partner',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    icon: Icons.call_outlined,
                    title:
                        '${currentUser.name}, ${currentUser.mobile.isNotEmpty ? currentUser.mobile : '+91-9999999999'}',
                    showArrow: true,
                  ),
                  const Divider(height: 32),
                  _buildDetailRow(
                    icon: Icons.receipt_long_outlined,
                    title: 'Total Bill',
                    subtitle: 'Incl. taxes and charges',
                    showArrow: true,
                    titleTrailing: Row(
                      children: [
                        Text(
                          '₹${totalBill + 45}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '₹$totalBill',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'You saved ₹45',
                            style: TextStyle(
                              color: Color(0xFF1C64D4),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    String? subtitle,
    bool showArrow = false,
    Widget? titleTrailing,
    Widget? bottomChild,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (titleTrailing != null) ...[
                    const SizedBox(width: 8),
                    titleTrailing,
                  ],
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (bottomChild != null) ...[
                const SizedBox(height: 8),
                bottomChild,
              ],
            ],
          ),
        ),
        if (showArrow)
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      ],
    );
  }
}
