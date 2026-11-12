import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home - Galactic Funkadelic')),
      body: const Center(
        child: Text('Welkom bij de Galactic Funkadelic Home!', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}