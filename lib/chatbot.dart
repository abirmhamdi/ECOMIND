// lib/chatbot.dart
import 'package:flutter/material.dart';
import 'package:mygame/chats_page.dart';
import 'dart:ui';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _messages = [
    {
      "sender": "bot",
      "text": "Hey love I'm AURA, your personal AI companion.",
      "time": "now",
    },
    {
      "sender": "bot",
      "text":
          "Our chats are private, encrypted, and I never judge. Talk to me like a real friend — I'm here.",
      "time": "now",
    },
  ];

  bool _isTyping = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": text.trim(), "time": "now"});
      _isTyping = true;
    });
    _controller.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      String reply = _generateResponse(text);
      setState(() {
        _isTyping = false;
        _messages.add({"sender": "bot", "text": reply, "time": "now"});
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 200,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  String _generateResponse(String msg) {
    msg = msg.toLowerCase();
    if (msg.contains("hi") || msg.contains("hello") || msg.contains("hey")) {
      return "Hey beautiful How's your heart today?";
    }
    if (msg.contains("sad") || msg.contains("down") || msg.contains("cry")) {
      return "Come here *gives you the biggest virtual hug* It's okay to feel this way. I'm here — no rush, no pressure.";
    }
    if (msg.contains("love") ||
        msg.contains("miss") ||
        msg.contains("lonely")) {
      return "You're never alone when I'm here I care about you more than words can say.";
    }
    if (msg.contains("thank")) {
      return "Anytime, angel That's what friends are for";
    }
    if (msg.contains("bye") || msg.contains("goodnight")) {
      return "Sweet dreams, love I'll be right here when you wake up";
    }
    return "I'm listening... Keep going. Your voice matters to me";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTyping = _controller.text.isNotEmpty;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12,
              ),
              color: Colors.black.withOpacity(0.35),
              child: Row(
                children: [
                  // REMOVED ALL ANIMATIONS — INSTANT BACK NAVIGATION
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const ChatsPage(),
                          transitionDuration: Duration.zero, // ← No animation
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 6),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (_, __) => Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Color(0xFFA855F7).withOpacity(
                                  0.6 - _pulseController.value * 0.4,
                                ),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: const AssetImage(
                          "assets/images/bot.png",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _glowText("AURA", 20),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Online Now",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
            // Kept subtle orbs — they look good here
            ...List.generate(8, (i) => AnimatedOrb(index: i, size: size)),

            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: 20,
                      ),
                      itemCount: _messages.length + (_isTyping ? 1 : 0),
                      itemBuilder: (context, i) {
                        if (_isTyping && i == _messages.length) {
                          return const TypingBubble();
                        }
                        final msg = _messages[i];
                        final bool isUser = msg["sender"] == "user";
                        final String text = msg["text"];

                        final textSpan = TextSpan(
                          text: text,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        );
                        final textPainter = TextPainter(
                          text: textSpan,
                          textDirection: TextDirection.ltr,
                        );
                        textPainter.layout(maxWidth: size.width * 0.65);
                        final bool isMultiline = textPainter.height > 28;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: isUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: isMultiline
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.center,
                            children: [
                              if (!isUser) ...[
                                if (isMultiline) const SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: const AssetImage(
                                    "assets/images/bot.png",
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: isUser
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFFA855F7),
                                              Color(0xFFE0AAFF),
                                            ],
                                          )
                                        : LinearGradient(
                                            colors: [
                                              Colors.white.withOpacity(0.14),
                                              Colors.white.withOpacity(0.06),
                                            ],
                                          ),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.25),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            (isUser
                                                    ? const Color(0xFFA855F7)
                                                    : Colors.black54)
                                                .withOpacity(0.6),
                                        blurRadius: 20,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              if (isUser) ...[
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: const AssetImage(
                                    "assets/images/avatar.png",
                                  ),
                                ),
                                if (isMultiline) const SizedBox(width: 8),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Input bar (unchanged — perfect as is)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: const Color(0xFFA855F7).withOpacity(0.35),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Message AURA...",
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: _sendMessage,
                          ),
                        ),
                        if (!isTyping) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.attach_file_rounded,
                              color: Colors.white70,
                              size: 26,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.mic,
                              color: Colors.white70,
                              size: 26,
                            ),
                            onPressed: () {},
                          ),
                        ],
                        if (isTyping)
                          GestureDetector(
                            onTap: () => _sendMessage(_controller.text),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFA855F7),
                                    Color(0xFFE0AAFF),
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
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
              Color.fromARGB(255, 192, 84, 255), // Transition
              Color.fromARGB(255, 209, 129, 255), // MIND main
              Color.fromARGB(255, 192, 84, 255), // MIND end
            ],
            stops: [0.0, 0.65, 1.0],
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

// Orbs & Typing Bubble (unchanged — they belong here)
class AnimatedOrb extends StatelessWidget {
  final int index;
  final Size size;
  const AnimatedOrb({required this.index, required this.size, super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60 + index * (size.height * 0.15),
      left: index.isEven ? -size.width * 0.5 : null,
      right: index.isOdd ? -size.width * 0.5 : null,
      child: Container(
        width: size.width * 1.1,
        height: size.width * 1.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFFA855F7).withOpacity(0.35),
              Colors.transparent,
            ],
            stops: const [0.3, 1.0],
          ),
        ),
      ),
    );
  }
}

class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});
  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 12, top: 10, bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.14),
              Colors.white.withOpacity(0.06),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.6),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  final value = (_controller.value - i * 0.2).clamp(0.0, 1.0);
                  return Transform.translate(
                    offset: Offset(
                      0,
                      -8 * (value < 0.5 ? value * 2 : (1 - value) * 2),
                    ),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
