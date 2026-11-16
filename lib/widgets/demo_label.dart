import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

/// Duidelijke melding dat dit een demo is.
class DemoLabel extends StatelessWidget {
  const DemoLabel({super.key});

  static const String tekst =
      'Demo – er wordt geen echte melding verstuurd. Er is geen hulp ingeschakeld.';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: GalacticColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GalacticColors.accentNeonOrange, width: 2),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: GalacticColors.accentNeonOrange),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              tekst,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: GalacticColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}