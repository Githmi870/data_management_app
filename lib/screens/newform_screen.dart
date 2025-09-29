import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

enum QuestionType { text, checkbox, multipleChoice, dropdown }

class QuestionField {
  final QuestionType type;
  final TextEditingController controller;
  final List<String> options; // For multiple choice and dropdown
  final List<bool> checkboxValues; // For checkbox

  QuestionField.text()
      : type = QuestionType.text,
        controller = TextEditingController(),
        options = [],
        checkboxValues = [];

  QuestionField.checkbox()
      : type = QuestionType.checkbox,
        controller = TextEditingController(),
        options = [],
        checkboxValues = [false];

  QuestionField.multipleChoice()
      : type = QuestionType.multipleChoice,
        controller = TextEditingController(),
        options = ['Option 1', 'Option 2'],
        checkboxValues = [];

  QuestionField.dropdown()
      : type = QuestionType.dropdown,
        controller = TextEditingController(),
        options = ['Option 1', 'Option 2'],
        checkboxValues = [];
}

class NewFormScreen extends StatefulWidget {
  const NewFormScreen({super.key});

  @override
  _NewFormScreenState createState() => _NewFormScreenState();
}

class _NewFormScreenState extends State<NewFormScreen> {
  final List<QuestionField> _fields = [];

  void _addField(QuestionType type) {
    setState(() {
      switch (type) {
        case QuestionType.text:
          _fields.add(QuestionField.text());
          break;
        case QuestionType.checkbox:
          _fields.add(QuestionField.checkbox());
          break;
        case QuestionType.multipleChoice:
          _fields.add(QuestionField.multipleChoice());
          break;
        case QuestionType.dropdown:
          _fields.add(QuestionField.dropdown());
          break;
      }
    });
  }

  void _removeField(int index) {
    setState(() {
      _fields[index].controller.dispose();
      _fields.removeAt(index);
    });
  }

  String _saveField(int index) {
    final field = _fields[index];
    String text = 'Question ${index + 1}: ';
    switch (field.type) {
      case QuestionType.text:
        text = field.controller.text;
        break;
      case QuestionType.checkbox:
        text = field.checkboxValues.toString();
        break;
      case QuestionType.multipleChoice:
        text = field.options.toString();
        break;
      case QuestionType.dropdown:
        text = field.options.toString();
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved: $text')),
    );
    return text;
  }

  Widget _buildField(int index, String text) {
    final field = _fields[index];
    switch (field.type) {
      case QuestionType.text:
        return TextFormField(
          controller: field.controller,
          decoration: InputDecoration(labelText: '$text ${index + 1}'),
        );
      case QuestionType.checkbox:
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: field.controller,
                decoration: InputDecoration(labelText: '$text ${index + 1}'),
              ),
            ),
            Checkbox(
              value: field.checkboxValues[0],
              onChanged: (val) {
                setState(() {
                  field.checkboxValues[0] = val ?? false;
                });
              },
            ),
          ],
        );
      case QuestionType.multipleChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: field.controller,
              decoration: InputDecoration(labelText: '$text ${index + 1}'),
            ),
            ...field.options.asMap().entries.map((entry) {
              int optIdx = entry.key;
              String opt = entry.value;
              return Row(
                children: [
                  Radio<int>(
                    value: optIdx,
                    groupValue: null,
                    onChanged: (_) {},
                  ),
                  Expanded(
                    child: Text(opt),
                  ),
                ],
              );
            }),
          ],
        );
      case QuestionType.dropdown:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: field.controller,
              decoration: InputDecoration(labelText: '$text ${index + 1}'),
            ),
            DropdownButton<String>(
              value: field.options.first,
              items: field.options
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) {},
            ),
          ],
        );
    }
  }

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
                          child: DropdownMenu(dropdownMenuEntries: const [
                            DropdownMenuEntry(
                                value: 'option1', label: 'Option 1'),
                            DropdownMenuEntry(
                                value: 'option2', label: 'Option 2'),
                            DropdownMenuEntry(
                                value: 'option3', label: 'Option 3'),
                          ], label: Text('Select Project')),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Add Questions',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _fields.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: _buildField(index, 'Question')),
                                    IconButton(
                                      icon: Icon(Icons.save),
                                      onPressed: () => _saveField(index),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => _removeField(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        SpeedDial(
                          icon: Icons.add,
                          activeIcon: Icons.close,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          children: [
                            SpeedDialChild(
                              child: const Icon(Icons.text_fields),
                              label: 'Text Input',
                              onTap: () => _addField(QuestionType.text),
                            ),
                            SpeedDialChild(
                              child: const Icon(Icons.check_box),
                              label: 'Checkbox',
                              onTap: () => _addField(QuestionType.checkbox),
                            ),
                            SpeedDialChild(
                              child: const Icon(Icons.radio_button_checked),
                              label: 'Multiple Choice',
                              onTap: () => _addField(QuestionType.multipleChoice),
                            ),
                            SpeedDialChild(
                              child: const Icon(Icons.list),
                              label: 'Dropdown',
                              onTap: () => _addField(QuestionType.dropdown),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            // Handle form submission
                          },
                          child: const Text('Create Form'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
