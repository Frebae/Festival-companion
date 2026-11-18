import '../models/gebruiker.dart';

// DEMO: fictieve accounts om de layout te laten zien.
// Later komen gebruikers en vrienden uit de backend.
const List<Gebruiker> dummyGebruikers = [
  Gebruiker(id: 'g-01', weergavenaam: 'Luana Vega', gebruikersnaam: 'luanavega'),
  Gebruiker(id: 'g-02', weergavenaam: 'Ties Orbit', gebruikersnaam: 'tiesorbit'),
  Gebruiker(id: 'g-03', weergavenaam: 'Disco Freya', gebruikersnaam: 'discofreya'),
  Gebruiker(id: 'g-04', weergavenaam: 'Aram Groove', gebruikersnaam: 'aramgroove'),
  Gebruiker(id: 'g-05', weergavenaam: 'Janna Jansen', gebruikersnaam: 'jannajansen'),
  Gebruiker(id: 'g-06', weergavenaam: 'Lesley Leeuw', gebruikersnaam: 'lesleyleeuw'),
  Gebruiker(id: 'g-07', weergavenaam: 'Issraa Doekje', gebruikersnaam: 'issraadoekje'),
  Gebruiker(id: 'g-08', weergavenaam: 'Opa Gangnamstyle', gebruikersnaam: 'OpaGangnamstyle'),
];

// DEMO: met deze accounts ben je al bevriend.
const Set<String> dummyVriendIds = {'g-01', 'g-03', 'g-05'};