import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding2_screen.dart'; // for direct push with animation

class Onboarding1Screen extends StatefulWidget {
  static const routeName = '/onboarding1';

  const Onboarding1Screen({super.key});

  @override
  State<Onboarding1Screen> createState() => _Onboarding1ScreenState();
}

class _Onboarding1ScreenState extends State<Onboarding1Screen> {
  String? selectedGender;

  double _responsiveFont(BuildContext context, double base) {
    final scale = MediaQuery.of(context).textScaleFactor;
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return base * 1.8 * scale; // tablets / foldables
    if (width > 600) return base * 1.4 * scale; // medium screens
    return base * scale; // phones
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress + Skip
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.25,
                          minHeight: isTablet ? 6 : 4,
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          // Optional: jump to goals (onboarding2)
                          Navigator.of(context).push(_slideFade(const Onboarding2Screen()));
                          // Or named route:
                          // Navigator.pushNamed(context, '/onboarding2');
                        },
                        child: Text(
                          'Skip',
                          style: GoogleFonts.roboto(fontSize: _responsiveFont(context, 20), color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  "What's your gender ?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(fontSize: _responsiveFont(context, 30), color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                const Spacer(),

                // Gender options
                SizedBox(
                  height: size.height * (isTablet ? 0.5 : 0.45),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Male
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        left: selectedGender == 'Female'
                            ? size.width * 0.05
                            : (selectedGender == 'Male' ? size.width * 0.25 : size.width * 0.15),
                        top: selectedGender == 'Male' ? 0 : size.height * 0.05,
                        child: _buildGenderOption(
                          gender: 'Male',
                          image: 'assets/images/male.png',
                          isSelected: selectedGender == 'Male',
                          highlightColor: Colors.lightBlue,
                          onTap: () => setState(() => selectedGender = 'Male'),
                          size: size,
                          hasSelection: selectedGender != null,
                          context: context,
                        ),
                      ),

                      // Female
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        right: selectedGender == 'Male'
                            ? size.width * 0.05
                            : (selectedGender == 'Female' ? size.width * 0.25 : size.width * 0.15),
                        top: selectedGender == 'Female' ? 0 : size.height * 0.05,
                        child: _buildGenderOption(
                          gender: 'Female',
                          image: 'assets/images/female.png',
                          isSelected: selectedGender == 'Female',
                          highlightColor: Colors.pinkAccent,
                          onTap: () => setState(() => selectedGender = 'Female'),
                          size: size,
                          hasSelection: selectedGender != null,
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Next button
                Padding(
                  padding: EdgeInsets.all(isTablet ? 40 : 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: isTablet ? 70 : 55,
                    child: ElevatedButton(
                      onPressed: selectedGender == null
                          ? null
                          : () {
                        // With custom slide+fade transition:
                        Navigator.of(context).push(_slideFade(const Onboarding2Screen()));
                        // If you want to pass the gender later, you can use named routes with arguments:
                        // Navigator.pushNamed(context, '/onboarding2', arguments: {'gender': selectedGender});
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.grey[300],
                      ).copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                              (states) => states.contains(MaterialState.disabled) ? Colors.grey[300] : null,
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: selectedGender == null
                              ? null
                              : const LinearGradient(
                            colors: [Colors.red, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'NEXT',
                            style: GoogleFonts.roboto(fontSize: _responsiveFont(context, 20), fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGenderOption({
    required String gender,
    required String image,
    required bool isSelected,
    required bool hasSelection,
    required Color highlightColor,
    required VoidCallback onTap,
    required Size size,
    required BuildContext context,
  }) {
    final isTablet = size.width > 600;

    final containerHeight = isSelected ? size.height * (isTablet ? 0.42 : 0.38) : size.height * (isTablet ? 0.32 : 0.28);
    final containerWidth = isSelected ? size.width * (isTablet ? 0.28 : 0.35) : size.width * (isTablet ? 0.22 : 0.25);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Hero(
            tag: 'gender_$gender', // safer unique tag
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              height: containerHeight,
              width: containerWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isSelected)
                    Container(
                      height: containerHeight,
                      width: containerWidth,
                      decoration: BoxDecoration(color: highlightColor, borderRadius: BorderRadius.circular(20)),
                    ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: !hasSelection ? 1.0 : (isSelected ? 1.0 : 0.5),
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            gender,
            style: TextStyle(fontSize: _responsiveFont(context, 18), fontWeight: FontWeight.bold, color: isSelected ? Colors.black : Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Reusable slide+fade page transition used for moving to Onboarding2
PageRouteBuilder<T> _slideFade<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic))
              .animate(anim),
          child: child,
        ),
      );
    },
  );
}
