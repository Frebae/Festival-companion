import 'package:material_ui/material_ui.dart';

/// De vier situaties waarvoor iemand hulp kan zoeken op het festivalterrein.
/// Alle teksten staan hier, zodat ze makkelijk aan te passen zijn.
enum SosSituatie {
  onwel(
    titel: 'Iemand is onwel of gewond',
    korteTitel: 'Onwel of gewond',
    icoon: Icons.medical_services,
    stappen: [
      'Blijf bij de persoon en blijf rustig.',
      'Is de persoon niet aanspreekbaar of ademt hij niet normaal? Waarschuw direct een medewerker of de EHBO.',
      'Vraag mensen in de buurt om ruimte te maken en een medewerker te roepen.',
      'Laat iemand naar een EHBO-post gaan als jij bij de persoon blijft.',
    ],
    hulpTeams: ['EHBO'],
    isGevoelig: false,
  ),
  onveilig(
    titel: 'Ik voel me onveilig / grensoverschrijdend gedrag',
    korteTitel: 'Je voelt je onveilig',
    icoon: Icons.shield,
    stappen: [
      'Wat er ook is gebeurd: het is niet jouw schuld.',
      'Ga, als dat kan, naar een plek waar je je veiliger voelt, bijvoorbeeld bij vrienden of een medewerker.',
      'Je hoeft niets uit te leggen of te bewijzen om hulp te krijgen.',
      'Het awarenessteam luistert zonder te oordelen en kijkt samen met jou wat je nodig hebt.',
    ],
    hulpTeams: ['Awarenessteam', 'Beveiliging'],
    isGevoelig: true,
  ),
  kwijt(
    titel: 'Ik ben iemand uit mijn groep kwijt',
    korteTitel: 'Iemand kwijt',
    icoon: Icons.group_off,
    stappen: [
      'Probeer de persoon te bellen of een bericht te sturen.',
      'Ga naar jullie afgesproken ontmoetingsplek, als jullie die hebben.',
      'Ga naar het infopunt: daar kunnen medewerkers helpen zoeken.',
      'Gaat het om een kind of iemand die hulp nodig heeft? Waarschuw direct een medewerker.',
    ],
    hulpTeams: ['Infopunt'],
    isGevoelig: false,
  ),
  anders(
    titel: 'Andere noodsituatie',
    korteTitel: 'Andere noodsituatie',
    icoon: Icons.warning_amber,
    stappen: [
      'Breng jezelf eerst in veiligheid.',
      'Volg de aanwijzingen van medewerkers en beveiliging op.',
      'Waarschuw een medewerker of de beveiliging.',
    ],
    hulpTeams: ['Beveiliging', 'EHBO'],
    isGevoelig: false,
  ),
  ;

  const SosSituatie({
    required this.titel,
    required this.korteTitel,
    required this.icoon,
    required this.stappen,
    required this.hulpTeams,
    required this.isGevoelig,
  });

  final String titel;
  final String korteTitel; // voor de titelbalk
  final IconData icoon;
  final List<String> stappen; // wat kun je nu doen
  final List<String> hulpTeams; // welke hulpposten passen bij deze situatie
  final bool isGevoelig; // extra keuzes en rustige teksten
}