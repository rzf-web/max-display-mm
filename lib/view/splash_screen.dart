import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/const.dart';
import 'package:max_display_app/helper/theme.dart';
import 'package:max_display_app/routes/app_pages.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:max_display_app/services/api/api_service.dart';
import 'package:max_display_app/services/shared/shared_pref.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var loadingMsg = 'Tunggu Sebentar...'.obs;

  getIp() async {
    await SharedPref.loadIp();
  }

  testConnection() async {
    await getIp();
    url = "http://$ip:$port";
    var response = await ApiService.get(url + testingUrl, secTimeOut: 10);
    var success = await manageResponse(response, error: false);
    if (success) {
      await Future.delayed(const Duration(milliseconds: 1000));
      loadingMsg.value = 'Berhasil login';
      Get.offAllNamed(Routes.rack);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  auth() async {
    var isLogin = await SharedPref.loadUserLogin();
    if (isLogin) {
      testConnection();
      await Future.delayed(const Duration(milliseconds: 3000));
      loadingMsg.value = 'Silahkan cek aplikasi desktop...';
      await Future.delayed(const Duration(milliseconds: 3000));
      loadingMsg.value = 'Aplikasi desktop\ntidak merespon...';
      await Future.delayed(const Duration(milliseconds: 2000));
      loadingMsg.value = 'Tidak dapat menerima respon';
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void initState() {
    auth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  appsLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
            Obx(
              () => Text(
                loadingMsg.value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
