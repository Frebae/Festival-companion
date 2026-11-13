import 'package:material_ui/material_ui.dart';
import '../data/act_repository.dart';
import '../models/act.dart';
import '../theme/app_theme.dart';
import '../widgets/act_card.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final ActRepository _repository = ActRepository();

  List<Act> _alleActs = [];
  final Set<String> _favorieten = {}; // ID's van favoriete acts
  String? _gekozenDag;
  bool _alleenFavorieten = false;
  bool _laden = true;

  @override
  void initState() {
    super.initState();
    _laadActs();
  }

  Future<void> _laadActs() async {
    final acts = await _repository.getActs();
    if (!mounted) return; // scherm is al gesloten
    setState(() {
      _alleActs = acts;
      final dagen = _dagenUit(acts);
      _gekozenDag = dagen.isNotEmpty ? dagen.first : null;
      _laden = false;
    });
  }

  /// Alle festivaldagen, op volgorde van de eerste act van die dag.
  List<String> _dagenUit(List<Act> acts) {
    final gesorteerd = [...acts]..sort((a, b) => a.start.compareTo(b.start));
    final dagen = <String>[];
    for (final act in gesorteerd) {
      if (!dagen.contains(act.day)) {
        dagen.add(act.day);
      }
    }
    return dagen;
  }

  void _toggleFavoriet(Act act) {
    setState(() {
      if (_favorieten.contains(act.id)) {
        _favorieten.remove(act.id);
      } else {
        _favorieten.add(act.id);
      }
    });
  }

  /// Alle andere favorieten die in tijd overlappen met deze act.
  /// Werkt over alle dagen en podia heen.
  List<Act> _overlappendeFavorieten(Act act) {
    if (!_favorieten.contains(act.id)) return [];
    return _alleActs
        .where((ander) =>
            ander.id != act.id &&
            _favorieten.contains(ander.id) &&
            act.overlaptMet(ander))
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));
  }

  @override
  Widget build(BuildContext context) {
    if (_laden) {
      return Scaffold(
        appBar: AppBar(title: const Text('Programma')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final dagen = _dagenUit(_alleActs);

    // Acts van de gekozen dag, op begintijd
    final actsVanDag = _alleActs
        .where((act) => act.day == _gekozenDag)
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    // Eventueel alleen de favorieten
    final zichtbareActs = _alleenFavorieten
        ? actsVanDag.where((act) => _favorieten.contains(act.id)).toList()
        : actsVanDag;

    return Scaffold(
      appBar: AppBar(title: const Text('Programma')),
      body: Column(
        children: [
          // Dag kiezen
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final dag in dagen)
                  ChoiceChip(
                    label: Text(dag),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      color: GalacticColors.textLight,
                    ),
                    selected: _gekozenDag == dag,
                    selectedColor: GalacticColors.primaryNeonPink,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _gekozenDag = dag),
                  ),
              ],
            ),
          ),

          // Filter: alleen favorieten
          SwitchListTile(
            title: const Text('Alleen mijn favorieten'),
            value: _alleenFavorieten,
            onChanged: (waarde) => setState(() => _alleenFavorieten = waarde),
          ),

          // Lijst of lege toestand
          Expanded(
            child: zichtbareActs.isEmpty
                ? _LegeToestand(
                    tekst: actsVanDag.isEmpty
                        ? 'Er staan nog geen acts op het programma voor deze dag.'
                        : 'Je hebt nog geen favorieten op ${_gekozenDag ?? 'deze dag'}.\n'
                            'Zet het filter uit en tik op de ster bij een act.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: zichtbareActs.length,
                    itemBuilder: (context, index) {
                      final act = zichtbareActs[index];
                      return ActCard(
                        act: act,
                        isFavoriet: _favorieten.contains(act.id),
                        overlappendeActs: _overlappendeFavorieten(act),
                        onFavorietTap: () => _toggleFavoriet(act),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Vriendelijke melding als er niets te tonen is.
class _LegeToestand extends StatelessWidget {
  final String tekst;

  const _LegeToestand({required this.tekst});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.event_busy,
              size: 48,
              color: GalacticColors.textMuted,
            ),
            const SizedBox(height: 12),
            Text(
              tekst,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}