import 'package:flutter/material.dart';
import 'notes_pdf_screen.dart';

class Grade11Term3Screen extends StatelessWidget {
  const Grade11Term3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const topics = [
      "Trig Functions",
      "Trigonometry (2D)",
      "Statistics",
      "Probability",
      "Finance & Growth",
    ];

    
    const pdfs = [
      "assets/notes/trig_functions_grade11.pdf", 
      "assets/notes/Trigonometry2D_grade11.pdf",
      "assets/notes/stats_grade11.pdf",
      "assets/notes/probability11.pdf",
      "assets/notes/finance11.pdf",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grade 11 • Term 3"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: _TopicList(color: Colors.orangeAccent, topics: topics, pdfs: pdfs),
    );
  }
}

class _TopicList extends StatelessWidget {
  final Color color;
  final List<String> topics;
  final List<String> pdfs;

  const _TopicList({
    required this.color,
    required this.topics,
    required this.pdfs,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: color.withOpacity(0.3)),
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
    );
  }
}

