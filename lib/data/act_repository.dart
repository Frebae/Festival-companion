import '../models/act.dart';
import 'dummy_acts.dart';

/// Haalt de acts op.
/// Nu komen ze uit de dummydata. Later passen we alleen deze klasse aan
/// om ze uit Supabase te halen; het scherm hoeft dan niet te veranderen.
class ActRepository {
  Future<List<Act>> getActs() async {
    return dummyActs;
  }
}