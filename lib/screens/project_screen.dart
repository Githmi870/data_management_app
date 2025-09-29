import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Screen'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Projects'),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  title: Text('Project 1'),
                  subtitle: Text('Description of Project 1'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text('Project 2'),
                  subtitle: Text('Description of Project 2'),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}