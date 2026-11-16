import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

/// Discrete knop: gaat direct terug naar de gewone app.
/// Verstuurt niets. Wist geen browsergeschiedenis of andere sporen.
class SnelSluitenKnop extends StatelessWidget {
  const SnelSluitenKnop({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // Sluit alle SOS-schermen en ga terug naar het hoofdscherm.
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      icon: const Icon(Icons.close, color: GalacticColors.textLight),
      label: const Text(
        'Sluiten',
        style: TextStyle(color: GalacticColors.textLight, fontSize: 16),
      ),
    );
  }
}