import 'package:shared_preferences/shared_preferences.dart';

/**String? userEmail = await UserPreferences.getUserEmail();
if (userEmail != null) {
  //do your code 
} */

class UserPreferences {
  static const String _emailKey = 'current_user_email';

  // Save email
  static Future<void> saveUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  // Get email
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  // Clear email
  static Future<void> clearUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
  }
}
