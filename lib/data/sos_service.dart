import '../models/sos_melding.dart';

/// Verstuurt SOS-meldingen.
/// DEMO: er wordt niets verstuurd, er is geen verbinding met hulpverleners.
/// Later vervangen we alleen deze klasse door een versie die naar de
/// backend van het festivalteam stuurt.
class SosService {
  Future<void> verstuur(SosMelding melding) async {
    // Bewust geen print/log: SOS-gegevens horen niet in logs.
    await Future.delayed(const Duration(milliseconds: 800));
  }
}