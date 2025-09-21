import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/adaptive.dart';
import '../ui/transitions.dart';
import 'age_screen.dart';

class Onboarding2Screen extends StatefulWidget {
  static const routeName = '/onboarding2';
  const Onboarding2Screen({super.key});

  @override
  State<Onboarding2Screen> createState() => _Onboarding2ScreenState();
}

class _Onboarding2ScreenState extends State<Onboarding2Screen> {
  String selected = '';

  double _responsiveFont(BuildContext context, double base) {
    final scale = MediaQuery.of(context).textScaleFactor;
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return base * 1.8 * scale;
    if (width > 600) return base * 1.4 * scale;
    return base * scale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CenteredBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress + Skip
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red,
                        backgroundColor: const Color(0xFFE5E7EB),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(slideFadeRoute(const AgeScreen())),
                      child: Text(
                        'Skip',
                        style: GoogleFonts.roboto(
                          fontSize: _responsiveFont(context, 16),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              Text(
                'What are your main Goals ?',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: _responsiveFont(context, 32),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Pick one to personalize the plan',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: _responsiveFont(context, 17),
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 100),

              // ✅ Goal Options with updated emojis
              _goalCard(context, '🔥', 'Lose Weight'),      // Fire emoji for Lose Weight
              const SizedBox(height: 12),
              _goalCard(context, '🏋️', 'Build Muscle'),    // Weightlifting emoji for Build Muscle
              const SizedBox(height: 12),
              _goalCard(context, '💪', 'Keep Fit'),         // Biceps emoji for Keep Fit


              const Spacer(),

              // NEXT Button (red)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: selected.isEmpty ? 0.5 : 1,
                  child: ElevatedButton(
                    onPressed: selected.isEmpty
                        ? null
                        : () => Navigator.of(context).push(slideFadeRoute(const AgeScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _goalCard(BuildContext context, String emoji, String title) {
    final isSel = selected == title;

    return GestureDetector(
      onTap: () => setState(() => selected = title),
      child: AnimatedScale(
        scale: isSel ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 92,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSel ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              // Animated Emoji
              AnimatedScale(
                scale: isSel ? 1.3 : 1.0, // emoji grows slightly when selected
                duration: const Duration(milliseconds: 200),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(width: 12),
              // Title
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Check Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSel ? 32 : 0,
                height: isSel ? 32 : 0,
                child: isSel
                    ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: const Icon(Icons.check, color: Colors.blue, size: 20),
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
