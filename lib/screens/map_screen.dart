
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String selectedPlace = 'Klik op een locatie op de kaart';

  final List<Map<String, dynamic>> places = [
    {'name': 'Hoofdpodium', 'icon': Icons.music_note, 'x': 0.5, 'y': 0.2},
    {'name': 'Toiletten', 'icon': Icons.wc, 'x': 0.2, 'y': 0.4},
    {'name': 'EHBO', 'icon': Icons.medical_services, 'x': 0.8, 'y': 0.4},
    {'name': 'Eten en drinken', 'icon': Icons.fastfood, 'x': 0.3, 'y': 0.7},
    {'name': 'Bar', 'icon': Icons.local_bar, 'x': 0.7, 'y': 0.7},
    {'name': 'Ingang', 'icon': Icons.login, 'x': 0.5, 'y': 0.9},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festivalmap'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.green.shade100,
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: Text(
                        'FESTIVAL TERREIN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ),
                    ...places.map((place) {
                      return Positioned(
                        left: constraints.maxWidth * place['x'] - 35,
                        top: constraints.maxHeight * place['y'] - 25,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPlace = place['name'];
                            });
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 25,
                                child: Icon(
                                  place['icon'],
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(4),
                                color: Colors.white,
                                child: Text(
                                  place['name'],
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.deepPurple.shade50,
            child: Text(
              selectedPlace,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
