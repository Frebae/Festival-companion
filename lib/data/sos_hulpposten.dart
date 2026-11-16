/// Een hulppost op het festivalterrein.
class HulpPost {
  final String naam;
  final String plek;
  final String team;

  const HulpPost({
    required this.naam,
    required this.plek,
    required this.team,
  });
}

// VOORBEELDDATA – geen echte festivalgegevens.
// Lokaal in de app gebundeld, zodat de informatie direct beschikbaar is.
const List<HulpPost> voorbeeldHulpposten = [
  HulpPost(
    naam: 'EHBO-post Noord',
    plek: 'Voorbeeldlocatie: naast de Mainstage',
    team: 'EHBO',
  ),
  HulpPost(
    naam: 'EHBO-post Zuid',
    plek: 'Voorbeeldlocatie: bij de foodcourt',
    team: 'EHBO',
  ),
  HulpPost(
    naam: 'Awarenessteam',
    plek: 'Voorbeeldlocatie: stand naast het infopunt',
    team: 'Awarenessteam',
  ),
  HulpPost(
    naam: 'Infopunt',
    plek: 'Voorbeeldlocatie: bij de hoofdingang',
    team: 'Infopunt',
  ),
  HulpPost(
    naam: 'Beveiligingspost',
    plek: 'Voorbeeldlocatie: bij de hoofdingang',
    team: 'Beveiliging',
  ),
];

/// Alle hulpposten van de opgegeven teams.
List<HulpPost> hulppostenVoor(List<String> teams) {
  return voorbeeldHulpposten
      .where((post) => teams.contains(post.team))
      .toList();
}