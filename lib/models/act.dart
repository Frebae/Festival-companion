/// Eén optreden op het festival.
class Act {
  final String id; // stabiel en uniek, wordt ook gebruikt om favorieten te bewaren
  final String name;
  final String stage;
  final String day; // festivaldag, bijvoorbeeld 'Vrijdag'
  final DateTime start; // volledige datum + tijd
  final DateTime end; // volledige datum + tijd (kan na middernacht vallen)

  const Act({
    required this.id,
    required this.name,
    required this.stage,
    required this.day,
    required this.start,
    required this.end,
  });

  String get startTijd => _formatTijd(start);
  String get eindTijd => _formatTijd(end);

  /// Twee acts overlappen als deze act begint voordat de andere eindigt
  /// én eindigt nadat de andere begint.
  /// Direct aansluitend (eind = begin) telt dus niet als overlap.
  bool overlaptMet(Act ander) {
    return start.isBefore(ander.end) && end.isAfter(ander.start);
  }

  static String _formatTijd(DateTime tijd) {
    final uur = tijd.hour.toString().padLeft(2, '0');
    final minuut = tijd.minute.toString().padLeft(2, '0');
    return '$uur:$minuut';
  }
}