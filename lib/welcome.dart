// lib/welcome.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'page_transitions.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/bg4.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double orbSize = size.width * 0.85;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Video Background
          Positioned.fill(
            child: _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(color: const Color(0xFF1A0B2E)),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black87,
                    Colors.black,
                  ],
                  stops: [0.0, 0.4, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // Floating orbs
          ...List.generate(
            5,
            (i) => Positioned(
              top: 40 + i * (size.height * 0.19),
              left: i.isEven ? -orbSize * 0.45 : null,
              right: i.isOdd ? -orbSize * 0.45 : null,
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

          // Main Content — EXACTLY LIKE YOUR SCREENSHOT
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.18),

                // Logo Circle + Text
                Container(
                  padding: EdgeInsets.all(size.width * 0.12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFA855F7), Color(0xFFE0AAFF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFA855F7).withOpacity(0.9),
                        blurRadius: 90,
                        spreadRadius: 35,
                      ),
                    ],
                  ),
                  child: glowText("ECOMIND", size.width * 0.125),
                ),

                SizedBox(height: size.height * 0.14),

                // Subtitle
                Text(
                  "Your world. Your rhythm.\nYour comfort zone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.052,
                    color: Colors.white.withOpacity(0.95),
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: const Color(0xFFA855F7).withOpacity(0.5),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Bottom Buttons — IDENTICAL TO YOUR DESIGN
                Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(
                            context,
                          ).push(slideUpWithPushDownRoute(const SignInPage())),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(
                            context,
                          ).push(slideUpWithPushDownRoute(const SignUpPage())),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFA855F7),
                                  shadows: const [
                                    Shadow(
                                      color: Colors.white70,
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget glowText(String text, double fontSize) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFFE0AAFF), Colors.white, Color(0xFFA855F7)],
          ).createShader(const Rect.fromLTWH(0, 0, 400, 100)),
        shadows: [
          Shadow(
            color: const Color(0xFFA855F7).withOpacity(0.9),
            blurRadius: fontSize * 1.1,
          ),
          Shadow(
            color: Colors.white.withOpacity(0.6),
            blurRadius: fontSize * 1.8,
          ),
        ],
      ),
    );
  }
}
