import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/adaptive.dart';
import '../ui/transitions.dart';
import 'workout_preference_screen.dart';

class WeeklyGoalScreen extends StatefulWidget {
  static const routeName = '/weekly-goal';
  const WeeklyGoalScreen({super.key});

  @override
  State<WeeklyGoalScreen> createState() => _WeeklyGoalScreenState();
}

class _WeeklyGoalScreenState extends State<WeeklyGoalScreen> {
  int selectedDays = 0;
  String firstDay = "SUNDAY";

  final List<String> daysOfWeek = [
    "SUNDAY",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY"
  ];

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
                          value: 0.5, // example progress
                          minHeight: 4,
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => debugPrint('Skipped Weekly Goal Screen'),
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
                'Set your weekly goal',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: _responsiveFont(context, 28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We recommend training at least 3 days weekly for a better result.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: _responsiveFont(context, 16),
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              // Training days heading (emoji + text) — explicit color set
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text('🎯', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(
                      'Weekly training days',
                      style: GoogleFonts.roboto(
                        fontSize: _responsiveFont(context, 16),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Days selection boxes (1..7)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: List.generate(7, (index) {
                  int day = index + 1;
                  bool isSelected = selectedDays == day;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDays = day;
                      });
                    },
                    child: Container(
                      width: 72,
                      height: 72,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey.shade300,
                          width: 1.5,
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
                      child: Text(
                        "$day",
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // First day of week heading (emoji + text)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text('📅', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'First day of week',
                      style: GoogleFonts.roboto(
                        fontSize: _responsiveFont(context, 16),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: firstDay,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  items: daysOfWeek.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(
                        day,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      firstDay = value!;
                    });
                  },
                ),
              ),

              const Spacer(),

              // NEXT Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ElevatedButton(
                  onPressed: selectedDays == 0
                      ? null
                      : () {
                    debugPrint(
                        "Selected Days: $selectedDays, First day: $firstDay");
                    Navigator.pushNamed(
                        context,
                        WorkoutPreferenceScreen.routeName,
                    );
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
}
