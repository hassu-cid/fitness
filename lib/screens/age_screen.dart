import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgeScreen extends StatefulWidget {
  static const routeName = '/age'; // ✅ Added routeName for navigation

  const AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  // ✅ Configurable age range
  final int minAge = 13;
  final int maxAge = 100;

  late FixedExtentScrollController _controller;
  late int _selectedAge;

  @override
  void initState() {
    super.initState();
    _selectedAge = 27; // ✅ Default age
    final initialIndex = _selectedAge - minAge;
    _controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ✅ App-wide color theme
  Color get bg => Colors.white;
  Color get textPrimary => Colors.black;
  Color get accentRed => Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top bar with back + step text + skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: SizedBox(
                height: 44,
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 36,
                      onPressed: () => Navigator.of(context).maybePop(),
                      child: Icon(CupertinoIcons.back, color: textPrimary),
                    ),
                    const SizedBox(width: 4),

                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minSize: 32,
                      onPressed: () {
                        // ✅ Handle Skip navigation here
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: textPrimary.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 Title
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'HOW OLD ARE YOU?',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
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
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.red // ✅ Highlighted red
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

            // 🔹 Bottom Primary Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: accentRed,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    // ✅ Use _selectedAge here
                    debugPrint("Selected Age: $_selectedAge");
                    // Example: Navigator.pushNamed(context, NextScreen.routeName);
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Custom selection overlay with subtle highlight
class _SelectionOverlay extends StatelessWidget {
  const _SelectionOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 90),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red, width: 1.5), // ✅ Red outline
        ),
      ),
    );
  }
}