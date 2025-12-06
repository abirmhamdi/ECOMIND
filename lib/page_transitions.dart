// lib/utils/page_transitions.dart   (أو lib/page_transitions.dart)
import 'package:flutter/material.dart';

Route slideUpWithPushDownRoute(Widget page) {
  return PageRouteBuilder(
    opaque: false, // هذا السطر هو المفتاح السحري!
    transitionDuration: const Duration(milliseconds: 550),
    reverseTransitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slideIn = Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      final slideOut =
          Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, 0.8),
          ).animate(
            CurvedAnimation(
              parent: secondaryAnimation,
              curve: Curves.easeInCubic,
            ),
          );

      return SlideTransition(
        position: slideIn,
        child: SlideTransition(position: slideOut, child: child),
      );
    },
  );
}
