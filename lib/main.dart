import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'get_started_screen.dart';
import 'grade10_home_screen.dart';
import 'grade11_home_screen.dart';
import 'grade12_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Decide initial destination based on saved prefs
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');
  final grade = prefs.getInt('gradeLevel');

  Widget initial;
  if (username == null || username.trim().isEmpty || grade == null) {
    initial = const GetStartedScreen();
  } else {
    initial = _gradeHomeFor(grade);
  }

  runApp(MyApp(initialScreen: initial));
}

Widget _gradeHomeFor(int grade) {
  switch (grade) {
    case 10:
      return const Grade10HomeScreen();
    case 11:
      return const Grade11HomeScreen();
    case 12:
    default:
      return const Grade12HomeScreen();
  }
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathLab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFDFDFD),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // Show splash first; it fades into the correct initial screen.
      home: SplashScreen(next: initialScreen),
    );
  }
}

/// Simple, clean splash with a fade-in logo.
class SplashScreen extends StatefulWidget {
  final Widget next;
  const SplashScreen({super.key, required this.next});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic);
    _ac.forward();
    Timer(const Duration(milliseconds: 1800), _goNext);
  }

  Future<void> _goNext() async {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => widget.next,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache the logo for a crisp show.
    precacheImage(const AssetImage('assets/app_logo.png'), context);
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/app_logo.png',
                width: 160,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 18),
              Text(
                'MathLab',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.85),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 2.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

