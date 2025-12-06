// lib/forgot_password_page.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'page_transitions.dart';
import 'sign_in.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static const Color primaryPurple = Color(0xFFA855F7);
  static const Color accentPurple = Color(0xFFE0AAFF);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double orbSize = size.width * 0.75;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,

      // Tap outside → back to Welcome
      body: GestureDetector(
        onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
        child: Container(
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              // Floating purple orbs — responsive
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

              // MAIN GLASS CARD — flawless
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {}, // Stop propagation
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
                              _glowText("Reset Password", size.width * 0.1),
                              SizedBox(height: size.height * 0.02),

                              // Subtitle
                              Text(
                                "Enter your email and we'll send you a link to reset your password securely.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.width * 0.038,
                                  color: Colors.white70,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),

                              // Email Field — Floating Label
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.white),
                                decoration: _floatingLabelInput("Email"),
                              ),
                              SizedBox(height: size.height * 0.02),

                              // New Password Field — Floating Label
                              TextField(
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: _floatingLabelInput("New Password"),
                              ),
                              SizedBox(height: size.height * 0.04),

                              // Reset Button
                              SizedBox(
                                width: double.infinity,
                                height: size.height * 0.078,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              "Password reset link sent!",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.green.shade600,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        duration: const Duration(seconds: 3),
                                      ),
                                    );

                                    Future.delayed(
                                      const Duration(milliseconds: 1200),
                                      () {
                                        if (!context.mounted) return;
                                        Navigator.of(context).pushReplacement(
                                          slideUpWithPushDownRoute(
                                            const SignInPage(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      76,
                                      175,
                                      80,
                                    ),
                                    elevation: 20,
                                    shadowColor: primaryPurple.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "Send Reset Link",
                                    style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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

  // Reusable Floating Label Input — identical to Sign In / Sign Up
  InputDecoration _floatingLabelInput(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      floatingLabelStyle: const TextStyle(
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
