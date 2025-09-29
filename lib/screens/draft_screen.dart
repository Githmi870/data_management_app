import 'package:flutter/material.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draft Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Draft Screen!'),
      ),
    );
  }
}