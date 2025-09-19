import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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
    final double titleSize = size.width * 0.1; // Responsive title
    final double taglineSize = size.width * 0.035; // Responsive tagline
    final double buttonHeight = size.height * 0.07; // Button adjusts
    final double spacing = size.height * 0.03; // Spacing adjusts

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_bg.png"),
            fit: BoxFit.cover, // Ensures full coverage across devices
          ),
        ),
        child: Stack(
          children: [
            // Transparent overlay (instead of dark overlay)
            Container(color: Colors.transparent),

            // Content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: SlideTransition(
                    position: _slideUp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: spacing * 1.2),

                        // Title
                        Text(
                          "FYT LYF",
                          style: TextStyle(
                            fontSize: titleSize.clamp(28, 50), // clamp for extreme screens
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            letterSpacing: 2,
                          ),
                        ),

                        SizedBox(height: spacing * 0.4),

                        // Tagline
                        Text(
                          "FEEL YOUR TRANSFORMATION",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: taglineSize.clamp(12, 18),
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),

                        Text(
                          "LOVE YOUR FITNESS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: taglineSize.clamp(12, 18),
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),

                        const Spacer(),

                        // Get Started Button
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight.clamp(45, 65),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/onboarding');
                            },
                            child: Text(
                              "GET STARTED",
                              style: TextStyle(
                                fontSize: (taglineSize * 1.2).clamp(14, 22),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: spacing * 0.5),

                        // Login Text
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Already a member? Log in",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: taglineSize.clamp(12, 16),
                            ),
                          ),
                        ),

                        SizedBox(height: spacing),
                      ],
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