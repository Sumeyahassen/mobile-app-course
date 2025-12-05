// lib/screens/add_edit_diary_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/diary_model.dart';
import '../services/database_service.dart';

class AddEditDiaryScreen extends StatefulWidget {
  final DiaryEntry? entry;
  const AddEditDiaryScreen({super.key, this.entry});

  @override
  State<AddEditDiaryScreen> createState() => _AddEditDiaryScreenState();
}

class _AddEditDiaryScreenState extends State<AddEditDiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? "");
    _contentController = TextEditingController(text: widget.entry?.content ?? "");
    _selectedDate = widget.entry?.date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry == null ? "New Entry" : "Edit Entry"),
        actions: [
          if (widget.entry != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await DatabaseService.instance.deleteEntry(widget.entry!.id!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title (optional)", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(_selectedDate))),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(_selectedDate),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    labelText: "Write your thoughts...",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Write something" : null,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newEntry = DiaryEntry(
                        id: widget.entry?.id,
                        date: _selectedDate,
                        title: _titleController.text.trim(),
                        content: _contentController.text.trim(),
                      );

                      if (widget.entry == null) {
                        await DatabaseService.instance.insertEntry(newEntry);
                      } else {
                        await DatabaseService.instance.updateEntry(newEntry);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.entry == null ? "Save Entry" : "Update Entry", style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}