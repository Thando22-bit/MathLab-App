import 'package:flutter/material.dart';
import 'notes_pdf_screen.dart';

class Grade11Term4Screen extends StatelessWidget {
  const Grade11Term4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const topics = [
      "Number Patterns",
    ];

    const pdfs = [
      "assets/notes/number_patterns_grade11.pdf",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grade 11 • Term 4"),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/bg.png', fit: BoxFit.cover),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotesPdfScreen(
                        title: "Number Patterns",
                        assetPath: "assets/notes/number_patterns_grade11.pdf",
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Number Patterns",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.black54),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

