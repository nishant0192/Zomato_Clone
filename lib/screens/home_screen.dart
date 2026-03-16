import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import '../widgets/top_bar.dart';
import '../widgets/search_area.dart';
import '../widgets/promo_banner.dart';
import '../widgets/category_list.dart';
import '../widgets/filter_bar.dart';
import '../widgets/restaurant_carousel_section.dart';
import '../widgets/all_restaurants_section.dart';
import '../models/app_data.dart';
import '../models/filter_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Restaurant> _restaurants = [];
  bool _isLoading = true;
  FilterOptions _filterOptions = FilterOptions();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/restaurants.json',
      );
      final List<dynamic> data = json.decode(response);
      setState(() {
        _restaurants = data.map((json) => Restaurant.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading restaurants: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BottomBar(
        fit: StackFit.expand,
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: Colors.white,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        showIcon: true,
        width: MediaQuery.of(context).size.width * 0.9,
        barColor: Colors.white,
        start: 2,
        end: 0,
        offset: 10,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 30,
        iconWidth: 30,
        reverse: false,
        hideOnScroll: true,
        scrollOpposite: false,
        onBottomBarHidden: null,
        onBottomBarShown: null,
        body: (context, controller) => SafeArea(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildHomeTab(controller),
              const Center(child: Text('Under ₹250')),
              const Center(child: Text('Dining')),
              const Center(child: Text('Healthy')),
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: TabBar(
              controller: _tabController,
              indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.deepOrange, width: 4),
                insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
              ),
              labelColor: Colors.deepOrange,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(icon: Icon(Icons.home_outlined), text: 'Home'),
                Tab(icon: Icon(Icons.monetization_on_outlined), text: 'Deals'),
                Tab(icon: Icon(Icons.restaurant_menu), text: 'Dining'),
                Tab(icon: Icon(Icons.favorite_outline), text: 'Healthy'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab(ScrollController controller) {
    // Apply filters
    List<Restaurant> filteredRestaurants = _restaurants.where((r) {
      if (_filterOptions.isPureVeg && !r.isVeg) return false;
      if (_filterOptions.minRating != null &&
          r.rating < _filterOptions.minRating!) {
        return false;
      }
      if (_filterOptions.nearAndFast) {
        // Assume < 30 mins is near and fast
        final timeStr = r.time.split(' ').first;
        final time = int.tryParse(timeStr);
        if (time != null && time > 30) return false;
      }
      if (_filterOptions.activeOffers.isNotEmpty) {
        bool match = false;
        for (final offer in _filterOptions.activeOffers) {
          if (offer == 'Buy 1 Get 1 and more' &&
              (r.offer.contains('Buy 1 Get 1') || r.offer.contains('BOGO'))) {
            match = true;
          } else if (offer == 'Gold offers' && r.isPromoted) {
            match = true;
          } else if (offer == 'Deals of the Day' && r.offer.isNotEmpty) {
            match = true;
          }
        }
        if (!match) return false;
      }
      return true;
    }).toList();

    // Apply sorting
    if (_filterOptions.sortBy == 'Rating') {
      filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_filterOptions.sortBy == 'Delivery Time') {
      filteredRestaurants.sort((a, b) {
        final timeA = int.tryParse(a.time.split(' ').first) ?? 0;
        final timeB = int.tryParse(b.time.split(' ').first) ?? 0;
        return timeA.compareTo(timeB);
      });
    }
    // Relevance is default (no sort or original sort)

    return Column(
      children: [
        const TopBar(),
        const SizedBox(height: 8),
        SearchArea(
          isVegOnly: _filterOptions.isPureVeg,
          onVegToggle: (val) {
            setState(() {
              _filterOptions = _filterOptions.copyWith(isPureVeg: val);
            });
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            controller: controller, // Essential for hiding the bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PromoBanner(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: CategoryList(),
                ),
                const SizedBox(height: 16),
                FilterBar(
                  currentFilters: _filterOptions,
                  onApplyFilters: (newFilters) {
                    setState(() {
                      _filterOptions = newFilters;
                    });
                  },
                ),
                const SizedBox(height: 24),

                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantCarouselSection(
                        restaurants: filteredRestaurants,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 24),
                      AllRestaurantsSection(
                        restaurants: filteredRestaurants,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                const SizedBox(height: 100), // Extra space for floating bar
              ],
            ),
          ),
        ),
      ],
    );
  }
}
