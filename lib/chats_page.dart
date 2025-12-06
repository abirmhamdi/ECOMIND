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
      "name": "Youssef",
      "username": "youssef.trabelsi",
      "image": "assets/images/people/person1.jpg",
      "message": "Salut bro, ça va?",
      "time": "2m",
      "online": true,
    },
    {
      "name": "Sarra",
      "username": "sarra.benali",
      "image": "assets/images/people/person2.jpg",
      "message": "El design mte3ek 7low barcha!",
      "time": "15m",
      "online": false,
    },
    {
      "name": "Amine",
      "username": "amine.dev",
      "image": "assets/images/people/person3.jpg",
      "message": "B3athtlek el code tawa",
      "time": "1h",
      "online": true,
    },
    {
      "name": "Mariam",
      "username": "mariam.artt",
      "image": "assets/images/people/person4.jpg",
      "message": "Najmou ni5edmu projet ensemble?",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orbSize = size.width * 0.8;

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
            // SAME FLOATING ORBS AS HOMEPAGE
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
                  // HEADER — SAME AS HOMEPAGE
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

                        // CHAT ITEMS — USING EXACT SAME GLASS CONTAINER AS HOME POSTS
                        ..._chats.asMap().entries.map((entry) {
                          final chat = entry.value;
                          final isAura = chat["isAura"] == true;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: _glassChatCard(chat, size, isAura),
                          );
                        }),

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

      // SAME BOTTOM NAV AS HOMEPAGE
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

  // REUSING YOUR EXACT GLASS CONTAINER FROM HOMEPAGE
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

  // CHAT CARD — SAME STYLE AS HOME POSTS
  Widget _glassChatCard(Map<String, dynamic> chat, Size size, bool isAura) {
    return _glassCard(
      padding: EdgeInsets.all(size.width * 0.05),
      child: GestureDetector(
        onTap: isAura
            ? () => Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ChatbotPage(),
                  transitionDuration: Duration.zero,
                ),
              )
            : null,
        child: Row(
          children: [
            // Avatar + Online dot
            Stack(
              children: [
                CircleAvatar(
                  radius: size.width * 0.065,
                  backgroundImage: AssetImage(chat["image"]),
                ),
                if (chat["online"] == true && !isAura)
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 3),
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
                  const SizedBox(height: 6),
                  Text(
                    chat["message"],
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat["time"],
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
                if (isAura)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA855F7), Color(0xFFE0AAFF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "AI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // YOUR EXACT GLOW FROM HOMEPAGE
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
