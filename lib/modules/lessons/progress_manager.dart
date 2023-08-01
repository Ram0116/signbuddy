import 'package:shared_preferences/shared_preferences.dart';


const String overallProgressKey = 'overall_progress';


class ProgressManager {
  SharedPreferences? _prefs;

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get the overall progress value
  int getOverallProgress() {
    return _prefs?.getInt(overallProgressKey) ?? 0;
  }

  // Save the overall progress value
  Future<void> saveOverallProgress(int progress) async {
    await _prefs?.setInt(overallProgressKey, progress);
  }

  void updateOverallProgress(int currentPageProgress) {}

  // Add any other progress-related methods here, if needed.
}
