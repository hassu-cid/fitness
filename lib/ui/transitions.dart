import 'package:flutter/material.dart';

Route<T> slideFadeRoute<T>(Widget page, {AxisDirection dir = AxisDirection.left, Duration duration = const Duration(milliseconds: 380)}) {
  final beginOffset = switch (dir) {
    AxisDirection.left => const Offset(1, 0),
    AxisDirection.right => const Offset(-1, 0),
    AxisDirection.up => const Offset(0, 1),
    AxisDirection.down => const Offset(0, -1),
  };
  return PageRouteBuilder<T>(
    transitionDuration: duration,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) {
      final curve = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween(begin: beginOffset, end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic)).animate(anim),
          child: child,
        ),
      );
    },
  );
}
