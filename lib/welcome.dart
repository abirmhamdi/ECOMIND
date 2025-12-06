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

          // Floating orbs (background glow)
          ...List.generate(
            5,
            (i) => Positioned(
              top: 40 + i * (size.height * 0.19),
              left: i.isEven ? -size.width * 0.45 : null,
              right: i.isOdd ? -size.width * 0.45 : null,
              child: Container(
                width: size.width * 0.85,
                height: size.width * 0.85,
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

          // Main Content
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.18),

                // NEW: Circle image behind ECOMIND text
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Soft outer glow ring
                    Container(
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFA855F7).withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Your beautiful circle logo
                    Container(
                      width: size.width * 0.40,
                      height: size.width * 0.40,
                      child: Opacity(
                        opacity:
                            0.70, // ← change this number: 0.15 = very subtle, 0.4 = stronger
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/app-icon/ecomind-circle.png",
                              ),
                              fit: BoxFit.cover,
                              opacity:
                                  0.9, // extra softness inside the image itself
                            ),
                          ),
                        ),
                      ),
                      // Keep the big glow outside
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA855F7).withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),

                    // Glowing ECOMIND text on top
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.12),
                      child: _glowText("ECOMIND", size.width * 0.14),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.09),

                // Subtitle
                Text(
                  "Mindful Living.\nSustainable Future.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.8),
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

                // Bottom Buttons
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
                            decoration: const BoxDecoration(),
                            child: const Center(
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFA855F7),
                                  shadows: [
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
