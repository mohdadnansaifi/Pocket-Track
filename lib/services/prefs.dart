import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static late SharedPreferences _prefs;

  // 🔹 Initialize (call once in main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 🔹 Save User Data
  static Future<void> saveUserDetails({
    required String firstName,
    required String lastName,
    required double salary,
    required String gender,
    String? imagePath,
  }) async {
    await _prefs.setString('firstName', firstName);
    await _prefs.setString('lastName', lastName);
    await _prefs.setDouble('salary', salary);
    await _prefs.setString('gender', gender);

    if (imagePath != null) {
      await _prefs.setString('profileImage', imagePath);
    }
  }

  // 🔹 Get Data
  static String get firstName => _prefs.getString('firstName') ?? '';
  static String get lastName => _prefs.getString('lastName') ?? '';
  static double get salary => _prefs.getDouble('salary') ?? 0.0;
  static String get gender => _prefs.getString('gender') ?? '';
  static String? get profileImage => _prefs.getString('profileImage');

  // 🔹 Check if user exists
  static bool get isUserSaved => _prefs.containsKey('firstName');

  // 🔹 Clear Data (logout)
  static Future<void> clear() async {
    await _prefs.clear();
  }

  static Future<void> saveThemeMode(String mode) async {
    await _prefs.setString('themeMode', mode);
  }

  static String getThemeMode() {
    return _prefs.getString('themeMode') ?? 'system';
  }
}