import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';

class PromoBanner extends StatefulWidget {
  final double? topPadding;

  const PromoBanner({super.key, this.topPadding});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _promos = [
    {
      'title': 'CRAVING A\nBURGER?',
      'subtitle': 'BEST IN TOWN',
      'colors': [Colors.orange.shade800, Colors.orange.shade500],
      'lottiePath': 'assets/lottie/burger.json',
      'buttonText': 'Order now',
    },
    {
      'title': 'SPICE UP\nYOUR DAY',
      'subtitle': 'AUTHENTIC MEXICAN',
      'colors': [Colors.red.shade800, Colors.red.shade400],
      'lottiePath': 'assets/lottie/Mexican Burrito.json',
      'buttonText': 'Explore',
    },
    {
      'title': 'FREE\nDELIVERY',
      'subtitle': 'ON ORDERS ABOVE ₹149',
      'colors': [Colors.purple.shade800, Colors.purple.shade400],
      'lottiePath': 'assets/lottie/delivery.json',
      'buttonText': 'Claim now',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.topPadding != null) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              // Allow it to fill the height forced upon it by the sticky header
              height: 260.0 + widget.topPadding!,
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: _promos.map((promo) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      gradient: LinearGradient(
                        colors: promo['colors'] as List<Color>,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.0,
                            right: 140.0,
                            bottom: 40.0,
                            top: 40.0 + widget.topPadding!,
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  promo['title'] as String,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    height: 1.1,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    promo['subtitle'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        promo['buttonText'] as String,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -10,
                          bottom: -20,
                          child: promo.containsKey('lottiePath')
                              ? SizedBox(
                                  width: 220,
                                  height: 220,
                                  child: Lottie.asset(
                                    promo['lottiePath'] as String,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Transform.rotate(
                                  angle: -0.2,
                                  child: Icon(
                                    promo['icon'] as IconData,
                                    size: 160,
                                    color: Colors.white.withOpacity(0.15),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _promos.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                      _currentIndex == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.92,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _promos.map((promo) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: promo['colors'] as List<Color>,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (promo['colors'] as List<Color>)[0].withOpacity(
                          0.3,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          top: 20.0,
                          bottom: 20.0,
                          right: 140.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                promo['title'] as String,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  promo['subtitle'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      promo['buttonText'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.topPadding != null)
                                const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: promo.containsKey('lottiePath')
                            ? SizedBox(
                                width: 180,
                                height: 180,
                                child: Lottie.asset(
                                  promo['lottiePath'] as String,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Transform.rotate(
                                angle: -0.2,
                                child: Icon(
                                  promo['icon'] as IconData,
                                  size: 160,
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                      ),
                      Positioned(
                        right: 40,
                        top: 30,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      Positioned(
                        right: 80,
                        bottom: 40,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        if (widget.topPadding == null)
          Column(
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _promos.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).primaryColor).withOpacity(
                        _currentIndex == entry.key ? 0.9 : 0.2,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          )
        else
          Transform.translate(
            offset: const Offset(0, -25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _promos.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                      _currentIndex == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
