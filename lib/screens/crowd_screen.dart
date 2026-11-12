import 'package:material_ui/material_ui.dart';

class CrowdScreen extends StatefulWidget {
  const CrowdScreen({super.key});

  @override
  State<CrowdScreen> createState() => _CrowdScreenState();
}

class _CrowdScreenState extends State<CrowdScreen> {
  // Onze festivalzones van het Galactic Funkadelic terrein
  final List<FestivalZone> zones = [
    FestivalZone(name: 'Entree & Uitgang', currentPeople: 450, capacity: 1200),
    FestivalZone(name: 'Food Truck Alley', currentPeople: 850, capacity: 1000),
    FestivalZone(name: 'Chill Space Disco', currentPeople: 200, capacity: 600),
    FestivalZone(name: 'Cosmic Stage 2', currentPeople: 1400, capacity: 1500),
    FestivalZone(name: 'Neon Stage 3', currentPeople: 900, capacity: 1200),
    FestivalZone(name: 'Main Stage (Galactic)', currentPeople: 4200, capacity: 5000),
    FestivalZone(name: 'Toiletten & Bars', currentPeople: 150, capacity: 400),
  ];

  // Simuleer verandering in drukte voor de presentatie
  void _simulateCrowd() {
    setState(() {
      for (var zone in zones) {
        int randomChange = (DateTime.now().millisecond % 400) - 180;
        zone.currentPeople = (zone.currentPeople + randomChange).clamp(0, zone.capacity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Drukte-Indicator'),
        backgroundColor: const Color(0xFF1C1E3B),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF262954),
            child: const Row(
              children: [
                Icon(Icons.radar, color: Color(0xFFFF2A85), size: 28), // Neon roze
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Live drukte-analyse per sector. Voorkom lange rijen!',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: zones.length,
              itemBuilder: (context, index) {
                final zone = zones[index];
                return ZoneCard(zone: zone);
              },
            ),
          ),
        ],
      ),
      // Handige knop onderaan om de live simulatie te tonen aan de docenten
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: _simulateCrowd,
          icon: const Icon(Icons.bolt, color: Color(0xFFFF8800)), // Disco oranje
          label: const Text('Live Drukte'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF2A85), // Neon roze knop
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56), // Lekker groot en toegankelijk!
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class FestivalZone {
  String name;
  int currentPeople;
  int capacity;

  FestivalZone({
    required this.name,
    required this.currentPeople,
    required this.capacity,
  });

  double get percentage => (currentPeople / capacity).clamp(0.0, 1.0);

  String get statusText {
    if (percentage > 0.85) return 'BIJNA VOL';
    if (percentage > 0.60) return 'DRUK';
    return 'RUSTIG';
  }

  Color get statusColor {
    if (percentage > 0.85) return Colors.redAccent;
    if (percentage > 0.60) return const Color(0xFFFF8800); // Disco oranje
    return Colors.greenAccent;
  }
}

class ZoneCard extends StatelessWidget {
  final FestivalZone zone;

  const ZoneCard({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF1E143F), // Jullie Galactic kaart-achtergrondkleur!
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  zone.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: zone.statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: zone.statusColor),
                  ),
                  child: Text(
                    zone.statusText,
                    style: TextStyle(color: zone.statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${zone.currentPeople} bezoekers', style: const TextStyle(color: Colors.white70)),
                Text('Max: ${zone.capacity}', style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: zone.percentage,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(zone.statusColor),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}