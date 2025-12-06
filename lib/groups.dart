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
  int _selectedIndex = 1; // Groups tab active

  final List<Map<String, dynamic>> _myGroups = [
    {
      "name": "Flutter Devs",
      "members": "12.4K",
      "icon": Icons.code,
      "color": Colors.cyan,
    },
    {
      "name": "Night Owls",
      "members": "8.9K",
      "icon": Icons.nights_stay,
      "color": Colors.deepPurple,
    },
    {
      "name": "Fitness Heroes",
      "members": "15.2K",
      "icon": Icons.fitness_center,
      "color": Colors.pink,
    },
  ];

  final List<Map<String, dynamic>> _trendingGroups = [
    {
      "name": "Crypto Kings",
      "members": "42.1K",
      "icon": Icons.trending_up,
      "color": Colors.amber,
    },
    {
      "name": "Code Queens",
      "members": "38.7K",
      "icon": Icons.palette,
      "color": Colors.orange,
    },
    {
      "name": "Anime Legends",
      "members": "29.5K",
      "icon": Icons.auto_awesome,
      "color": Colors.purple,
    },
    {
      "name": "Startup Founders",
      "members": "19.8K",
      "icon": Icons.rocket_launch,
      "color": Colors.teal,
    },
    {
      "name": "Mental Health Space",
      "members": "67.3K",
      "icon": Icons.favorite,
      "color": Colors.redAccent,
    },
  ];

  void _onNavTap(int index) {
    if (_selectedIndex == index) return; // Prevent rebuild if already on page
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const GroupsPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ChatsPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) {
      // AI
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MarketplacePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) {
      // More
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MorePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orbSize = size.width * 0.85;

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
            // Floating orbs — same as every screen
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
                        Color(0xFFA855F7).withOpacity(0.38),
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
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        _glowText("GROUPS", size.width * 0.09),
                        Spacer(),
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
                        horizontal: size.width * 0.06,
                      ),
                      children: [
                        const SizedBox(height: 10),

                        // My Groups Section
                        _sectionTitle("My Groups"),
                        SizedBox(height: 16),
                        ..._myGroups.map((group) => _groupCard(group, true)),

                        const SizedBox(height: 40),

                        // Discover Section
                        _sectionTitle("Discover Trending"),
                        SizedBox(height: 16),
                        ..._trendingGroups.map(
                          (group) => _groupCard(group, false),
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

      // 5-TAB NAVIGATION — ZERO TRANSITION
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

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _groupCard(Map<String, dynamic> group, bool isJoined) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
          BoxShadow(
            color: (group["color"] as Color).withOpacity(0.3),
            blurRadius: 40,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (group["color"] as Color).withOpacity(0.3),
              border: Border.all(color: group["color"], width: 2),
            ),
            child: Icon(group["icon"], color: Colors.white, size: 32),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group["name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "${group["members"]} members",
                  style: TextStyle(color: Colors.white60, fontSize: 15),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isJoined
                  ? Colors.white.withOpacity(0.2)
                  : Color(0xFFA855F7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: isJoined ? 0 : 12,
              shadowColor: isJoined ? Colors.transparent : Color(0xFFA855F7),
            ),
            onPressed: () {
              if (!isJoined) {
                setState(() => _myGroups.insert(0, group));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Joined ${group["name"]}!"),
                    backgroundColor: Colors.green.shade600,
                  ),
                );
              }
            },
            child: Text(
              isJoined ? "Joined" : "Join",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glowText(String text, double size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w900,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: [Color(0xFFE0AAFF), Colors.white, Color(0xFFA855F7)],
          ).createShader(Rect.fromLTWH(0, 0, 400, 100)),
        shadows: [
          Shadow(color: Color(0xFFA855F7).withOpacity(0.9), blurRadius: 30),
          Shadow(color: Colors.white.withOpacity(0.4), blurRadius: 60),
        ],
      ),
    );
  }
}
