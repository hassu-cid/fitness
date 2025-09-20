import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String fullText = "FYT LYF";
  late final List<bool> _visible;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _visible = List<bool>.filled(fullText.length, false);

    // Reveal one letter at a time
    const letterDelay = Duration(milliseconds: 220);
    _timer = Timer.periodic(letterDelay, (timer) {
      if (_currentIndex < fullText.length) {
        setState(() {
          _visible[_currentIndex] = true;
          _currentIndex++;
        });
      } else {
        _timer?.cancel();
        Future.delayed(const Duration(milliseconds: 900), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.09;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              "assets/images/splash.png",
              width: size.width * 0.6,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 8),

            // Prevents overflow
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(fullText.length, (index) {
                  final ch = fullText[index];
                  if (ch == ' ') {
                    return SizedBox(width: fontSize * 0.35);
                  }
                  return _AnimatedLetter(
                    key: ValueKey('letter_$index'),
                    letter: ch,
                    visible: _visible[index],
                    fontSize: fontSize,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedLetter extends StatelessWidget {
  final String letter;
  final bool visible;
  final double fontSize;

  const _AnimatedLetter({
    super.key,
    required this.letter,
    required this.visible,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: visible ? 1.0 : 0.0,
      ),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        // Clamp to avoid invalid opacity
        final double opacity = value.clamp(0.0, 1.0);
        final double scale = 0.55 + 0.45 * opacity;
        final double blur = 18.0 * opacity;
        final Color glowColor = Colors.redAccent.withOpacity(0.9 * opacity);

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Text(
              letter,
              style: GoogleFonts.pottaOne(
                fontSize: fontSize,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: blur,
                    color: glowColor,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}