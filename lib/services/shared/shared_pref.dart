import 'package:get/get.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends GetxController {
  static const String _keyIp = 'IP-API';
  static const String _keyUserLogin = 'USER-LOGIN';

  static Future<bool> loadUserLogin() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_keyUserLogin) ?? false;
  }

  static saveUserLogin(bool saveUserLogin) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool(_keyUserLogin, saveUserLogin);
  }

  static loadIp() async {
    final sp = await SharedPreferences.getInstance();
    ip = sp.getString(_keyIp) ?? "";
  }

  static saveIp() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_keyIp, ip);
  }

  static removeIp() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_keyIp, "");
  }
}
