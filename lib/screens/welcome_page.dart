import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _buttonController;
  late Animation<double> _logoAnimation;
  late Animation<Offset> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Fade-in
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );
    _logoController.forward();

    // Button Slide-up
    _buttonController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _buttonAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // starts off screen
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeOut,
    ));

    Future.delayed(const Duration(milliseconds: 1500), () {
      _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with fade-in animation
                      FadeTransition(
                        opacity: _logoAnimation,
                        child: Container(
                          height: size.height * 0.3,
                          width: size.width * 0.6,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/fitness_logo.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // Title
                      Text(
                        "Welcome to Fitness App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                        ),
                        child: Text(
                          "Your personal fitness companion.\nTrack, train, and transform your lifestyle.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            color: isDark ? Colors.grey[300] : Colors.grey[700],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Animated Get Started Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.03,
                        ),
                        child: SlideTransition(
                          position: _buttonAnimation,
                          child: SizedBox(
                            width: double.infinity,
                            height: size.height * 0.07,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                // TODO: Navigate to next screen
                                // Example: Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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
          },
        ),
      ),
    );
  }
}