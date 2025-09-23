import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weight_height_screen.dart'; // ✅ Import WeightHeightScreen

class AgeScreen extends StatefulWidget {
  static const String routeName = '/age';

  const AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final int minAge = 13;
  final int maxAge = 100;

  late FixedExtentScrollController _controller;
  late int _selectedAge;

  @override
  void initState() {
    super.initState();
    _selectedAge = 27;
    final initialIndex = _selectedAge - minAge;
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
                      value: 0.75,
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(8),
                      color: accentRed,
                      backgroundColor: const Color(0xFFE5E7EB),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, WeightHeightScreen.routeName);
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
                'How Old Are You ?',
                style: GoogleFonts.poppins(
                  color: textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Age Picker
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 220,
                  child: CupertinoPicker(
                    key: const ValueKey('age_picker'),
                    scrollController: _controller,
                    itemExtent: 44,
                    magnification: 1.15,
                    squeeze: 1.1,
                    useMagnifier: true,
                    selectionOverlay: const _SelectionOverlay(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedAge = minAge + index;
                      });
                    },
                    children: List.generate(
                      maxAge - minAge + 1,
                          (i) {
                        final age = minAge + i;
                        final isSelected = age == _selectedAge;
                        return Center(
                          child: Text(
                            '$age',
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
                    debugPrint("Selected Age: $_selectedAge");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WeightHeightScreen(),
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
