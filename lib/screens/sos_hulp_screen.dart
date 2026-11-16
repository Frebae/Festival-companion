import 'package:material_ui/material_ui.dart';
import '../data/sos_hulpposten.dart';
import '../data/sos_service.dart';
import '../models/sos_melding.dart';
import '../models/sos_situatie.dart';
import '../theme/app_theme.dart';
import '../widgets/demo_label.dart';
import '../widgets/snel_sluiten_knop.dart';
import 'sos_bevestiging_screen.dart';

/// Hulpscherm voor één situatie.
class SosHulpScreen extends StatefulWidget {
  final SosSituatie situatie;

  const SosHulpScreen({super.key, required this.situatie});

  @override
  State<SosHulpScreen> createState() => _SosHulpScreenState();
}

class _SosHulpScreenState extends State<SosHulpScreen> {
  final SosService _service = SosService();

  SosMelding? _melding; // alleen tijdelijk in het geheugen
  bool _bezig = false; // voorkomt dubbele klikken
  bool _toonRustTekst = false; // bij "alleen informatie bekijken"

  @override
  void dispose() {
    _melding = null; // tijdelijke gegevens wissen bij verlaten van het scherm
    super.dispose();
  }

  /// Bevestigen en daarna een demomelding simuleren.
  Future<void> _maakDemomelding() async {
    if (_bezig) return; // al bezig: tweede klik negeren
    setState(() => _bezig = true);

    final bevestigd = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demomelding maken?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DemoLabel(),
            const SizedBox(height: 12),
            Text('Situatie: ${widget.situatie.titel}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuleren'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Ja, maak demomelding'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (bevestigd != true) {
      // Geannuleerd: niets versturen, niets bewaren.
      setState(() {
        _melding = null;
        _bezig = false;
      });
      return;
    }

    _melding = SosMelding(situatie: widget.situatie);
    await _service.verstuur(_melding!);
    _melding = null; // direct weer wissen

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SosBevestigingScreen()),
    );
  }

  void _toonAwarenessteam() {
    final posten = hulppostenVoor(['Awarenessteam']);
    showModalBottomSheet(
      context: context,
      backgroundColor: GalacticColors.surfaceCard,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Awarenessteam',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              'Het awarenessteam is er voor iedereen die zich niet prettig of '
              'onveilig voelt. Je hoeft niets uit te leggen. Je kunt er ook '
              'gewoon even rustig zitten.',
            ),
            const SizedBox(height: 12),
            for (final post in posten) _HulpPostRegel(post: post),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final situatie = widget.situatie;
    final posten = hulppostenVoor(situatie.hulpTeams);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(situatie.korteTitel),
        actions: const [SnelSluitenKnop()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Wat kun je nu doen?
          Text('Wat kun je nu doen?', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          for (var i = 0; i < situatie.stappen.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}.',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: GalacticColors.accentCyan,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(situatie.stappen[i], style: textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // Hulpposten
          Text('Hulpposten', style: textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Voorbeeldlocaties – geen echte festivalgegevens. '
            'Medewerkers op het terrein kunnen je ook altijd helpen.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          for (final post in posten) _HulpPostRegel(post: post),
          const SizedBox(height: 24),

          // Extra keuzes bij gevoelige situaties
          if (situatie.isGevoelig) ...[
            Text('Jij bepaalt wat je doet', style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Je hoeft niets uit te leggen. Kies wat goed voelt.',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: _keuzeStijl,
              onPressed: () => setState(() => _toonRustTekst = true),
              icon: const Icon(Icons.menu_book),
              label: const Text('Alleen informatie bekijken'),
            ),
            if (_toonRustTekst)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Neem rustig de tijd om alles te lezen. Er wordt niets verstuurd.',
                  style: textTheme.bodyLarge,
                ),
              ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              style: _keuzeStijl,
              onPressed: _toonAwarenessteam,
              icon: const Icon(Icons.support_agent),
              label: const Text('Ondersteuning van het awarenessteam zoeken'),
            ),
            const SizedBox(height: 16),
          ],

          // Demomelding
          const DemoLabel(),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _bezig ? null : _maakDemomelding,
            icon: _bezig
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.campaign),
            label: Text(
              situatie.isGevoelig
                  ? 'Een demomelding maken'
                  : 'Waarschuw het festivalteam',
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static final ButtonStyle _keuzeStijl = OutlinedButton.styleFrom(
    minimumSize: const Size(double.infinity, 56),
    foregroundColor: GalacticColors.textLight,
    side: const BorderSide(color: GalacticColors.textMuted),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    alignment: Alignment.centerLeft,
  );
}

/// Eén regel met een hulppost.
class _HulpPostRegel extends StatelessWidget {
  final HulpPost post;

  const _HulpPostRegel({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: GalacticColors.accentCyan),
        title: Text(post.naam),
        subtitle: Text(post.plek),
      ),
    );
  }
}