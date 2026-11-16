import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';
import '../widgets/demo_label.dart';

/// Eindscherm na het afronden van een demomelding.
class SosBevestigingScreen extends StatelessWidget {
  const SosBevestigingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demomelding afgerond')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 64,
            color: GalacticColors.accentCyan,
          ),
          const SizedBox(height: 16),
          Text(
            'Je demomelding is afgerond. In een aangesloten versie zou deze '
            'naar het festivalteam worden verstuurd.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          const DemoLabel(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text('Terug naar de app'),
          ),
        ],
      ),
    );
  }
}