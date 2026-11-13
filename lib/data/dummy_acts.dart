import '../models/act.dart';

// Tijdelijke voorbeelddata. Later komen de acts uit Supabase.
final List<Act> dummyActs = [
  // Vrijdag 9 juli
  Act(
    id: 'act-001',
    name: 'DJ Starlight',
    stage: 'Mainstage',
    day: 'Vrijdag',
    start: DateTime(2027, 7, 9, 20, 0),
    end: DateTime(2027, 7, 9, 21, 30),
  ),
  Act(
    id: 'act-002',
    name: 'Neon Nomads',
    stage: 'Mainstage',
    day: 'Vrijdag',
    start: DateTime(2027, 7, 9, 18, 0),
    end: DateTime(2027, 7, 9, 19, 0),
  ),
  Act(
    id: 'act-003',
    name: 'The Cosmic Grooves', // overlapt met Neon Nomads
    stage: 'Galaxy Tent',
    day: 'Vrijdag',
    start: DateTime(2027, 7, 9, 18, 30),
    end: DateTime(2027, 7, 9, 19, 30),
  ),
  Act(
    id: 'act-004',
    name: 'Lunar Lights', // begint precies als The Cosmic Grooves eindigt
    stage: 'Galaxy Tent',
    day: 'Vrijdag',
    start: DateTime(2027, 7, 9, 19, 30),
    end: DateTime(2027, 7, 9, 20, 30),
  ),
  Act(
    id: 'act-005',
    name: 'Funk Orbit', // eindigt na middernacht
    stage: 'Disco Dome',
    day: 'Vrijdag',
    start: DateTime(2027, 7, 9, 23, 30),
    end: DateTime(2027, 7, 10, 1, 0),
  ),

  // Zaterdag 10 juli
  Act(
    id: 'act-006',
    name: 'Velvet Rocket',
    stage: 'Galaxy Tent',
    day: 'Zaterdag',
    start: DateTime(2027, 7, 10, 17, 0),
    end: DateTime(2027, 7, 10, 18, 0),
  ),
  Act(
    id: 'act-007',
    name: 'Purple Satellite',
    stage: 'Mainstage',
    day: 'Zaterdag',
    start: DateTime(2027, 7, 10, 21, 0),
    end: DateTime(2027, 7, 10, 22, 30),
  ),

  // Zondag 11 juli
  Act(
    id: 'act-008',
    name: 'Moonwalk Collective',
    stage: 'Disco Dome',
    day: 'Zondag',
    start: DateTime(2027, 7, 11, 16, 0),
    end: DateTime(2027, 7, 11, 17, 0),
  ),
  Act(
    id: 'act-009',
    name: 'Supernova Soul',
    stage: 'Mainstage',
    day: 'Zondag',
    start: DateTime(2027, 7, 11, 20, 0),
    end: DateTime(2027, 7, 11, 21, 30),
  ),
];