import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/adaptive.dart';
import '../ui/transitions.dart';
import 'age_screen.dart';
import '../widgets/PrimaryButton.dart';

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
              const SizedBox(height: 60),
              Text(
                'What are your main Goals?',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: _responsiveFont(context, 28),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Pick one to personalize your plan',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: _responsiveFont(context, 17),
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 60),

              // Goal Cards
              _goalCard(context, '🔥', 'Lose Weight'),
              const SizedBox(height: 12),
              _goalCard(context, '🏋️', 'Build Muscle'),
              const SizedBox(height: 12),
              _goalCard(context, '💪', 'Keep Fit'),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryButton(
                  label: 'NEXT',
                  onPressed: selected.isEmpty
                      ? null
                      : () => Navigator.of(context).push(slideFadeRoute(const AgeScreen())),
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
            border: Border.all(color: isSel ? Colors.red : Colors.transparent, width: 2),
          ),
          child: Row(
            children: [
              AnimatedScale(
                scale: isSel ? 1.3 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(width: 12),
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSel ? 32 : 0,
                height: isSel ? 32 : 0,
                child: isSel
                    ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: const Icon(Icons.check, color: Colors.red, size: 20),
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
