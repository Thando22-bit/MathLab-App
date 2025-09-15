import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MathTerm4Screen extends StatelessWidget {
  const MathTerm4Screen({super.key});

  final String papersUrl = "https://www.testpapers.co.za/gr12-mathematics";

  Future<void> _openLink() async {
    final Uri uri = Uri.parse(papersUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $papersUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Term 4 – Past Papers"),
        backgroundColor: Colors.purpleAccent, // math color
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/bg.png', fit: BoxFit.cover),
          ),
          Container(color: Colors.white.withOpacity(0.85)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Revision Time! 📚",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Now let’s prepare for the exam by practicing previous Mathematics question papers.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.purpleAccent,
                    ),
                    onPressed: _openLink,
                    icon: const Icon(Icons.link),
                    label: const Text(
                      "Open Past Papers",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


