import 'package:flutter/material.dart';
import 'weight_height_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AgeScreen extends StatefulWidget {
  static const routeName = '/age-screen';

  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _ageController = TextEditingController();
  final FocusNode _ageFocusNode = FocusNode();

  @override
  void dispose() {
    _ageController.dispose();
    _ageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),

              // Heading
              Text(
                'Your Age',
                style: GoogleFonts.roboto(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Tell us how old you are to personalize your plan.',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 60),

              // Input Card
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.red.withOpacity(0.2),
                child: TextField(
                  controller: _ageController,
                  focusNode: _ageFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    hintText: 'Enter your age',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.grey[500],
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 80),

              // Continue Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_ageController.text.isNotEmpty) {
                        Navigator.of(context).pushNamed(WeightHeightScreen.routeName);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
