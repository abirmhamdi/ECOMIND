// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:mygame/Groups.dart';
import 'package:mygame/chats_page.dart';
import 'package:mygame/marketplace.dart';
import 'dart:ui';
import 'more.dart';

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
      "name": "Youssef",
      "username": "youssef.trabelsi",
      "image": "assets/images/people/person1.jpg",
      "content": "Nettoyage de plage à Hammamet! 15kg de plastique ramassés.",
      "time": "1 hour ago",
      "photo": "assets/images/posts/post1.jpg",
    },
    {
      "name": "Sarra",
      "username": "sarra.benali",
      "image": "assets/images/people/person2.jpg",
      "content":
          "New collection made from recycled clothes! Upcycling is the future, w zid fih el style tunisien",
      "time": "3 hours ago",
    },
    {
      "name": "Amine",
      "username": "amine.dev",
      "image": "assets/images/people/person3.jpg",
      "content":
          "Récemment installé des panneaux solaires wa7adkom! Facture d’électricité = 0 cette fois, w n7ebbou our planet",
      "time": "5 hours ago",
    },
    {
      "name": "Mariam",
      "username": "mariam.artt",
      "image": "assets/images/people/person4.jpg",
      "content":
          "Souk day mais zero-waste! My tote bag w 9ahewti fi kess réutilisable. No plastic, just vibes",
      "time": "7 hours ago",
      "photo": "assets/images/posts/post2.jpg",
    },
    {
      "name": "Eco Tunisia",
      "username": "ecotunisia",
      "image": "assets/images/groups/eco-tunisia.jpg",
      "content":
          "Tounes 9adra tna9ess 60% men el plastique ken kolna nbaddlou lel sacs réutilisables. Let’s do it, ya tounes!",
      "time": "12 hours ago",
    },
  ];

  void _createPost() {
    if (_postController.text.trim().isEmpty) return;
    setState(() {
      _posts.insert(0, {
        "name": "You",
        "username": "you",
        "image": "assets/images/avatar.png",
        "content": _postController.text.trim(),
        "time": "Just now",
      });
      _postController.clear();
    });
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
    final double orbSize = size.width * 0.8;

    const Color ecoGreen = Color(0xFF4CAF50);
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
                        purpleMain.withOpacity(0.35),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        _glowText("ECOMIND", size.width * 0.09),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.notifications_none,
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
                                  ),
                                  SizedBox(width: size.width * 0.04),
                                  Expanded(
                                    child: TextField(
                                      controller: _postController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Share your eco moment...",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                          fontSize: size.width * 0.045,
                                        ),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(
                                          0.1,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
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
                                          borderSide: const BorderSide(
                                            color: ecoGreen,
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
                                    ecoGreen,
                                  ),
                                  _glassActionButton(
                                    Icons.gif_box_outlined,
                                    "GIF",
                                    Colors.cyanAccent,
                                  ),
                                  _glassActionButton(
                                    Icons.eco,
                                    "Eco Tip",
                                    ecoGreen,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              ElevatedButton(
                                onPressed: _createPost,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    76,
                                    175,
                                    80,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02,
                                    horizontal: size.width * 0.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 15,
                                  shadowColor: ecoGreen.withOpacity(0.7),
                                ),
                                child: const Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.025),

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

  Widget _glassPostCard(Map<String, dynamic> post, Size size, int index) {
    final bool hasPhoto = post["photo"] != null;
    final String profileImage = post["image"] ?? "assets/images/avatar.png";

    return _glassCard(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: size.width * 0.065,
                backgroundImage: AssetImage(profileImage),
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

          if (hasPhoto) ...[
            SizedBox(height: size.height * 0.02),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                post["photo"],
                width: double.infinity,
                height: size.height * 0.35,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: size.height * 0.35,
                  color: Colors.white.withOpacity(0.1),
                  child: const Icon(Icons.eco, color: Colors.white54, size: 50),
                ),
              ),
            ),
          ],

          SizedBox(height: size.height * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionBtn("Like", Icons.thumb_up_off_alt, size, index),
              _actionBtn("Comment", Icons.comment, size),
              _actionBtn("Share", Icons.share, size),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(
    String label,
    IconData icon,
    Size size, [
    int postIndex = -1,
  ]) {
    final bool isLiked = postIndex != -1 && _likedPosts.contains(postIndex);
    const Color ecoGreen = Color(0xFF4CAF50);

    return TextButton.icon(
      onPressed: postIndex != -1
          ? () => setState(
              () => isLiked
                  ? _likedPosts.remove(postIndex)
                  : _likedPosts.add(postIndex),
            )
          : null,
      icon: Icon(
        isLiked ? Icons.thumb_up : icon,
        color: isLiked ? ecoGreen : Colors.white70,
        size: size.width * 0.055,
      ),
      label: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: Text(
              "Liked",
              style: TextStyle(
                fontSize: size.width * 0.038,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            isLiked ? "Liked" : label,
            style: TextStyle(
              color: isLiked
                  ? const Color.fromARGB(255, 76, 175, 80)
                  : Colors.white, // Share & Comment always white
              fontWeight: isLiked ? FontWeight.bold : FontWeight.normal,
              fontSize: size.width * 0.038,
            ),
          ),
        ],
      ),
    );
  }

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
