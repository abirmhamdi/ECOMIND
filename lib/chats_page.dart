// lib/pages/chats_page.dart
import 'package:flutter/material.dart';
import 'package:mygame/Groups.dart';
import 'dart:ui';
import '../chatbot.dart';
import 'home_page.dart';
import 'marketplace.dart';
import 'more.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  int _selectedIndex = 2;

  final List<Map<String, dynamic>> _chats = [
    {
      "name": "AURA",
      "username": "Your emotional AI companion",
      "image": "assets/images/bot.png",
      "message": "I'm listening... Keep going. Your voice matters to me",
      "time": "now",
      "online": true,
      "isAura": true,
    },
    {
      "name": "Alex",
      "username": "alex.jpg",
      "image": "https://randomuser.me/api/portraits/men/32.jpg",
      "message": "Yo what's up?",
      "time": "2m",
      "online": true,
    },
    {
      "name": "Emma",
      "username": "emma.design",
      "image": "https://randomuser.me/api/portraits/women/44.jpg",
      "message": "That color palette is fire!",
      "time": "15m",
      "online": false,
    },
    {
      "name": "David",
      "username": "david.dev",
      "image": "https://randomuser.me/api/portraits/men/86.jpg",
      "message": "Sent you the code",
      "time": "1h",
      "online": true,
    },
    {
      "name": "Sophia",
      "username": "sophia.art",
      "image": "https://randomuser.me/api/portraits/women/65.jpg",
      "message": "Let's collab soon!",
      "time": "3h",
      "online": false,
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
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        child: SafeArea(
          child: Column(
            children: [
              // TOP BAR
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    _glowText("MESSAGES", size.width * 0.09),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.add_rounded,
                        color: Colors.white70,
                        size: size.width * 0.075,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // CHAT LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _chats.length,
                  itemBuilder: (context, i) {
                    final chat = _chats[i];
                    final isAura = chat["isAura"] == true;

                    return GestureDetector(
                      onTap: () {
                        if (!isAura) return;

                        // INSTANT NAVIGATION — NO ANIMATION
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const ChatbotPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(isAura ? 0.18 : 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: isAura
                              ? Border.all(
                                  color: const Color(0xFFA855F7),
                                  width: 2,
                                )
                              : null,
                          boxShadow: isAura
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFA855F7,
                                    ).withOpacity(0.5),
                                    blurRadius: 20,
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundImage:
                                      chat["image"].toString().startsWith(
                                        "assets",
                                      )
                                      ? AssetImage(chat["image"])
                                            as ImageProvider
                                      : NetworkImage(chat["image"]),
                                ),
                                if (chat["online"] == true)
                                  Positioned(
                                    right: 4,
                                    bottom: 4,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chat["name"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    chat["message"],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  chat["time"],
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 13,
                                  ),
                                ),
                                if (isAura)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFA855F7),
                                            Color(0xFFE0AAFF),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        "AI",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION
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

  Widget _glowText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFFE0AAFF), Color(0xFFA855F7)],
          ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
        shadows: [
          Shadow(color: const Color(0xFFA855F7).withOpacity(1), blurRadius: 35),
          Shadow(color: Colors.white.withOpacity(0.6), blurRadius: 70),
        ],
      ),
    );
  }
}
