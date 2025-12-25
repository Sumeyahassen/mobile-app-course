import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/nasheed_model.dart';
import '../services/audio_player_service.dart';
import '../widgets/nasheed_list_item.dart';
import '../widgets/mini_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Nasheed> allNasheeds = [];
  List<Nasheed> filteredNasheeds = [];
  String selectedLanguage = 'All';
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadNasheeds();
  }

  Future<void> _loadNasheeds() async {
    final String jsonString = await rootBundle.loadString('assets/data/nasheeds.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final nasheeds = jsonList.map((json) => Nasheed.fromJson(json)).toList();
    setState(() {
      allNasheeds = nasheeds;
      filteredNasheeds = nasheeds;
    });
    await AudioService.initPlaylist(nasheeds);
    if (mounted) Provider.of<List<Nasheed>>(context, listen: false)..clear()..addAll(nasheeds);
  }

  void _filter(String query) {
    setState(() {
      filteredNasheeds = allNasheeds.where((n) {
        final matchesSearch = n.title.toLowerCase().contains(query.toLowerCase()) ||
            n.artist.toLowerCase().contains(query.toLowerCase());
        final matchesLang = selectedLanguage == 'All' || n.language == selectedLanguage;
        return matchesSearch && matchesLang;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<List<Nasheed>>(
      create: (_) => allNasheeds,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.black],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Ramadan Nasheeds',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          shadows: [Shadow(color: Colors.black54, blurRadius: 10)],
                        ),
                      ),
                      const Text(
                        'Beautiful Offline Collection',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _searchController,
                        onChanged: _filter,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search nasheeds...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.search, color: Colors.amber),
                          filled: true,
                          fillColor: Colors.green.shade800,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Tabs
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.amber,
                  onTap: (index) {
                    setState(() {
                      selectedLanguage = ['All', 'Arabic', 'English'][index];
                      _filter(_searchController.text);
                    });
                  },
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Arabic'),
                    Tab(text: 'English'),
                  ],
                ),
                // List
                Expanded(
                  child: StreamBuilder<int?>(
                    stream: AudioService.player.currentIndexStream,
                    builder: (context, snapshot) {
                      final currentIndex = snapshot.data;
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: filteredNasheeds.length,
                        itemBuilder: (context, index) {
                          final nasheed = filteredNasheeds[index];
                          return NasheedListItem(
                            nasheed: nasheed,
                            index: allNasheeds.indexOf(nasheed),
                            isPlaying: currentIndex == allNasheeds.indexOf(nasheed),
                          );
                        },
                      );
                    },
                  ),
                ),
                const MiniPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}