import 'package:flutter/material.dart';
import 'notes_pdf_screen.dart';

class Grade10Term2Screen extends StatelessWidget {
  const Grade10Term2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const topics = [
      "POLYGONS",
      "ANALYTICAL GEOMETRY",
      "FUNCTIONS",
    ];

    
    const pdfs = [
      "assets/notes/polygons.pdf",
      "assets/notes/analytical_geometry10.pdf",
      "assets/notes/functions10.pdf",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Term 2 Topics"),
        backgroundColor: Colors.blueAccent,
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
            itemBuilder: (context, i) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotesPdfScreen(
                      title: topics[i],
                      assetPath: pdfs[i],
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        topics[i],
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
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: topics.length,
          ),
        ],
      ),
    );
  }
}

