import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart'; // Required for Linux support

import 'screens/home_screen.dart';
import 'models/nasheed_model.dart';

void main() {
  // Initialize the media_kit backend for just_audio on Linux (and other desktop platforms)
  // This fixes the MissingPluginException you were seeing on Linux
  JustAudioMediaKit.ensureInitialized(linux: true);

  runApp(
    MultiProvider(
      providers: [
        Provider<List<Nasheed>>(
          create: (_) => [], // Initial empty list
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ramadan Nasheeds',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Roboto', // You can change this to any Google Font if you add it
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}