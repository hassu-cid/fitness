import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/onboarding1_screen.dart';
import 'screens/onboarding2_screen.dart';
import 'screens/age_screen.dart';
import 'screens/weight_height_screen.dart';
import 'screens/target_weight_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    // Base text theme with white display/body by default for dark scaffold
    final baseTextTheme = Theme.of(context).textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );

    // Red, black, white theme
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
      primary: Colors.red,
      onPrimary: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      secondary: Colors.redAccent,
      onSecondary: Colors.white,
    );

    return MaterialApp(
      title: 'FYT LYF',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.pottaOneTextTheme(baseTextTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          foregroundColor: Colors.white,
        ),
        cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
        ),
      ),

      // Use string route keys to avoid static routeName members
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/welcome': (_) => const WelcomeScreen(),
        '/onboarding1': (_) => const Onboarding1Screen(),
        '/onboarding2': (_) => const Onboarding2Screen(),
        '/age': (_) => const AgeScreen(),
        '/metrics': (_) => const WeightHeightScreen(),
        '/target-weight': (_) => const TargetWeightScreen(),
      },

      // Fallback
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: const RouteSettings(name: '/'),
      ),
    );
  }
}
