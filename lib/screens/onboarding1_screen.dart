import 'package:flutter/material.dart';

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
                  padding:
                  EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.25,
                          minHeight: isTablet ? 6 : 4,
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          // TODO: Skip logic
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: _responsiveFont(context, 16),
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  "What's your gender?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _responsiveFont(context, 26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Let us know you better",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _responsiveFont(context, 16),
                    color: Colors.black54,
                  ),
                ),

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
                        left: selectedGender == "Female"
                            ? size.width * 0.05
                            : (selectedGender == "Male"
                            ? size.width * 0.25
                            : size.width * 0.15),
                        top: selectedGender == "Male" ? 0 : size.height * 0.05,
                        child: _buildGenderOption(
                          gender: "Male",
                          image: "assets/images/male.png",
                          isSelected: selectedGender == "Male",
                          highlightColor: Colors.lightBlueAccent,
                          onTap: () => setState(() => selectedGender = "Male"),
                          size: size,
                          hasSelection: selectedGender != null,
                          context: context,
                        ),
                      ),

                      // Female
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        right: selectedGender == "Male"
                            ? size.width * 0.05
                            : (selectedGender == "Female"
                            ? size.width * 0.25
                            : size.width * 0.15),
                        top: selectedGender == "Female" ? 0 : size.height * 0.05,
                        child: _buildGenderOption(
                          gender: "Female",
                          image: "assets/images/female.png",
                          isSelected: selectedGender == "Female",
                          highlightColor: Colors.pinkAccent,
                          onTap: () => setState(() => selectedGender = "Female"),
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
                  padding: EdgeInsets.all(isTablet ? 30 : 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: isTablet ? 70 : 55,
                    child: ElevatedButton(
                      onPressed: selectedGender == null
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                            const Duration(milliseconds: 600),
                            pageBuilder: (_, __, ___) =>
                                NextOnboardingScreen(
                                  gender: selectedGender!,
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.grey[300],
                      ).copyWith(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color?>(
                              (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey[300];
                            }
                            return null;
                          },
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: selectedGender == null
                              ? null
                              : const LinearGradient(
                            colors: [Color(0xFF007BFF), Color(0xFF0056D2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "NEXT",
                            style: TextStyle(
                              fontSize: _responsiveFont(context, 18),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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

    final containerHeight = isSelected
        ? size.height * (isTablet ? 0.42 : 0.38)
        : size.height * (isTablet ? 0.32 : 0.28);

    final containerWidth = isSelected
        ? size.width * (isTablet ? 0.28 : 0.35)
        : size.width * (isTablet ? 0.22 : 0.25);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Hero(
            tag: gender,
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
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: !hasSelection
                        ? 1.0
                        : (isSelected ? 1.0 : 0.5),
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            gender,
            style: TextStyle(
              fontSize: _responsiveFont(context, 18),
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class NextOnboardingScreen extends StatelessWidget {
  final String gender;

  const NextOnboardingScreen({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text("Next Onboarding")),
      body: Center(
        child: Hero(
          tag: gender,
          child: Image.asset(
            gender == "Male"
                ? "assets/images/male.png"
                : "assets/images/female.png",
            height: isTablet ? 400 : 300,
          ),
        ),
      ),
    );
  }
}