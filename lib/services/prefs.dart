import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(userId);
    await prefs.setString("userId", userId);
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    return userId;
  }

  deleteUsereId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");
  }
}
