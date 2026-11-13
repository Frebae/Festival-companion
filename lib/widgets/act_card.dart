import 'package:material_ui/material_ui.dart';
import '../models/act.dart';
import '../theme/app_theme.dart';

/// Kaart met de gegevens van één act.
class ActCard extends StatelessWidget {
  final Act act;
  final bool isFavoriet;
  final List<Act> overlappendeActs; // andere favorieten die tegelijk spelen
  final VoidCallback onFavorietTap;

  const ActCard({
    super.key,
    required this.act,
    required this.isFavoriet,
    required this.onFavorietTap,
    this.overlappendeActs = const [],
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Begin- en eindtijd
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      act.startTijd,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: GalacticColors.accentCyan,
                      ),
                    ),
                    Text('tot ${act.eindTijd}', style: textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(width: 16),

                // Naam en podium
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(act.name, style: textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: GalacticColors.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(act.stage, style: textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ),

                // Ster: toevoegen aan of verwijderen uit favorieten
                IconButton(
                  iconSize: 32,
                  tooltip: isFavoriet
                      ? 'Verwijder uit favorieten'
                      : 'Voeg toe aan favorieten',
                  icon: Icon(
                    isFavoriet ? Icons.star : Icons.star_border,
                    color: isFavoriet
                        ? GalacticColors.accentNeonOrange
                        : GalacticColors.textMuted,
                  ),
                  onPressed: onFavorietTap,
                ),
              ],
            ),

            // Waarschuwing als deze favoriet overlapt met andere favorieten
            if (overlappendeActs.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: GalacticColors.primaryNeonPink,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Overlapt met: ${overlappendeActs.map((a) => '${a.name} (${a.startTijd}–${a.eindTijd}, ${a.stage})').join(', ')}',
                      style: const TextStyle(
                        color: GalacticColors.primaryNeonPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}