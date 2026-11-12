import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  // Lijst met optredens voor het Galactic Funkadelic festival
  final List<FestivalAct> acts = [
    FestivalAct(
      time: '14:00 - 15:30',
      title: 'Cosmic Echoes',
      genre: 'Funk & Space Grooves',
      stage: 'Main Stage',
      isFavorite: false,
    ),
    FestivalAct(
      time: '16:00 - 17:30',
      title: 'Stargazer Disco',
      genre: 'Retro 70s Disco',
      stage: 'Disco Dome',
      isFavorite: true,
    ),
    FestivalAct(
      time: '18:00 - 19:30',
      title: 'Neon Jazz Collectief',
      genre: 'Space Jazz-Fusion',
      stage: 'Cosmic Stage 2',
      isFavorite: false,
    ),
    FestivalAct(
      time: '20:00 - 21:30',
      title: 'Supernova Funk Masters',
      genre: 'Funk & Brass',
      stage: 'Main Stage',
      isFavorite: false,
    ),
    FestivalAct(
      time: '22:00 - 00:00',
      title: 'DJ Stardust & The Glitteroids',
      genre: 'Intergalactic Party Set',
      stage: 'Disco Dome',
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Programma'),
        backgroundColor: const Color(0xFF1E143F),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF120A2A),
            child: const Row(
              children: [
                Icon(Icons.schedule, color: Color(0xFFFF2A85), size: 28), // Neon roze
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bekijk alle optredens en tik op het hartje om jouw favorieten op te slaan!',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: acts.length,
              itemBuilder: (context, index) {
                final act = acts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: const Color(0xFF1E143F), // Jullie Galactic kaartkleur
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF2A85).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.music_note, color: Color(0xFFFF2A85)),
                    ),
                    title: Text(
                      act.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text('${act.genre} · ${act.stage}',
                            style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text(act.time,
                            style: const TextStyle(
                                color: Color(0xFFFF8800), fontWeight: FontWeight.bold)), // Disco oranje
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        act.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: act.isFavorite ? const Color(0xFFFF2A85) : Colors.grey,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          act.isFavorite = !act.isFavorite; // Zet favoriet aan/uit
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FestivalAct {
  String time;
  String title;
  String genre;
  String stage;
  bool isFavorite;

  FestivalAct({
    required this.time,
    required this.title,
    required this.genre,
    required this.stage,
    required this.isFavorite,
  });
}