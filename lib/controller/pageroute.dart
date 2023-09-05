import 'package:flutter/material.dart';

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        alignment: Alignment.bottomRight,
        scale: animation.drive(
          Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(
            CurveTween(
              curve: Curves.fastEaseInToSlowEaseOut,
            ),
          ),
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 1200),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
  );
}
