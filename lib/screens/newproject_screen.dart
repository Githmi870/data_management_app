import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Project')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a new Project here!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Project Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a project name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Project Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownMenu(
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                  value: 'edu', label: 'Education Department'),
                              DropdownMenuEntry(
                                  value: 'agri', label: 'Agricultural Department'),
                              DropdownMenuEntry(
                                  value: 'fish', label: 'Fishery Department'),
                            ],
                            label: const Text('Department'),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownMenu(
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                  value: 'admin', label: 'Administration'),
                              DropdownMenuEntry(
                                  value: 'acc', label: 'Accounting'),
                              DropdownMenuEntry(
                                  value: 'dev', label: 'Development'),
                            ],
                            label: const Text('Sector'),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownMenu(
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(
                                  value: 'new',
                                  label: 'New Project'),
                              DropdownMenuEntry(
                                  value: 'continuous',
                                  label: 'Canceled Project'),
                              DropdownMenuEntry(
                                  value: 'completed',
                                  label: 'Completed Project'),
                            ],
                            label: const Text('Project Status'),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _dateController,
                          decoration: const InputDecoration(
                            labelText: 'Started Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _dateController,
                          decoration: const InputDecoration(
                            labelText: 'Finished Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                            helperText: 'Leave empty for New Projects',
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          child: const Text('Create Project'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
