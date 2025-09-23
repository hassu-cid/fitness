import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/adaptive.dart';
import '../ui/transitions.dart';

class WorkoutPreferenceScreen extends StatefulWidget {
  static const routeName = '/workout-preference';
  const WorkoutPreferenceScreen({super.key});

  @override
  State<WorkoutPreferenceScreen> createState() =>
      _WorkoutPreferenceScreenState();
}

class _WorkoutPreferenceScreenState extends State<WorkoutPreferenceScreen> {
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 0.7, // progress example
                          minHeight: 4,
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => debugPrint('Skipped Workout Preference'),
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

              const SizedBox(height: 20),

              // Title
              Text(
                'What do you prefer?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: _responsiveFont(context, 28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choose your preferred workout type',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: _responsiveFont(context, 16),
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              // Options
              _optionCard(context, '🏠', 'Home Workout'),
              const SizedBox(height: 16),
              _optionCard(context, '🏋️‍♂️', 'Gym'),
              const SizedBox(height: 16),
              _optionCard(context, '🏃‍♂️', 'Outdoor'),

              const Spacer(),

              // NEXT Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ElevatedButton(
                  onPressed: selected.isEmpty
                      ? null
                      : () {
                    debugPrint("Selected Workout Preference: $selected");
                    // TODO: Navigate to next screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _optionCard(BuildContext context, String emoji, String title) {
    final isSelected = selected == title;

    return GestureDetector(
      onTap: () => setState(() => selected = title),
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 92,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.blue.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ]
                : null,
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
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
              if (isSelected)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: const Icon(Icons.check, color: Colors.blue, size: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
