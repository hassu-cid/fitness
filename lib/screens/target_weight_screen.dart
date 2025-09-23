import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'experience_level_screen.dart'; // ✅ Import the next screen

class TargetWeightScreen extends StatefulWidget {
  static const String routeName = '/target-weight';

  const TargetWeightScreen({Key? key}) : super(key: key);

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  final double minWeight = 30.0;
  final double maxWeight = 200.0;

  late FixedExtentScrollController _controller;
  late double _selectedWeight;

  @override
  void initState() {
    super.initState();
    _selectedWeight = 75.0; // default starting weight in kg
    final initialIndex = (_selectedWeight - minWeight).round();
    _controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get bg => Colors.white;
  Color get textPrimary => Colors.black;
  Color get accentRed => Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Progress bar + Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.85,
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(8),
                      color: accentRed,
                      backgroundColor: const Color(0xFFE5E7EB),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      // Skip button goes to next screen
                      Navigator.pushReplacementNamed(
                          context, ExperienceLevelScreen.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'What is Your Target Weight?',
                style: GoogleFonts.poppins(
                  color: textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Weight Picker
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 220,
                  child: CupertinoPicker(
                    key: const ValueKey('weight_picker'),
                    scrollController: _controller,
                    itemExtent: 44,
                    magnification: 1.15,
                    squeeze: 1.1,
                    useMagnifier: true,
                    selectionOverlay: const _SelectionOverlay(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedWeight = minWeight + index;
                      });
                    },
                    children: List.generate(
                      (maxWeight - minWeight + 1).round(),
                          (i) {
                        final weight = minWeight + i;
                        final isSelected = weight == _selectedWeight;
                        return Center(
                          child: Text(
                            '${weight.toStringAsFixed(0)} kg',
                            style: GoogleFonts.roboto(
                              color: isSelected
                                  ? Colors.black
                                  : textPrimary.withOpacity(0.5),
                              fontSize: isSelected ? 22 : 18,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // 🔹 NEXT Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Selected Target Weight: $_selectedWeight kg");
                    // ✅ Navigate to ExperienceLevelScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ExperienceLevelScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

// 🔹 Selection Overlay for picker
class _SelectionOverlay extends StatelessWidget {
  const _SelectionOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 90),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
