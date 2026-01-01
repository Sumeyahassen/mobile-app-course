// lib/screens/add_edit_diary_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diary_app/constants.dart';
import 'package:diary_app/models/diary_model.dart';
import 'package:diary_app/services/database_service.dart';

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
  String? _selectedMood;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? "");
    _contentController = TextEditingController(text: widget.entry?.content ?? "");
    _selectedDate = widget.entry?.date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    _selectedMood = widget.entry?.mood ?? "neutral";
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Fixed mood button - no overflow
  Widget _moodButton(String emoji, String value, String label) {
    bool isSelected = _selectedMood == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedMood = value),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.2) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.entry == null ? "New Entry" : "Edit Entry"),
        elevation: 0,
        actions: [
          if (widget.entry != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              tooltip: "Delete Entry",
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Delete Entry?"),
                    content: const Text("This cannot be undone."),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text("Delete", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await DatabaseService.instance.deleteEntry(widget.entry!.id!);
                  if (mounted) Navigator.pop(context);
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title (optional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Date Picker
              TextField(
                controller: TextEditingController(
                  text: DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(_selectedDate)),
                ),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(_selectedDate),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(const Duration(days: 1)),
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
              const SizedBox(height: 28),

              // Mood Section
              Text(
                "How are you feeling today?",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Mood Grid - Fixed overflow
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: 1.15, // Increased for more height
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _moodButton("😊", "happy", "Happy"),
                  _moodButton("😢", "sad", "Sad"),
                  _moodButton("😍", "excited", "Excited"),
                  _moodButton("😌", "calm", "Calm"),
                  _moodButton("😤", "angry", "Angry"),
                  _moodButton("😰", "anxious", "Anxious"),
                  _moodButton("😎", "confident", "Confident"),
                  _moodButton("😐", "neutral", "Neutral"),
                ],
              ),
              const SizedBox(height: 28),

              // Content
              SizedBox(
                height: 300,
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
                  validator: (val) => val!.isEmpty ? "Please write something" : null,
                ),
              ),
              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _selectedMood != null) {
                      final newEntry = DiaryEntry(
                        id: widget.entry?.id,
                        date: _selectedDate,
                        title: _titleController.text.trim(),
                        content: _contentController.text.trim(),
                        mood: _selectedMood!,
                      );

                      if (widget.entry == null) {
                        await DatabaseService.instance.insertEntry(newEntry);
                      } else {
                        await DatabaseService.instance.updateEntry(newEntry);
                      }
                      if (mounted) Navigator.pop(context);
                    } else if (_selectedMood == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select your mood"),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  },
                  child: Text(
                    widget.entry == null ? "Save Entry" : "Update Entry",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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