// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:mygame/Groups.dart';
import 'package:mygame/chats_page.dart';
import 'package:mygame/marketplace.dart';

import 'dart:ui';
import 'package:mygame/more.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();
  int _selectedIndex = 0;
  final Set<int> _likedPosts = {};
  final List<Map<String, dynamic>> _posts = [
    {
      "name": "Sarah Ahmed",
      "time": "2 hours ago",
      "content": "Today was a beautiful day full of positivity and energy!",
    },
    {
      "name": "Leen Mohammed",
      "time": "5 hours ago",
      "content":
          "I love coffee in the morning... the perfect start to the day!",
    },
  ];

  void _createPost() {
    if (_postController.text.trim().isEmpty) return;
    setState(() {
      _posts.insert(0, {
        "name": "Abeer",
        "time": "Just now",
        "content": _postController.text.trim(),
      });
      _postController.clear();
    });
  }

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
    final double orbSize = size.width * 0.8;

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
            // Floating purple orbs — cinematic background
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
                  // Premium Glass AppBar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        _glowText("ECOMIND", size.width * 0.09),
                        const Spacer(),

                        // Notification Bell (simple & elegant)
                        IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                            color: Colors.white70,
                            size: size.width * 0.075,
                          ),
                          onPressed: () {
                            // Optional: show snackbar or navigate later
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Notifications"),
                                backgroundColor: Color(0xFFA855F7),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),

                        // Search Icon (unchanged, just moved right)
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

                        // Create Post Card
                        _glassCard(
                          padding: EdgeInsets.all(size.width * 0.05),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: size.width * 0.07,
                                    backgroundImage: const AssetImage(
                                      "assets/images/avatar.png",
                                    ),
                                    backgroundColor: Colors.white.withOpacity(
                                      0.2,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.04),
                                  Expanded(
                                    child: TextField(
                                      controller: _postController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "What's on your mind?",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                          fontSize: size.width * 0.045,
                                        ),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(
                                          0.1,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: size.height * 0.02,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white54,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _glassActionButton(
                                    Icons.photo_library_outlined,
                                    "Photo",
                                    Colors.purpleAccent,
                                  ),
                                  _glassActionButton(
                                    Icons.gif_box_outlined,
                                    "GIF",
                                    Colors.cyanAccent,
                                  ),
                                  _glassActionButton(
                                    Icons.mood,
                                    "Feeling",
                                    Colors.pinkAccent,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),

                              ElevatedButton(
                                onPressed: _createPost,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFA855F7),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02,
                                    horizontal: size.width * 0.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 15,
                                  shadowColor: const Color(
                                    0xFFA855F7,
                                  ).withOpacity(0.7),
                                ),
                                child: Text(
                                  "Post",
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.025),

                        // Posts Feed
                        ..._posts.asMap().entries.map((entry) {
                          int index = entry.key;
                          var post = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.02,
                            ),
                            child: _glassPostCard(post, size, index),
                          );
                        }),
                        SizedBox(height: size.height * 0.15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // FINAL 5-TAB PREMIUM GLASS BOTTOM NAVIGATION BAR
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

  // Glass Card
  Widget _glassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: padding ?? const EdgeInsets.all(20),
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
      child: child,
    );
  }

  // Action Buttons (Photo/GIF/Feeling)
  Widget _glassActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withOpacity(0.6)),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.4), blurRadius: 20),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: MediaQuery.of(context).size.width * 0.035,
          ),
        ),
      ],
    );
  }

  // Post Card
  Widget _glassPostCard(Map<String, dynamic> post, Size size, int index) {
    return _glassCard(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: size.width * 0.065,
                backgroundImage: const AssetImage("assets/images/avatar.png"),
              ),
              SizedBox(width: size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post["name"],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  Text(
                    post["time"],
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.more_horiz,
                color: Colors.white60,
                size: size.width * 0.07,
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            post["content"],
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.044,
              height: 1.6,
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionBtn("Like", Icons.thumb_up_off_alt, index),
              _actionBtn("Comment", Icons.comment, -1), // ← pass dummy index
              _actionBtn("Share", Icons.share, -1), // ← pass dummy index
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(String label, IconData icon, [int postIndex = -1]) {
    final bool isLiked = postIndex != -1 && _likedPosts.contains(postIndex);

    // Force the label to always be "Liked" length (6 characters) by using invisible text
    return TextButton.icon(
      onPressed: postIndex != -1
          ? () {
              setState(() {
                if (isLiked) {
                  _likedPosts.remove(postIndex);
                } else {
                  _likedPosts.add(postIndex);
                }
              });
            }
          : null,
      icon: Icon(
        isLiked ? Icons.thumb_up : icon,
        color: isLiked ? const Color(0xFFA855F7) : Colors.white70,
        size: MediaQuery.of(context).size.width * 0.055,
      ),
      label: Stack(
        children: [
          // Invisible "Liked" text to reserve exact space
          Opacity(
            opacity: 0,
            child: Text(
              "Liked", // longest text
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.038,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Actual visible text on top
          Text(
            isLiked ? "Liked" : label,
            style: TextStyle(
              color: isLiked ? const Color(0xFFA855F7) : Colors.white70,
              fontWeight: isLiked ? FontWeight.bold : FontWeight.normal,
              fontSize: MediaQuery.of(context).size.width * 0.038,
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
