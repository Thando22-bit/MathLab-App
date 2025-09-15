import 'package:flutter/material.dart';
import 'notes_pdf_screen.dart';

class MathTerm1Screen extends StatelessWidget {
  const MathTerm1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const topics = [
      "Number Patterns, Sequences & Series",
      "Functions: Formal definition, inverse, exponential & logarithmic",
      "Trigonometry",
    ];

    const pdfPaths = [
      "assets/notes/number_pattern.pdf",
      "assets/notes/functions.pdf",
      "assets/notes/trigonometry.pdf",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Term 1 Topics"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset('assets/bg.png', fit: BoxFit.cover),
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotesPdfScreen(
                        title: topics[index],
                        assetPath: pdfPaths[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          topics[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.black54),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: topics.length,
          ),
        ],
      ),
    );
  }
}

