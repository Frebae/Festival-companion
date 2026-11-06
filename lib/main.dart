import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FestivalBuddyApp());
}

class FestivalBuddyApp extends StatelessWidget {
  const FestivalBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Buddy',
      debugShowCheckedModeBanner: false,
      theme: galacticFunkadelicTheme,
      // Tijdelijk startscherm om het thema te testen.
      // Zodra de schermen in lib/screens/ af zijn, komt hier de navigatie.
      home: const ThemaTest(),
    );
  }
}

class ThemaTest extends StatelessWidget {
  const ThemaTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Festival Buddy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Galactic Funkadelic',
                style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.music_note, color: GalacticColors.accentCyan),
                title: Text('Voorbeeld act'),
                subtitle: Text('Mainstage · 21:00'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Voorbeeldknop'),
            ),
          ],
        ),
      ),
    );
  }
}