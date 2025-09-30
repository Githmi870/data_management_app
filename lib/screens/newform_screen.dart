import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'response_collection_screen.dart';

enum QuestionType { text, checkbox, multipleChoice, dropdown }

class QuestionField {
  final QuestionType type;
  final TextEditingController controller;
  String label;
  final List<String> options;
  final List<bool> checkboxValues;
  String? selectedDropdownValue;

  QuestionField.text()
      : type = QuestionType.text,
        controller = TextEditingController(),
        label = '',
        options = [],
        checkboxValues = [],
        selectedDropdownValue = null;

  QuestionField.checkbox()
      : type = QuestionType.checkbox,
        controller = TextEditingController(),
        label = '',
        options = [],
        checkboxValues = [false],
        selectedDropdownValue = null;

  QuestionField.multipleChoice()
      : type = QuestionType.multipleChoice,
        controller = TextEditingController(),
        label = '',
        options = ['Option 1', 'Option 2'],
        checkboxValues = [],
        selectedDropdownValue = null;

  QuestionField.dropdown()
      : type = QuestionType.dropdown,
        controller = TextEditingController(),
        label = '',
        options = ['Option 1', 'Option 2'],
        checkboxValues = [],
        selectedDropdownValue = null;
}

class SavedQuestion {
  final QuestionType type;
  final String question;
  final List<String> options;

  SavedQuestion({
    required this.type,
    required this.question,
    required this.options,
  });
}

class CreatedForm {
  final String projectName;
  final List<SavedQuestion> questions;
  final DateTime createdAt;

  CreatedForm({
    required this.projectName,
    required this.questions,
    required this.createdAt,
  });
}

class NewFormScreen extends StatefulWidget {
  const NewFormScreen({super.key});

  @override
  NewFormScreenState createState() => NewFormScreenState();
}

class NewFormScreenState extends State<NewFormScreen> {
  final List<QuestionField> _fields = [];
  String? _selectedProject;

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
    String text = '';

    switch (field.type) {
      case QuestionType.text:
        text = 'Text Question: ${field.controller.text}';
        break;
      case QuestionType.checkbox:
        text =
            'Checkbox Question: ${field.controller.text}, Checked: ${field.checkboxValues[0]}';
        break;
      case QuestionType.multipleChoice:
        text =
            'Multiple Choice: ${field.controller.text}, Options: ${field.options.join(", ")}';
        break;
      case QuestionType.dropdown:
        text =
            'Dropdown: ${field.controller.text}, Options: ${field.options.join(", ")}';
        if (field.selectedDropdownValue != null) {
          text += ', Selected: ${field.selectedDropdownValue}';
        }
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved: $text')),
    );
    return text;
  }

  void _createForm() {
    if (_fields.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add at least one question')),
      );
      return;
    }

    // Convert fields to saved questions
    List<SavedQuestion> savedQuestions = _fields.map((field) {
      return SavedQuestion(
        type: field.type,
        question: field.controller.text.isEmpty
            ? 'Untitled Question'
            : field.controller.text,
        options: List.from(field.options),
      );
    }).toList();

    // Create the form object
    CreatedForm createdForm = CreatedForm(
      projectName: _selectedProject ?? 'Untitled Project',
      questions: savedQuestions,
      createdAt: DateTime.now(),
    );

    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Form Created!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your form has been created successfully.'),
            SizedBox(height: 16),
            Text(
              'Project: ${createdForm.projectName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Questions: ${createdForm.questions.length}'),
            SizedBox(height: 16),
            Text('Would you like to start collecting responses?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponseCollectionScreen(
                    form: createdForm,
                  ),
                ),
              );
            },
            child: Text('Start Collecting'),
          ),
        ],
      ),
    );
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
            SizedBox(height: 16),
            ...field.options.asMap().entries.map((entry) {
              int optIdx = entry.key;
              String opt = entry.value;
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.radio_button_unchecked),
                      SizedBox(width: 8),
                      Flexible(
                        child: TextFormField(
                          initialValue: opt,
                          decoration: InputDecoration(
                              labelText: 'Option ${optIdx + 1}'),
                          onChanged: (val) {
                            setState(() {
                              field.options[optIdx] = val;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            field.options.removeAt(optIdx);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              );
            }),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Option'),
              onPressed: () {
                setState(() {
                  field.options.add('Option ${field.options.length + 1}');
                });
              },
            ),
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
            SizedBox(height: 16),
            DropdownButton<String>(
              value: field.selectedDropdownValue,
              hint: Text('Select an option'),
              isExpanded: true,
              items: field.options
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  field.selectedDropdownValue = val;
                });
              },
            ),
            SizedBox(height: 16),
            ...field.options.asMap().entries.map((entry) {
              int optIdx = entry.key;
              String opt = entry.value;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: opt,
                          decoration: InputDecoration(
                              labelText: 'Option ${optIdx + 1}'),
                          onChanged: (val) {
                            setState(() {
                              field.options[optIdx] = val;
                              if (field.selectedDropdownValue == opt) {
                                field.selectedDropdownValue = val;
                              }
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            if (field.selectedDropdownValue == opt) {
                              field.selectedDropdownValue = null;
                            }
                            field.options.removeAt(optIdx);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              );
            }),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Option'),
              onPressed: () {
                setState(() {
                  field.options.add('Option ${field.options.length + 1}');
                });
              },
            ),
          ],
        );
      default:
        return SizedBox.shrink();
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
                          child: DropdownButton<String>(
                            value: _selectedProject,
                            hint: Text('Select Project'),
                            items: const [
                              DropdownMenuItem(
                                value: 'option1',
                                child: Text('Option 1'),
                              ),
                              DropdownMenuItem(
                                value: 'option2',
                                child: Text('Option 2'),
                              ),
                              DropdownMenuItem(
                                value: 'option3',
                                child: Text('Option 3'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedProject = value;
                              });
                            },
                          ),
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
                                    Expanded(
                                        child: _buildField(index, 'Question')),
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
                              onTap: () =>
                                  _addField(QuestionType.multipleChoice),
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
                          onPressed: _createForm,
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
