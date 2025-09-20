import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/onboarding1_screen.dart';
import 'screens/onboarding2_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FYT LYF',
      debugShowCheckedModeBanner: false,

      // ✅ Theme setup (future-proof & reusable)
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.pottaOneTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),

      // ✅ Entry point
      initialRoute: SplashScreen.routeName,

      // ✅ Centralized routes (easy to manage in future)
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        Onboarding1Screen.routeName: (_) => const Onboarding1Screen(),
        Onboarding2Screen.routeName: (_) => const Onboarding2Screen(),
      },

      // ✅ Prevents navigation errors (safety fallback)
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      ),
    );
  }
}