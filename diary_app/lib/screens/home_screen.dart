// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:diary_app/constants.dart';
import 'package:diary_app/services/database_service.dart';
import 'package:diary_app/models/diary_model.dart';
import 'package:diary_app/services/auth_service.dart';
import 'package:diary_app/screens/add_edit_diary_screen.dart';
import 'package:diary_app/screens/login_screen.dart';
import 'package:diary_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _db = DatabaseService.instance;
  final AuthService _auth = AuthService();
  List<DiaryEntry> allEntries = [];
  List<DiaryEntry> filteredEntries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEntries();
    searchController.addListener(_filterEntries);
  }

  Future<void> _loadEntries() async {
    final entries = await _db.getAllEntries();
    setState(() {
      allEntries = entries;
      filteredEntries = entries;
    });
  }

  void _filterEntries() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredEntries = allEntries.where((entry) {
        final titleMatch = entry.title.toLowerCase().contains(query);
        final contentMatch = entry.content.toLowerCase().contains(query);
        final dateMatch = entry.date.contains(query);
        return titleMatch || contentMatch || dateMatch;
      }).toList();
    });
  }

  Future<void> _deleteEntry(int id) async {
    await _db.deleteEntry(id);
    _loadEntries();
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case "happy": return "😊";
      case "sad": return "😢";
      case "excited": return "😍";
      case "calm": return "😌";
      case "angry": return "😤";
      case "anxious": return "😰";
      case "confident": return "😎";
      default: return "😐";
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Diary", style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final appState = MyApp.of(context);
              appState.toggleTheme(!isDarkMode);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by title, date or content...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
          ),

          // Entries List
          Expanded(
            child: filteredEntries.isEmpty
                ? Center(
                    child: searchController.text.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu_book, size: 80, color: Colors.grey[400]),
                              const SizedBox(height: 20),
                              Text("No entries yet", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                              const Text("Tap + to start writing"),
                            ],
                          )
                        : const Text("No entries found", style: TextStyle(fontSize: 18)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredEntries.length,
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      return Dismissible(
                        key: Key(entry.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
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
                        },
                        onDismissed: (direction) => _deleteEntry(entry.id!),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(20),
                            title: Text(entry.title.isEmpty ? "Untitled" : entry.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(entry.date)), style: TextStyle(color: Colors.grey[600])),
                                    const Spacer(),
                                    Text(_getMoodEmoji(entry.mood), style: const TextStyle(fontSize: 24)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(entry.content.length > 100 ? "${entry.content.substring(0, 100)}..." : entry.content),
                              ],
                            ),
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditDiaryScreen(entry: entry)));
                              _loadEntries();
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditDiaryScreen()));
          _loadEntries();
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text("Add Entry"),
      ),
    );
  }
}