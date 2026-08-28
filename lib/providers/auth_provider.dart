import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static const _keyLoggedIn = 'isLoggedIn';
  static const _keyName = 'userName';
  static const _keyEmail = 'userEmail';

  bool _isLoggedIn = false;
  bool _isReady = false;
  String userName = 'Ayşe Yılmaz';
  String userEmail = 'ayse.yilmaz@ogretmen.com';

  bool get isLoggedIn => _isLoggedIn;
  bool get isReady => _isReady;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_keyLoggedIn) ?? false;
    userName = prefs.getString(_keyName) ?? userName;
    userEmail = prefs.getString(_keyEmail) ?? userEmail;
    _isReady = true;
    notifyListeners();
  }

  Future<void> login({String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = true;
    if (email != null && email.trim().isNotEmpty) {
      userEmail = email.trim();
    }
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyName, userName);
    await prefs.setString(_keyEmail, userEmail);
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    await prefs.setBool(_keyLoggedIn, false);
    notifyListeners();
  }
}
