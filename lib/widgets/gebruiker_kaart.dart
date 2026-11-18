import 'package:material_ui/material_ui.dart';
import '../models/gebruiker.dart';
import '../theme/app_theme.dart';

/// Kaart met avatar, weergavenaam en gebruikersnaam van één gebruiker.
/// Rechts (of op een smal scherm eronder) staat een optionele knop of label.
class GebruikerKaart extends StatelessWidget {
  final Gebruiker gebruiker;
  final Widget? actie; // bijvoorbeeld de knop 'Toevoegen'

  const GebruikerKaart({super.key, required this.gebruiker, this.actie});

  // Afwisselende neonkleuren voor de avatars.
  static const List<Color> _avatarKleuren = [
    GalacticColors.primaryNeonPink,
    GalacticColors.accentCyan,
    GalacticColors.accentNeonOrange,
  ];

  @override
  Widget build(BuildContext context) {
    final kleur = _avatarKleuren[gebruiker.id.codeUnits.last % _avatarKleuren.length];

    final avatar = CircleAvatar(
      radius: 26,
      backgroundColor: kleur,
      child: Text(
        gebruiker.initialen,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: GalacticColors.backgroundDark,
        ),
      ),
    );

    final namen = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gebruiker.weergavenaam,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: GalacticColors.textLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '@${gebruiker.gebruikersnaam}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, color: GalacticColors.textMuted),
        ),
      ],
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        // LayoutBuilder vertelt hoeveel ruimte de kaart heeft.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmal = constraints.maxWidth < 340;
            final regel = Row(
              children: [
                avatar,
                const SizedBox(width: 12),
                Expanded(child: namen),
                if (actie != null && !isSmal) ...[
                  const SizedBox(width: 8),
                  actie!,
                ],
              ],
            );

            // Smal scherm: de knop onder de naam, over de volle breedte.
            if (actie != null && isSmal) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [regel, const SizedBox(height: 12), actie!],
              );
            }
            return regel;
          },
        ),
      ),
    );
  }
}