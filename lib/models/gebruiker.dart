/// Een gebruiker van de app.
/// Nu alleen fictieve accounts; later komen deze uit de backend.
class Gebruiker {
  final String id;
  final String weergavenaam; // bijvoorbeeld 'Luna Vega'
  final String gebruikersnaam; // bijvoorbeeld 'lunavega' (zonder @)

  const Gebruiker({
    required this.id,
    required this.weergavenaam,
    required this.gebruikersnaam,
  });

  /// Eerste letters van de naam, voor de avatar. 'Luna Vega' -> 'LV'
  String get initialen {
    final delen = weergavenaam.trim().split(' ');
    if (delen.length == 1) return delen.first[0].toUpperCase();
    return (delen.first[0] + delen.last[0]).toUpperCase();
  }
}