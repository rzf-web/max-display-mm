import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/dialog.dart';
import 'package:max_display_app/helper/global_variable.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:max_display_app/services/api/api_service.dart';
import 'package:max_display_app/services/shared/shared_pref.dart';
import 'package:max_display_app/view/rack_list/rack.controller.dart';
import 'package:max_display_app/view/rack_list/rack.page.dart';

class LoginController extends GetxController {
  Timer? debouncer;
  final ipController = TextEditingController();
  final usernameController = TextEditingController();
  final pwController = TextEditingController();
  var isConnecting = false.obs;
  var btnLoading = false.obs;
  var connect = false.obs;
  var ipFormKey = GlobalKey<FormFieldState>();
  var formKey = GlobalKey<FormState>();

  login() async {
    if (!connect.value) {
      await testConnection();
    }
    if (formKey.currentState!.validate()) {
      btnLoading.value = true;
      var response = await ApiService.post(
        url + user,
        data: _jsonLogin(),
      );
      btnLoading.value = false;
      var success = await manageResponse(response);
      if (success) {
        await SharedPref.saveIp();
        username = usernameController.text;
        Get.offAll(
          const RackPage(),
          binding: BindingsBuilder.put(() => RackController()),
        );
      }
    }
    Get.offAll(
      const RackPage(),
      binding: BindingsBuilder.put(() => RackController()),
    );
  }

  testConnection() async {
    url = "";
    ip = ipController.text;
    url = "http://$ip:$port";
    isConnecting.value = true;
    var response = await ApiService.get(url + testing);
    isConnecting.value = false;
    var success = await manageResponse(response);
    if (success) {
      ipController.clear();
      showSnackbar("Terhubung");
      connect.value = true;
    }
  }

  setIp() {
    if (ip != "") {
      ipController.text = ip;
      testConnection();
    }
  }

  onChanged(String value) async {
    if (ipFormKey.currentState!.validate()) {
      return debounce(() async => await testConnection());
    }
  }

  debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Object? _jsonLogin() {
    return {
      "user": usernameController.text,
      "pass": pwController.text,
    };
  }

  @override
  Future<void> onInit() async {
    await SharedPref.loadIp();
    await setIp();
    super.onInit();
  }
}
