// lib/sign_up.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'page_transitions.dart';
import 'sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool termsAccepted = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const Color primaryPurple = Color(0xFFA855F7);
  static const Color accentPurple = Color(0xFFE0AAFF);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (!termsAccepted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text(
              "Account created successfully!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 3),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(slideUpWithPushDownRoute(const SignInPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double orbSize = size.width * 0.75;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,

      body: GestureDetector(
        onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
        child: Container(
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              // Floating purple orbs
              ...List.generate(
                5,
                (i) => Positioned(
                  top: 60 + i * (size.height * 0.18),
                  left: i.isEven ? -orbSize * 0.4 : null,
                  right: i.isOdd ? -orbSize * 0.4 : null,
                  child: Container(
                    width: orbSize,
                    height: orbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primaryPurple.withOpacity(0.32),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // MAIN GLASS CARD
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.06,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(45),
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 40,
                              offset: const Offset(0, -10),
                            ),
                            BoxShadow(
                              color: primaryPurple.withOpacity(0.25),
                              blurRadius: 60,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Title
                              _glowText(
                                "Create Your Account",
                                size.width * 0.1,
                              ),
                              SizedBox(height: size.height * 0.03),

                              // Full Name Field (Floating Label)
                              TextField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _floatingLabelInput("Full Name"),
                              ),
                              SizedBox(height: size.height * 0.02),

                              // Email Field
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.white),
                                decoration: _floatingLabelInput("Email"),
                              ),
                              SizedBox(height: size.height * 0.02),

                              // Password Field
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: _floatingLabelInput("Password"),
                              ),
                              SizedBox(height: size.height * 0.02),

                              // Terms & Conditions
                              Row(
                                children: [
                                  Checkbox(
                                    value: termsAccepted,
                                    activeColor: accentPurple,
                                    side: const BorderSide(
                                      color: Colors.white70,
                                    ),
                                    onChanged: (v) =>
                                        setState(() => termsAccepted = v!),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (_) => _termsDialog(),
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: size.width * 0.038,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: "I agree to the ",
                                            ),
                                            TextSpan(
                                              text: "Terms & Conditions",
                                              style: TextStyle(
                                                color: accentPurple,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),

                              // Create Account Button
                              SizedBox(
                                width: double.infinity,
                                height: size.height * 0.078,
                                child: ElevatedButton(
                                  onPressed: termsAccepted
                                      ? _createAccount
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      76,
                                      175,
                                      80,
                                    ),
                                    disabledBackgroundColor:
                                        const Color.fromARGB(185, 39, 98, 41),
                                    elevation: 20,
                                    shadowColor: primaryPurple.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),

                              Text(
                                "Or sign up with",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: size.width * 0.038,
                                ),
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _socialButton('assets/icons/google.png'),
                                  SizedBox(width: 20),
                                  _socialButton('assets/icons/facebook.png'),
                                  SizedBox(width: 20),
                                  _socialButton('assets/icons/apple.png'),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: size.width * 0.038,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Navigator.of(context).pushReplacement(
                                          slideUpWithPushDownRoute(
                                            const SignInPage(),
                                          ),
                                        ),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        color: accentPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width * 0.040,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // NEW: Floating Label Input
  InputDecoration _floatingLabelInput(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: focused ? accentPurple : Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      floatingLabelStyle: TextStyle(
        color: accentPurple,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: Colors.white.withOpacity(0.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: accentPurple, width: 2.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
    );
  }

  bool focused =
      false; // Track focus to change label color dynamically (optional enhancement)

  Widget _socialButton(String path) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.15),

        boxShadow: [
          BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 20),
        ],
      ),
      child: Image.asset(path, width: 40, height: 40),
    );
  }

  Widget _termsDialog() {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Terms & Conditions",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: const SingleChildScrollView(
        child: Text(
          "By creating an account you agree to protect our planet, respect all users, and help build a better future together.\n\nThank you for joining the movement!",
          style: TextStyle(color: Colors.white70),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close", style: TextStyle(color: accentPurple)),
        ),
      ],
    );
  }

  Widget _glowText(String text, double size) {
    final double displaySize = size * 0.85;

    return Stack(
      alignment: Alignment.center,
      children: [
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
              fontSize: displaySize, // smaller, cleaner text
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
