// lib/marketplace_page.dart
import 'package:flutter/material.dart';
import 'package:mygame/Groups.dart';
import 'package:mygame/chats_page.dart';
import 'dart:ui';
import 'home_page.dart';
import 'more.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  int _selectedIndex = 3;
  String _selectedCategory = "All";

  final List<Map<String, dynamic>> _products = [
    {
      "title": "Handmade Beeswax Food Wraps Set (3 Sizes)",
      "price": 25.0,
      "seller": "Mouna Hafsi",
      "category": "Kitchen",
      "image": "assets/images/marketplace/Sandwich-Wrapped-Beeswax.jpg",
      "eco": true,
    },
    {
      "title": "Organic Bamboo Toothbrush (4-Pack)",
      "price": 15.0,
      "seller": "Fatima Alami",
      "category": "Personal Care",
      "image": "assets/images/marketplace/bamboo-toothbrush.jpg",
      "eco": true,
    },
    {
      "title": "Reusable Stainless Steel Water Bottle (500ml)",
      "price": 35.0,
      "seller": "Youssef Benali",
      "category": "Hydration",
      "image": "assets/images/marketplace/stainless-water-bottle.jpg",
      "eco": true,
    },
    {
      "title": "Organic Cotton Tote Bag - Natural Dye",
      "price": 20.0,
      "seller": "Amina Khalil",
      "category": "Fashion",
      "image": "assets/images/marketplace/organic-tote-bag.jpg",
      "eco": true,
    },
    {
      "title": "Bamboo Cutlery Set with Pouch",
      "price": 18.0,
      "seller": "Karim Zahir",
      "category": "Travel",
      "image": "assets/images/marketplace/bamboo-cutlery.jpg",
      "eco": true,
    },
    {
      "title": "Swedish Dishcloth Reusable Sponges (Set of 3)",
      "price": 12.0,
      "seller": "Layla Najjar",
      "category": "Kitchen",
      "image": "assets/images/marketplace/swedish-dishcloth.jpg",
      "eco": true,
    },
    {
      "title": "Recycled Ocean Plastic Sunglasses",
      "price": 45.0,
      "seller": "Omar Haddad",
      "category": "Fashion",
      "image": "assets/images/marketplace/recycled-sunglasses.jpg",
      "eco": true,
    },
    {
      "title": "Solid Shampoo Bar - Zero Waste",
      "price": 22.0,
      "seller": "Sofia Rahman",
      "category": "Beauty",
      "image": "assets/images/marketplace/shampoo-bar.jpg",
      "eco": true,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    if (_selectedCategory == "All") return _products;
    return _products.where((p) => p["category"] == _selectedCategory).toList();
  }

  void _onNavTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    final pages = [
      const HomePage(),
      const GroupsPage(),
      const ChatsPage(),
      const MarketplacePage(),
      const MorePage(),
    ];
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => pages[index],
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orbSize = size.width * 0.8;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A0B2E),
              Color(0xFF2A1B4B),
              Color(0xFF3D1B6B),
              Color(0xFF4A1D8A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background orbs – same as HomePage
            ...List.generate(
              6,
              (i) => Positioned(
                top: 40 + i * (size.height * 0.16),
                left: i.isEven ? -orbSize * 0.4 : null,
                right: i.isOdd ? -orbSize * 0.4 : null,
                child: Container(
                  width: orbSize,
                  height: orbSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFA855F7).withOpacity(0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  // Header – same size & style as HomePage
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        _glowText("MARKET", size.width * 0.09),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.add_rounded,
                            color: Colors.white70,
                            size: size.width * 0.075,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white70,
                            size: size.width * 0.075,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Category Chips
                  SizedBox(
                    height: 56,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children:
                          [
                            "All",
                            "Fashion",
                            "Kitchen",
                            "Beauty",
                            "Travel",
                            "Home",
                          ].map((cat) {
                            bool isSelected = _selectedCategory == cat;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedCategory = cat),
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 76, 175, 80),
                                            Color.fromARGB(255, 76, 175, 80),
                                          ],
                                        )
                                      : null,
                                  color: isSelected
                                      ? null
                                      : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.transparent
                                        : Colors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: const Color(
                                              0xFFA855F7,
                                            ).withOpacity(0.6),
                                            blurRadius: 20,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  cat,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Product Grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 220,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.65,
                            ),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) =>
                            _productCard(_filteredProducts[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onNavTap,
              backgroundColor: Colors.transparent,
              selectedItemColor: const Color(0xFFA855F7),
              unselectedItemColor: Colors.white60,
              selectedFontSize: 12,
              unselectedFontSize: 11,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: size.width * 0.07),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.groups, size: size.width * 0.07),
                  label: "Groups",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble_rounded,
                    size: size.width * 0.07,
                  ),
                  label: "Chats",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.storefront_outlined,
                    size: size.width * 0.07,
                  ),
                  label: "Market",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu, size: size.width * 0.07),
                  label: "More",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Product Card – shows DT instead of $
  Widget _productCard(Map<String, dynamic> product) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.6;
        final num priceNum = product["price"] as num;
        final String priceText =
            "${priceNum is int ? priceNum : priceNum.toStringAsFixed(1)} DT";

        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.09),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: const Color(0xFFA855F7).withOpacity(0.15),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: Image.asset(
                    product["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.white.withOpacity(0.08),
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white38,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product["title"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "by ${product["seller"]}",
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11.5,
                        ),
                      ),
                      Text(
                        priceText, // 25 DT, 35 DT, etc.
                        style: const TextStyle(
                          color: Color.fromARGB(255, 76, 175, 80),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Same glow text as HomePage
  Widget _glowText(String text, double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w900,
            foreground: Paint()
              ..color = const Color.fromARGB(
                170,
                32,
                186,
                57,
              ).withOpacity(0.95),
            shadows: [
              Shadow(
                color: const Color.fromARGB(
                  255,
                  143,
                  112,
                  155,
                ).withOpacity(0.9),
                blurRadius: 30,
              ),
            ],
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(172, 60, 182, 64),
              Color.fromARGB(172, 72, 255, 78),
              Color.fromARGB(255, 192, 84, 255),
              Color.fromARGB(255, 209, 129, 255),
              Color.fromARGB(255, 192, 84, 255),
            ],
            stops: [0.0, 0.38, 0.48, 0.65, 1.0],
          ).createShader(bounds),
          child: Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
