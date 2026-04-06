import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  // 🔹 Initialize
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception("Prefs initialization failed: $e");
    }
  }

  // 🔹 Safety getter
  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception("Prefs not initialized. Call PrefsService.init()");
    }
    return _prefs!;
  }

  // 🔹 Save User Data
  static Future<void> saveUserDetails({
    required String firstName,
    required String lastName,
    required double salary,
    required String gender,
    String? imagePath,
  }) async {
    try {
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setDouble('salary', salary);
      await prefs.setString('gender', gender);

      if (imagePath != null) {
        await prefs.setString('profileImage', imagePath);
      }
    } catch (e) {
      throw Exception("Failed to save user data: $e");
    }
  }

  // 🔹 Get Data
  static String get firstName => prefs.getString('firstName') ?? '';
  static String get lastName => prefs.getString('lastName') ?? '';
  static double get salary => prefs.getDouble('salary') ?? 0.0;
  static String get gender => prefs.getString('gender') ?? '';
  static String? get profileImage => prefs.getString('profileImage');

  // 🔹 Check if user exists
  static bool get isUserSaved => prefs.containsKey('firstName');

  // 🔹 Clear Data
  static Future<void> clear() async {
    try {
      await prefs.clear();
    } catch (e) {
      throw Exception("Failed to clear prefs: $e");
    }
  }

  // 🔹 Theme
  static Future<void> saveThemeMode(String mode) async {
    try {
      await prefs.setString('themeMode', mode);
    } catch (e) {
      throw Exception("Failed to save theme: $e");
    }
  }

  static String getThemeMode() {
    return prefs.getString('themeMode') ?? 'system';
  }
}