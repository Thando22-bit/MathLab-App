import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'get_started_screen.dart';
import 'join_group_screen.dart';


import 'grade11_term1_screen.dart';
import 'grade11_term2_screen.dart';
import 'grade11_term3_screen.dart';
import 'grade11_term4_screen.dart';

class Grade11HomeScreen extends StatefulWidget {
  const Grade11HomeScreen({super.key});

  @override
  State<Grade11HomeScreen> createState() => _Grade11HomeScreenState();
}

class _Grade11HomeScreenState extends State<Grade11HomeScreen> {
  String username = '';
  String dreamUniversity = '';
  int gradeLevel = 11;

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
      gradeLevel = prefs.getInt('gradeLevel') ?? 11;
    });
  }

  void _openTerm(BuildContext context, int term) {
    Widget screen;
    switch (term) {
      case 1:
        screen = const Grade11Term1Screen();
        break;
      case 2:
        screen = const Grade11Term2Screen();
        break;
      case 3:
        screen = const Grade11Term3Screen();
        break;
      case 4:
      default:
        screen = const Grade11Term4Screen();
        break;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  Future<void> _openRevision() async {
    const url = 'https://www.testpapers.co.za/gr11-mathematics';
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open past papers.')),
      );
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
    final accent = Colors.teal; // distinct color for Grade 11

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/bg.png', fit: BoxFit.cover),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36), // space for top-right home button

                  // Greeting + motivation
                  Text(
                    'Welcome ${username.isEmpty ? "legend" : username} 👋',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "This is the bridge to Matric. Master Grade 11 now, and Grade 12 feels lighter, faster, clearer.",
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
                        "Destination: $dreamUniversity 🎯  — every exercise sharpens your application strength.",
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
                    title: "Term 4",
                    color: Colors.redAccent,
                    onTap: () => _openTerm(context, 4),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Revision",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _RevisionCard(onTap: _openRevision),

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

          // 🏠 Top-right Home Button (correctly positioned in the Stack)
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

class _RevisionCard extends StatelessWidget {
  final VoidCallback onTap;
  const _RevisionCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Colors.purple;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.28)),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_stories, color: Colors.purple),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Revision Time (Past Papers & Practice)",
                style: TextStyle(
                  fontSize: 15.5,
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

