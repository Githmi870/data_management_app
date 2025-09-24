import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewFormScreen extends StatelessWidget {
  const NewFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Form'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Create a New Form',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                  child: Card(
                elevation: 4,
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownMenu(dropdownMenuEntries: 
                          const [
                            DropdownMenuEntry(value: 'option1', label: 'Option 1'),
                            DropdownMenuEntry(value: 'option2', label: 'Option 2'),
                            DropdownMenuEntry(value: 'option3', label: 'Option 3'),
                          ],
                          initialSelection: 'option1',
                          label: Text('ක්‍රියාත්මක ආයතනය'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle form submission
                        },
                        child: const Text('Create Form'),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
