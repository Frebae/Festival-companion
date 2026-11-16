import 'package:material_ui/material_ui.dart';
import '../models/sos_situatie.dart';
import '../theme/app_theme.dart';
import '../widgets/snel_sluiten_knop.dart';
import 'sos_hulp_screen.dart';

/// Eerste SOS-scherm: kies wat er aan de hand is.
class SosKeuzeScreen extends StatelessWidget {
  const SosKeuzeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS – hulp op het terrein'),
        actions: const [SnelSluitenKnop()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Wat is er aan de hand?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Kies wat het beste past. Je krijgt informatie en hulpposten van het festivalteam.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          for (final situatie in SosSituatie.values)
            _SituatieKnop(
              situatie: situatie,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SosHulpScreen(situatie: situatie),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

/// Grote, goed te raken knop voor één situatie.
class _SituatieKnop extends StatelessWidget {
  final SosSituatie situatie;
  final VoidCallback onTap;

  const _SituatieKnop({required this.situatie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Icon(situatie.icoon, size: 36, color: GalacticColors.accentCyan),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  situatie.titel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: GalacticColors.textLight,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: GalacticColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}