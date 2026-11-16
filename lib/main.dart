import 'package:material_ui/material_ui.dart';
import 'theme/app_theme.dart';
import 'theme/sos_kleuren.dart';
import 'screens/home_screen.dart';
import 'screens/crowd_screen.dart';
import 'screens/map_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/sos_keuze_screen.dart';

void main() {
  runApp(const FestivalBuddyApp());
}

class FestivalBuddyApp extends StatelessWidget {
  const FestivalBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Buddy - Galactic Funkadelic',
      debugShowCheckedModeBanner: false,
      theme: galacticFunkadelicTheme, // Jullie eigen Galactic thema!
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // De SOS-knop is de laatste knop in de balk, maar geen gewoon tabblad.
  static const int _sosIndex = 4;

  // Al jullie gemaakte schermen op een rij achter de knoppen onderaan
  final List<Widget> _screens = [
    const HomeScreen(), // Index 0 (Home)
    const TimetableScreen(), // Index 1 (Programma)
    const CrowdScreen(), // Index 2 (Drukte / Crowd)
    const MapScreen(), // Index 3 (Kaart)
  ];

  void _onTap(int index) {
    if (index == _sosIndex) {
      // SOS opent een apart scherm bovenop de app.
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SosKeuzeScreen()),
      );
      return;
    }
    setState(() {
      _currentIndex = index; // Schakel naar het scherm waar je op tikt
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: GalacticColors.surfaceCard, // Past bij jullie thema!
        selectedItemColor: GalacticColors.primaryNeonPink, // Neon roze voor actieve tab
        unselectedItemColor: GalacticColors.textMuted,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Programma',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Drukte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Kaart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos, color: SosKleuren.roodLicht, size: 30),
            label: 'SOS',
          ),
        ],
      ),
    );
  }
}