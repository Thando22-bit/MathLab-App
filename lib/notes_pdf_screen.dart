import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class NotesPdfScreen extends StatefulWidget {
  final String assetPath;
  final String title;
  const NotesPdfScreen({
    super.key,
    required this.assetPath,
    required this.title,
  });

  @override
  State<NotesPdfScreen> createState() => _NotesPdfScreenState();
}

class _NotesPdfScreenState extends State<NotesPdfScreen> {
  late PdfControllerPinch _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.assetPath),
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: PdfViewPinch(controller: _controller),
    );
  }
}

