import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'models/nasheed_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<List<Nasheed>>(create: (_) => []),
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
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}