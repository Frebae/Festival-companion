import 'package:material_ui/material_ui.dart';
import '../data/dummy_gebruikers.dart';
import '../models/gebruiker.dart';
import '../theme/app_theme.dart';
import '../widgets/gebruiker_kaart.dart';

/// Scherm 'Vrienden': zoek gebruikers en bekijk je vrienden.
/// DEMO: alleen layout met fictieve accounts. Er wordt niets verstuurd
/// of opgeslagen; na het sluiten van de app is alles weer zoals eerst.
class VriendenScreen extends StatefulWidget {
  const VriendenScreen({super.key});

  @override
  State<VriendenScreen> createState() => _VriendenScreenState();
}

class _VriendenScreenState extends State<VriendenScreen> {
  final TextEditingController _zoekVeld = TextEditingController();
  String _zoekterm = '';

  // Aan wie je (in deze demo) een verzoek hebt gestuurd.
  final Set<String> _verzoekVerstuurd = {};

  @override
  void dispose() {
    _zoekVeld.dispose();
    super.dispose();
  }

  bool _isVriend(Gebruiker g) => dummyVriendIds.contains(g.id);

  List<Gebruiker> get _vrienden =>
      dummyGebruikers.where(_isVriend).toList();

  /// Filtert de dummyaccounts op gebruikersnaam (en weergavenaam).
  /// Hoofdletters en een @ aan het begin maken niet uit.
  List<Gebruiker> get _zoekresultaten {
    final term = _zoekterm.trim().toLowerCase().replaceFirst('@', '');
    if (term.isEmpty) return [];
    return dummyGebruikers
        .where((g) =>
            g.gebruikersnaam.toLowerCase().contains(term) ||
            g.weergavenaam.toLowerCase().contains(term))
        .toList();
  }

  /// De knop of het label naast een zoekresultaat.
  Widget _actieVoor(Gebruiker g) {
    if (_isVriend(g)) {
      return const _Label(tekst: 'Vriend', icoon: Icons.check_circle);
    }
    if (_verzoekVerstuurd.contains(g.id)) {
      return const _Label(tekst: 'Verzoek verstuurd', icoon: Icons.schedule_send);
    }
    return FilledButton.icon(
      onPressed: () => setState(() => _verzoekVerstuurd.add(g.id)),
      style: FilledButton.styleFrom(
        backgroundColor: GalacticColors.primaryNeonPink,
        foregroundColor: GalacticColors.textLight,
        minimumSize: const Size(48, 48),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.person_add),
      label: const Text('Toevoegen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tekst = Theme.of(context).textTheme;
    final isZoeken = _zoekterm.trim().isNotEmpty;
    final resultaten = _zoekresultaten;

    return Scaffold(
      appBar: AppBar(title: const Text('Vrienden')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Zoekveld ---
          TextField(
            controller: _zoekVeld,
            onChanged: (waarde) => setState(() => _zoekterm = waarde),
            style: const TextStyle(fontSize: 17, color: GalacticColors.textLight),
            decoration: InputDecoration(
              hintText: 'Zoek op gebruikersnaam',
              prefixIcon: const Icon(Icons.search),
              // Kruisje om het zoekveld leeg te maken.
              suffixIcon: isZoeken
                  ? IconButton(
                      tooltip: 'Zoekveld leegmaken',
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _zoekVeld.clear();
                        setState(() => _zoekterm = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: GalacticColors.surfaceCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: GalacticColors.accentCyan, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // --- Zoekresultaten (alleen tijdens het zoeken) ---
          if (isZoeken) ...[
            Text('Zoekresultaten', style: tekst.titleLarge),
            const SizedBox(height: 12),
            if (resultaten.isEmpty)
              const _GeenResultaten()
            else
              for (final g in resultaten)
                GebruikerKaart(gebruiker: g, actie: _actieVoor(g)),
            const SizedBox(height: 24),
          ],

          // --- Overzicht van je vrienden ---
          Text('Mijn vrienden (${_vrienden.length})', style: tekst.titleLarge),
          const SizedBox(height: 12),
          for (final g in _vrienden) GebruikerKaart(gebruiker: g),
        ],
      ),
    );
  }
}

/// Klein label in plaats van een knop, bijvoorbeeld 'Verzoek verstuurd'.
class _Label extends StatelessWidget {
  final String tekst;
  final IconData icoon;

  const _Label({required this.tekst, required this.icoon});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: GalacticColors.accentCyan, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icoon, size: 20, color: GalacticColors.accentCyan),
          const SizedBox(width: 6),
          // Flexible: op een heel smal scherm wordt de tekst afgekapt
          // in plaats van buiten de kaart te lopen.
          Flexible(
            child: Text(
              tekst,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: GalacticColors.accentCyan,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Melding als niemand aan de zoekopdracht voldoet.
class _GeenResultaten extends StatelessWidget {
  const _GeenResultaten();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GalacticColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GalacticColors.accentNeonOrange, width: 2),
      ),
      child: const Column(
        children: [
          Icon(Icons.person_search, size: 40, color: GalacticColors.accentNeonOrange),
          SizedBox(height: 8),
          Text(
            'Geen gebruikers gevonden',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: GalacticColors.textLight,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Controleer de spelling of probeer een andere gebruikersnaam.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: GalacticColors.textMuted),
          ),
        ],
      ),
    );
  }
}