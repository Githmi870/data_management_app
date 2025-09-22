import 'package:flutter/material.dart';

class NewFormScreen extends StatelessWidget {
  const NewFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Form'),
      ),
      body: const Center(
        child: Text('Create a new Form here!'),
      ),
    );
  }
}