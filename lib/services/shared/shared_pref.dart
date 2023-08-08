import 'package:get/get.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends GetxController {
  static const String _keyIp = 'IP-API';

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
