import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Base shimmer wrapper — wraps children in an animated shimmer effect.
class ShimmerLoading extends StatelessWidget {
  final Widget child;

  const ShimmerLoading({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}

/// Rounded rectangle placeholder.
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Circle placeholder.
class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pre-composed section skeletons
// ---------------------------------------------------------------------------

/// Matches CategoryList — row of circles with text beneath.
class CategoryListSkeleton extends StatelessWidget {
  const CategoryListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (_, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ShimmerCircle(size: 60),
              SizedBox(height: 8),
              ShimmerBox(width: 48, height: 10, radius: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// Matches FilterBar — row of rounded pill chips.
class FilterBarSkeleton extends StatelessWidget {
  const FilterBarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 4,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, index) => ShimmerBox(
            width: index == 0 ? 90 : 80,
            height: 32,
            radius: 10,
          ),
        ),
      ),
    );
  }
}

/// Matches RestaurantCarouselSection — 2-row × n-col grid of square cards.
class RestaurantCarouselSkeleton extends StatelessWidget {
  const RestaurantCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ShimmerBox(width: 200, height: 14, radius: 4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 410,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    _buildCardSkeleton(),
                    const SizedBox(height: 12),
                    _buildCardSkeleton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerBox(width: 140, height: 140, radius: 16),
        SizedBox(height: 8),
        ShimmerBox(width: 120, height: 10, radius: 4),
        SizedBox(height: 6),
        ShimmerBox(width: 80, height: 8, radius: 4),
      ],
    );
  }
}

/// Matches ExploreMoreSection — horizontal scrolling small cards.
class ExploreMoreSkeleton extends StatelessWidget {
  const ExploreMoreSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ShimmerBox(width: 130, height: 12, radius: 4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 102,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => const ShimmerBox(
                width: 90,
                height: 90,
                radius: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Matches a single restaurant card in RestaurantListSection.
class RestaurantCardSkeleton extends StatelessWidget {
  const RestaurantCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area — 16:9 ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              ),
            ),
            // Details area
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: ShimmerBox(width: double.infinity, height: 16, radius: 4),
                      ),
                      SizedBox(width: 12),
                      ShimmerBox(width: 48, height: 22, radius: 6),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const ShimmerBox(width: 200, height: 12, radius: 4),
                  const SizedBox(height: 10),
                  const ShimmerBox(width: 160, height: 12, radius: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full homescreen skeleton — composes all skeletons in order.
class HomeSkeletonLoading extends StatelessWidget {
  const HomeSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carousel section skeleton
        const RestaurantCarouselSkeleton(),
        const SizedBox(height: 8),
        // Explore more skeleton
        const ExploreMoreSkeleton(),
        const SizedBox(height: 16),
        // Section header skeleton
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ShimmerLoading(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 240, height: 12, radius: 4),
                SizedBox(height: 8),
                ShimmerBox(width: 100, height: 14, radius: 4),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Restaurant card skeletons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: List.generate(
              3,
              (index) => const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: RestaurantCardSkeleton(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
