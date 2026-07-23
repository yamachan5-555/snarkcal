import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/home/home_screen.dart';

void main() {
  runApp(
    // Riverpodを有効にするために必須の囲み
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet Poison App',
      theme: ThemeData(primarySwatch: Colors.amber, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
