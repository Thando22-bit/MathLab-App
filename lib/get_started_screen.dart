import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'grade10_home_screen.dart';
import 'grade11_home_screen.dart';
import 'grade12_home_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _uniController = TextEditingController();

  int? _selectedGrade; // 10, 11, 12

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _saveUserData() async {
    final name = _nameController.text.trim();
    final uni = _uniController.text.trim();

    if (name.isEmpty) {
      _showMsg('Please enter your name.');
      return;
    }
    if (_selectedGrade == null) {
      _showMsg('Please select your grade (10 / 11 / 12).');
      return;
    }
    if (uni.isEmpty) {
      _showMsg('Please enter your dream university.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setInt('gradeLevel', _selectedGrade!);
    await prefs.setString('dreamUniversity', uni);

    if (!mounted) return;

    // 🔗 Go straight to the chosen grade’s home screen
    Widget next;
    switch (_selectedGrade) {
      case 10:
        next = const Grade10HomeScreen();
        break;
      case 11:
        next = const Grade11HomeScreen();
        break;
      case 12:
      default:
        next = const Grade12HomeScreen();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    const accent = Colors.deepPurpleAccent;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/bg.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.88)),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    20,
                    18,
                    20,
                    20 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: title + white-bg logo
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                "Let’s get you set up 👋",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white, // White background
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                'assets/app_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: accent.withOpacity(0.18)),
                          ),
                          child: const Text(
                            "You’ve got the potential. We’ll bring the structure. "
                            "Choose your grade and tell us your dream university — "
                            "then let’s aim your math skills straight at that goal. 🚀",
                            style: TextStyle(fontSize: 14.5, height: 1.45),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Form card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionTitle("Your details"),
                              const SizedBox(height: 10),
                              _TextFieldCard(
                                label: "Your Name",
                                icon: Icons.person,
                                controller: _nameController,
                              ),

                              const SizedBox(height: 16),
                              const _SectionTitle("Select your grade"),
                              const SizedBox(height: 8),
                              _GradeChips(
                                selected: _selectedGrade,
                                onChanged: (g) => setState(() => _selectedGrade = g),
                              ),

                              const SizedBox(height: 16),
                              const _SectionTitle("Your dream university"),
                              const SizedBox(height: 8),
                              _TextFieldCard(
                                label: "Dream University",
                                icon: Icons.school,
                                controller: _uniController,
                              ),

                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _saveUserData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: const Text(
                                    "🔥 Let’s Begin",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),
                        Center(
                          child: Text(
                            "Small steps → Daily progress → Big wins.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
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

// ---------- UI bits ----------
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: Colors.black87),
    );
  }
}

class _TextFieldCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _TextFieldCard({
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

class _GradeChips extends StatelessWidget {
  final int? selected;
  final ValueChanged<int> onChanged;
  const _GradeChips({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final grades = [10, 11, 12];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: grades.map((g) {
        final isSel = selected == g;
        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "Grade $g",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isSel ? Colors.white : Colors.black87,
              ),
            ),
          ),
          selected: isSel,
          selectedColor: Colors.deepPurpleAccent,
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.08),
          onSelected: (_) => onChanged(g),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isSel
                  ? Colors.deepPurpleAccent
                  : Colors.deepPurpleAccent.withOpacity(0.25),
            ),
          ),
        );
      }).toList(),
    );
  }
}

