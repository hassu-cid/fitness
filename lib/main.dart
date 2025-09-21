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
    final baseTextTheme = Theme.of(context).textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );

    return MaterialApp(
      title: 'FYT LYF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
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
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        Onboarding1Screen.routeName: (_) => const Onboarding1Screen(),
        Onboarding2Screen.routeName: (_) => const Onboarding2Screen(),
        AgeScreen.routeName: (_) => const AgeScreen(),
        WeightHeightScreen.routeName: (_) => const WeightHeightScreen(),
        TargetWeightScreen.routeName: (_) => const TargetWeightScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      ),
    );
  }
}