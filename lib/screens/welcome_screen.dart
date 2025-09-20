import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding1_screen.dart'; // ✅ Import Onboarding1

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String routeName = '/welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Adjustable horizontal space before FYT LYF and tagline
  final double horizontalOffset = 20.0; // change this to move text horizontally

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Dynamic font sizes
    final double logoFontSize = size.width * 0.09;
    final double taglineFontSize = size.width * 0.035;
    final double loginTextFontSize = size.width * 0.035;
    final double buttonFontSize = size.width * 0.05;

    // ✅ Smaller button size
    final double buttonWidth = size.width * 0.8;
    final double buttonHeight = size.height * 0.055;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Image.asset("assets/images/welcome_bg.png"),
                  ),
                ),
              ),

              // Overlay
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Top container (50% height)
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(left: horizontalOffset),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30), // Top spacing

                              // FYT LYF with glow
                              Text(
                                "FYT LYF",
                                style: TextStyle(
                                  fontFamily: 'PottaOne',
                                  fontSize: logoFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 25.0,
                                      color: Colors.redAccent,
                                      offset: Offset(0, 0),
                                    ),
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.white70,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),

                              // Tagline
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "FEEL YOUR TRANSFORMATION",
                                    style: GoogleFonts.roboto(
                                      fontSize: taglineFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "LOVE YOUR FITNESS",
                                    style: GoogleFonts.roboto(
                                      fontSize: taglineFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bottom container (50% height)
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // Align to bottom
                          children: [
                            // Get Started button
                            ElevatedButton(
                              onPressed: () {
                                // ✅ Navigate to Onboarding1
                                Navigator.pushReplacementNamed(
                                    context, Onboarding1Screen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minimumSize: Size(buttonWidth, buttonHeight),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                "GET STARTED",
                                style: GoogleFonts.roboto(
                                  fontSize: buttonFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 0),

                            // Login text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already a member?",
                                  style: GoogleFonts.roboto(
                                    fontSize: loginTextFontSize,
                                    color: Colors.white,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print('Log in Pressed!');
                                  },
                                  child: Text(
                                    " Log in",
                                    style: GoogleFonts.roboto(
                                      fontSize: loginTextFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}