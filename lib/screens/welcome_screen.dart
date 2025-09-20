import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to FYT LYF",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pottaOne(
                    fontSize: size.width * 0.09,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Your ultimate fitness companion.\nTrack workouts, calories, and more.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pottaOne(
                    fontSize: size.width * 0.05,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to the next screen (e.g., HomeScreen)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.pottaOne(
                      fontSize: size.width * 0.06,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}