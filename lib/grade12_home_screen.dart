import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'join_group_screen.dart';
import 'get_started_screen.dart';


import 'math_term1_screen.dart';
import 'math_term2_screen.dart';
import 'math_term3_screen.dart';

class Grade12HomeScreen extends StatefulWidget {
  const Grade12HomeScreen({super.key});

  @override
  State<Grade12HomeScreen> createState() => _Grade12HomeScreenState();
}

class _Grade12HomeScreenState extends State<Grade12HomeScreen> {
  String username = '';
  String dreamUniversity = '';
  int gradeLevel = 12;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      dreamUniversity = prefs.getString('dreamUniversity') ?? '';
      gradeLevel = prefs.getInt('gradeLevel') ?? 12;
    });
  }

  Future<void> _openTerm(BuildContext context, int term) async {
    if (term == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MathTerm1Screen()));
    } else if (term == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MathTerm2Screen()));
    } else if (term == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MathTerm3Screen()));
    } else {
    
      const url = 'https://www.testpapers.co.za/gr12-mathematics';
      final uri = Uri.parse(url);
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open past papers link.')),
        );
      }
    }
  }

  Future<void> _goHome() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset & Go Home?'),
        content: const Text(
          'This will take you back to the Get Started screen and clear your saved setup (name, grade, university). Continue?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Yes, reset')),
        ],
      ),
    );

    if (confirm != true) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('gradeLevel');
    await prefs.remove('dreamUniversity');

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const GetStartedScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = Colors.indigo;

    return Scaffold(
      body: Stack(
        children: [
        
          Positioned.fill(
            child: Image.asset('assets/bg.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.85)),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36), // space for top-right home button

                  // Greeting + Motivation
                  Text(
                    'Welcome ${username.isEmpty ? "champ" : username} 👋',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "This is the finish line year. Tight habits and past papers will carry you. "
                    "You don’t have to be perfect, just consistent.",
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.45,
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  if (dreamUniversity.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accent.withOpacity(0.2)),
                      ),
                      child: Text(
                        "Destination: $dreamUniversity 🎯  — every solved question moves you closer.",
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                  const Text(
                    "Terms",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _TermCard(
                    title: "Term 1",
                    color: Colors.green,
                    onTap: () => _openTerm(context, 1),
                  ),
                  const SizedBox(height: 12),
                  _TermCard(
                    title: "Term 2",
                    color: Colors.blueAccent,
                    onTap: () => _openTerm(context, 2),
                  ),
                  const SizedBox(height: 12),
                  _TermCard(
                    title: "Term 3",
                    color: Colors.orangeAccent,
                    onTap: () => _openTerm(context, 3),
                  ),
                  const SizedBox(height: 12),
                  _TermCard(
                    title: "Term 4 (Past Papers)",
                    color: Colors.redAccent,
                    onTap: () => _openTerm(context, 4),
                  ),

                  const SizedBox(height: 26),
                  const Text(
                    "Need extra help? Join our private WhatsApp group where you'll attend one-on-one online classes, ask questions, and get support whenever you're stuck. We're here to help you succeed! 💯",
                    style: TextStyle(fontSize: 14, height: 1.55, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const JoinGroupScreen()),
                        );
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text('Join WhatsApp Group'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

    
        
          Positioned(
            top: 8,
            right: 8,
            child: SafeArea(
              child: Material(
                color: accent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: _goHome,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.home_rounded, color: Colors.white, size: 22),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----- UI pieces -----
class _TermCard extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _TermCard({
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }
}

