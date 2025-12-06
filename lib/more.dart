// lib/more_page.dart
import 'package:flutter/material.dart';
import 'package:mygame/Groups.dart';
import 'package:mygame/chats_page.dart';
import 'package:mygame/marketplace.dart';
import 'dart:ui';
import 'home_page.dart';
import 'welcome.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int _selectedIndex = 4;

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
            // Background orbs
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
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        _glowText("MORE", size.width * 0.09),
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
                        _epicProfileCard(size),
                        SizedBox(height: size.height * 0.025),

                        Row(
                          children: [
                            _statCard(
                              "2,840",
                              "Points",
                              Icons.star,
                              Colors.amber,
                            ),
                            const SizedBox(width: 16),
                            _statCard(
                              "47",
                              "Friends",
                              Icons.favorite,
                              Colors.pinkAccent,
                            ),
                            const SizedBox(width: 16),
                            _statCard("12", "Shops", Icons.store, Colors.cyan),
                          ],
                        ),

                        SizedBox(height: size.height * 0.025),

                        _premiumMenuItem(
                          Icons.shield_outlined,
                          "Privacy & Safety",
                          () => _soon(),
                        ),
                        _premiumMenuItem(
                          Icons.notifications_outlined,
                          "Notifications",
                          () => _soon(),
                        ),
                        _premiumMenuItem(
                          Icons.palette_outlined,
                          "Appearance",
                          () => _soon(),
                        ),
                        _premiumMenuItem(
                          Icons.security,
                          "Account Security",
                          () => _soon(),
                        ),
                        _premiumMenuItem(
                          Icons.language,
                          "Language",
                          () => _soon(),
                        ),
                        _premiumMenuItem(
                          Icons.help_outline,
                          "Help Center",
                          () => _soon(),
                        ),
                        _premiumMenuItem(
                          Icons.info_outline,
                          "About ECOMIND",
                          () => _soon(),
                        ),

                        SizedBox(height: size.height * 0.025),

                        _premiumMenuItem(
                          Icons.logout,
                          "Log Out",
                          () => _showEpicLogoutDialog(context),
                          iconColor: Colors.redAccent,
                          glowColor: Colors.redAccent.withOpacity(0.8),
                        ),

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

  // ────────────────────────────── WIDGETS ──────────────────────────────

  Widget _epicProfileCard(Size size) {
    return _glassCard(
      padding: const EdgeInsets.all(28),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white70],
                  ),
                ),
                child: CircleAvatar(
                  radius: size.width * 0.13,
                  backgroundImage: const AssetImage("assets/images/avatar.png"),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4CAF50),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Diva",
                  style: TextStyle(
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "@VampyDiva • Level 16",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Elite Member",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white, size: 32),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: _glassCard(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _premiumMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color iconColor = Colors.white,
    Color? glowColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _glassCard(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.15),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54, size: 24),
          ],
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

  void _soon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Coming soon...",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFA855F7).withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  void _showEpicLogoutDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.75),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          titlePadding: const EdgeInsets.only(top: 24),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Goodbye, Diva!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.pinkAccent.withOpacity(0.7),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
          actionsPadding: const EdgeInsets.only(
            bottom: 16,
            right: 16,
            left: 16,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                "Stay",
                style: TextStyle(
                  color: Color.fromARGB(206, 255, 255, 255),
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 5,
              ),
              onPressed: () {
                // INSTANT LOGOUT — NO ANIMATION AT ALL
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const WelcomePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
