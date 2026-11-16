
import 'package:material_ui/material_ui.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
    this.onTabSelected,
  });

  final ValueChanged<int>? onTabSelected;

  static const Color blue = Color(0xFF168FE0);

  void showLocations(BuildContext context) {
    final locations = [
      'Main Stage',
      'Stage 2',
      'Stage 3',
      'Food Court',
      'Toiletten',
      'EHBO',
      'Bar',
      'Ingang',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171717),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Kies een locatie',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ...locations.map(
              (location) => ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: blue,
                ),
                title: Text(
                  location,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 16,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LocationScreen(
                        location: location,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            const Text(
              'MAP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: () => showLocations(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                child: Image.asset(
                  'assets/images/festival_map.jpeg',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextButton.icon(
                onPressed: () => showLocations(context),
                icon: const Icon(
                  Icons.location_on,
                  color: blue,
                ),
                label: const Text(
                  'Zoek een locatie',
                  style: TextStyle(color: blue),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Icons.newspaper, 'Home', 0),
            navItem(Icons.calendar_month, 'Programma', 1),
            navItem(Icons.music_note, 'Line up', 2),
            navItem(Icons.map_outlined, 'Map', 3),
            navItem(Icons.more_horiz, 'Meer', 4),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    final selected = index == 3;

    return InkWell(
      onTap: () => onTabSelected?.call(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 29,
            color: selected ? blue : Colors.grey,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: selected ? blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class LocationScreen extends StatelessWidget {
  final String location;

  const LocationScreen({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Navigatie'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Color(0xFF168FE0),
              size: 65,
            ),
            const SizedBox(height: 15),
            Text(
              location,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Je hebt deze locatie geselecteerd.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Terug naar de map'),
            ),
          ],
        ),
      ),
    );
  }
}
