import 'sos_situatie.dart';

/// Een SOS-melding met zo min mogelijk gegevens.
/// Alleen de situatie; de vrijwillige locatie komt in stap 2.
/// Deze melding bestaat alleen tijdelijk in het geheugen
/// en wordt nooit opgeslagen.
class SosMelding {
  final SosSituatie situatie;

  const SosMelding({required this.situatie});
}