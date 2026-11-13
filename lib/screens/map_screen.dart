
import 'package:material_ui/material_ui.dart';

class FestivalPlace {
  final String name;
  final String description;
  final IconData icon;
  final double x;
  final double y;
  final List<String> directions;

  const FestivalPlace({
    required this.name,
    required this.description,
    required this.icon,
    required this.x,
    required this.y,
    required this.directions,
  });
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const Color darkBlue = Color(0xFF101B42);
  static const Color purple = Color(0xFF7863B8);
  static const Color turquoise = Color(0xFF65DCEB);

  final List<FestivalPlace> places = const [
    FestivalPlace(
      name: 'Main Stage',
      description: 'Het hoofdpodium van het festival.',
      icon: Icons.music_note,
      x: 0.83,
      y: 0.17,
      directions: [
        'Volg het hoofdpad naar rechts.',
        'Loop richting het grote podium.',
        'Je hebt de Main Stage bereikt!',
      ],
    ),
    FestivalPlace(
      name: 'Stage 2',
      description: 'Hier kun je genieten van live muziek.',
      icon: Icons.headphones,
      x: 0.40,
      y: 0.27,
      directions: [
        'Volg het pad richting het midden.',
        'Ga richting het bosgebied.',
        'Je bent bij Stage 2!',
      ],
    ),
    FestivalPlace(
      name: 'Stage 3',
      description: 'Ontdek de muziek bij Stage 3.',
      icon: Icons.album,
      x: 0.58,
      y: 0.39,
      directions: [
        'Volg het pad naar het midden van het terrein.',
        'Loop richting de paarse zone.',
        'Je bent bij Stage 3!',
      ],
    ),
    FestivalPlace(
      name: 'Food Court',
      description: 'Hier vind je verschillende eetkraampjes.',
      icon: Icons.fastfood,
      x: 0.27,
      y: 0.53,
      directions: [
        'Volg het pad naar links.',
        'Loop richting de eetkraampjes.',
        'Je bent bij de Food Court!',
      ],
    ),
    FestivalPlace(
      name: 'Toiletten',
      description: 'Hier vind je de toiletten.',
      icon: Icons.wc,
      x: 0.65,
      y: 0.76,
      directions: [
        'Volg het pad richting de onderkant.',
        'Zoek de faciliteiten bij het hoofdpad.',
        'Je hebt de toiletten gevonden!',
      ],
    ),
    FestivalPlace(
      name: 'EHBO',
      description: 'Hier kun je terecht voor medische hulp.',
      icon: Icons.medical_services,
      x: 0.77,
      y: 0.78,
      directions: [
        'Volg het hoofdpad naar rechts.',
        'Zoek de EHBO-post bij de faciliteiten.',
        'Je bent bij de EHBO!',
      ],
    ),
    FestivalPlace(
      name: 'Bar',
      description: 'Hier kun je drinken halen.',
      icon: Icons.local_bar,
      x: 0.48,
      y: 0.68,
      directions: [
        'Volg het pad naar het midden.',
        'Loop richting de centrale zone.',
        'Je bent bij de bar!',
      ],
    ),
    FestivalPlace(
      name: 'Ingang',
      description: 'De ingang en uitgang van het festival.',
      icon: Icons.login,
      x: 0.15,
      y: 0.78,
      directions: [
        'Volg het hoofdpad naar de linkeronderkant.',
        'Loop richting de ingang.',
        'Je bent bij de ingang!',
      ],
    ),
  ];

  void showPlace(BuildContext context, FestivalPlace place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(place.icon, color: turquoise, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      place.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                place.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoise,
                    foregroundColor: darkBlue,
                    padding: const EdgeInsets.all(15),
                  ),
                  icon: const Icon(Icons.navigation),
                  label: const Text('Start navigatie'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NavigationScreen(place: place),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        title: const Text(
          'Festival Map',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Ontdek het festivalterrein',
              style: TextStyle(
                color: turquoise,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 3,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/festival_map.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ...places.map((place) {
                          return Positioned(
                            left: constraints.maxWidth * place.x - 24,
                            top: constraints.maxHeight * place.y - 24,
                            child: GestureDetector(
                              onTap: () => showPlace(context, place),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: purple,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: turquoise,
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      place.icon,
                                      color: Colors.white,
                                      size: 23,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: darkBlue,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      place.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
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
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: darkBlue,
            child: const Text(
              'Tik op een icoontje om een locatie te bekijken.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: turquoise,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationScreen extends StatelessWidget {
  final FestivalPlace place;

  const NavigationScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101B42),
      appBar: AppBar(
        title: const Text('Navigatie'),
        backgroundColor: const Color(0xFF101B42),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.navigation,
              color: Color(0xFF65DCEB),
              size: 55,
            ),
            const SizedBox(height: 15),
            Text(
              'Route naar ${place.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Volg deze stappen:',
              style: TextStyle(
                color: Color(0xFF65DCEB),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ...place.directions.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF7863B8),
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF65DCEB),
                  foregroundColor: const Color(0xFF101B42),
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Terug naar de festivalmap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

