import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectGroupScreen extends StatelessWidget {
  final String subject;
  const SubjectGroupScreen({super.key, required this.subject});

  Future<void> _openWhatsApp(String subject) async {
    final msg = Uri.encodeComponent(
      "Hi, I have paid for $subject. Here's my proof of payment."
    );
    final url = Uri.parse("https://wa.me/27823695623?text=$msg");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    const accent = Colors.deepPurpleAccent;

    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        backgroundColor: accent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bank details card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "💳 Bank Details",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text("ACCOUNT NO: 20093758705", style: TextStyle(fontSize: 15)),
                        Text("AFRICAN BANK", style: TextStyle(fontSize: 15)),
                        Text("SAVINGS", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // After-payment notice
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accent.withOpacity(0.18)),
                    ),
                    child: const Text(
                      "After payment, tap the button below to open WhatsApp and send your Proof of Payment. ",
            
                      style: TextStyle(fontSize: 14, height: 1.55),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // WhatsApp button
                  ElevatedButton.icon(
                    onPressed: () => _openWhatsApp(subject),
                    icon: const Icon(Icons.chat),
                    label: const Text("Open WhatsApp"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

