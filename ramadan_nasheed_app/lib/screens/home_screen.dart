import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ramadan_nasheed_app/services/audio_player_service.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadNasheeds();
  }

  Future<void> _loadNasheeds() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/nasheeds.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final nasheeds = jsonList.map((json) => Nasheed.fromJson(json)).toList();

      setState(() {
        allNasheeds = nasheeds;
        filteredNasheeds = nasheeds;
        isLoading = false;
      });

      await AudioService.initPlaylist(nasheeds);

      if (mounted) {
        Provider.of<List<Nasheed>>(context, listen: false)
          ..clear()
          ..addAll(nasheeds);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading nasheeds: $e')),
        );
        setState(() => isLoading = false);
      }
    }
  }

  void _filterNasheeds(String query) {
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
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
            strokeWidth: 3,
          ),
        ),
      );
    }

    return Provider<List<Nasheed>>(
      create: (_) => List.from(allNasheeds),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black54, // Makes text more readable on dark background
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    children: [
                      const Text(
                        'Ramadan Nasheeds',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Peaceful collection for Ramadan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _searchController,
                        onChanged: _filterNasheeds,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search nasheeds...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.search, color: Colors.amber),
                          filled: true,
                          fillColor: Colors.black38,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ],
                  ),
                ),

                // Language Tabs
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.amber,
                  indicatorWeight: 4,
                  onTap: (index) {
                    setState(() {
                      selectedLanguage = ['All', 'Arabic', 'English'][index];
                      _filterNasheeds(_searchController.text);
                    });
                  },
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Arabic'),
                    Tab(text: 'English'),
                  ],
                ),

                // Nasheed List
                Expanded(
                  child: StreamBuilder<int?>(
                    stream: AudioService.player.currentIndexStream,
                    builder: (context, snapshot) {
                      final currentIndex = snapshot.data ?? -1;
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 140, top: 8),
                        itemCount: filteredNasheeds.length,
                        itemBuilder: (context, index) {
                          final nasheed = filteredNasheeds[index];
                          final globalIndex = allNasheeds.indexOf(nasheed);
                          return NasheedListItem(
                            nasheed: nasheed,
                            index: globalIndex,
                            isPlaying: currentIndex == globalIndex,
                          );
                        },
                      );
                    },
                  ),
                ),

                // Mini Player (always at bottom)
                const MiniPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}