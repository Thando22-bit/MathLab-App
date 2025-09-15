import 'package:flutter/material.dart';
import 'subject_group_screen.dart';

class JoinGroupScreen extends StatelessWidget {
  const JoinGroupScreen({super.key});

  void _goToWhatsAppFlow(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SubjectGroupScreen(subject: "Mathematics"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const accent = Colors.deepPurpleAccent;

    return Scaffold(
      // make keyboard play nicely and avoid odd jumps
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          //  Full-bleed background (no cut at bottom)
          Positioned.fill(
            child: Image.asset('assets/bg.png', fit: BoxFit.cover),
          ),
          //  Soft overlay for readability
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.88)),
          ),

          //  Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                  child: ConstrainedBox(
                    // Ensures content stretches to full height -> no white strip
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 18 /*top safe*/),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Text(
                          "Join the Maths Study Group",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.black.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Price card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green.shade200),
                                ),
                                child: const Text(
                                  "R40 / month",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  "Cancel anytime • Live help • Exam revision",
                                  style: TextStyle(fontSize: 13.5, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Benefits
                        const _Benefits(),

                        const SizedBox(height: 24),

                        // CTA
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _goToWhatsAppFlow(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.chat),
                            label: const Text("Join on WhatsApp"),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Trust line
                        Center(
                          child: Text(
                            "No contracts • Easy cancel • Real support",
                            style: TextStyle(
                              fontSize: 12.8,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // Spacer-like box to ensure full-height fill on tall screens
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Benefits extends StatelessWidget {
  const _Benefits();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _BenefitTile(
          icon: Icons.school,
          title: "Live online classes",
          subtitle: "2-hour, focused sessions with step-by-step methods that stick.",
        ),
        SizedBox(height: 10),
        _BenefitTile(
          icon: Icons.help_outline,
          title: "Ask anything, anytime",
          subtitle: "Stuck on homework or past papers? Drop a question and get help.",
        ),
        SizedBox(height: 10),
        _BenefitTile(
          icon: Icons.auto_awesome,
          title: "Exam-ready notes & tips",
          subtitle: "Clean methods, common traps, and how to score method marks.",
        ),
      ],
    );
  }
}

class _BenefitTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _BenefitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Colors.deepPurpleAccent;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 14, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

