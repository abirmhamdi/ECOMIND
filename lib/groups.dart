// lib/groups_page.dart
import 'package:flutter/material.dart';
import 'package:mygame/chats_page.dart';
import 'package:mygame/marketplace.dart';
import 'dart:ui';
import 'home_page.dart';
import 'more.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});
  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  int _selectedIndex = 1;

  final List<Map<String, dynamic>> _myGroups = [
    {
      "name": "Tounes Tech",
      "members": "18.7K",
      "image": "assets/images/groups/tounes-tech.jpg",
    },
    {
      "name": "9a3da w kresi",
      "members": "81.4K",
      "image": "assets/images/groups/9a3da-w-kresi.jpg",
    },
    {
      "name": "Bac 2026 Warriors",
      "members": "124.9K",
      "image": "assets/images/groups/bac-2026-warriors.jpg",
    },
  ];

  final List<Map<String, dynamic>> _trendingGroups = [
    {
      "name": "Eco Tunisia",
      "members": "73.1K",
      "image": "assets/images/groups/eco-tunisia.jpg",
    },
    {
      "name": "Cat Lovers",
      "members": "95.2K",
      "image": "assets/images/groups/cat-lovers.jpg",
    },
    {
      "name": "Tounes Gaming",
      "members": "68.4K",
      "image": "assets/images/groups/tounes-gaming.jpg",
    },
    {
      "name": "Startup Tunisia",
      "members": "27.5K",
      "image": "assets/images/groups/startup-tunisia.jpg",
    },

    {
      "name": "Movies Lovers tn",
      "members": "48.6K",
      "image": "assets/images/groups/movies-lovers-tn.jpg",
    },
  ];

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
    final orbSize = size.width * 0.85;

    const Color purpleMain = Color(0xFFA855F7);

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
            // Floating purple orbs — same as HomePage
            ...List.generate(
              6,
              (i) => Positioned(
                top: 30 + i * (size.height * 0.17),
                left: i.isEven ? -orbSize * 0.4 : null,
                right: i.isOdd ? -orbSize * 0.4 : null,
                child: Container(
                  width: orbSize,
                  height: orbSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        purpleMain.withOpacity(0.38),
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
                  // Header with ECOMIND glow
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        _glowText("GROUPS", size.width * 0.09),
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

                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                      ),
                      children: [
                        const SizedBox(height: 12),

                        // My Groups
                        _sectionTitle("My Groups"),
                        const SizedBox(height: 16),
                        ..._myGroups.map(
                          (group) => _groupCard(group, true, size),
                        ),
                        const SizedBox(height: 40),

                        // Discover Trending
                        _sectionTitle("Discover Trending"),
                        const SizedBox(height: 16),
                        ..._trendingGroups.map(
                          (group) => _groupCard(group, false, size),
                        ),
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Same glass bottom navigation
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
              selectedItemColor: purpleMain,
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

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  // EXACT SAME CARD AS YOUR HOME PAGE POSTS
  Widget _groupCard(Map<String, dynamic> group, bool isJoined, Size size) {
    final String profileImage = group["image"] ?? "assets/images/avatar.png";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
          BoxShadow(
            color: const Color(0xFFA855F7).withOpacity(0.2),
            blurRadius: 40,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: size.width * 0.065,
            backgroundImage: AssetImage(profileImage),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group["name"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${group["members"]} members",
                  style: const TextStyle(color: Colors.white60, fontSize: 15),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isJoined
                ? null
                : () {
                    setState(() {
                      _myGroups.insert(0, group);
                      _trendingGroups.removeWhere(
                        (g) => g["name"] == group["name"],
                      );
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: isJoined
                  ? Colors.white.withOpacity(0.2)
                  : const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: isJoined ? 0 : 15,
              shadowColor: isJoined
                  ? Colors.transparent
                  : const Color(0xFF4CAF50).withOpacity(0.7),
            ),
            child: Text(
              isJoined ? "Joined" : "Join",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // EXACT SAME GLOW FROM YOUR HOME PAGE
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

        // Layer 3: The actual text with your exact gradient — no white anywhere
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(172, 60, 182, 64), // ECO start
              Color.fromARGB(172, 72, 255, 78), // ECO soft
              Color.fromARGB(255, 192, 84, 255), // Transition
              Color.fromARGB(255, 209, 129, 255), // MIND main
              Color.fromARGB(255, 192, 84, 255), // MIND end
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
