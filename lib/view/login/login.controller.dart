import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/dialog.dart';

class LoginController extends GetxController {
  Timer? debouncer;
  final ipController = TextEditingController();
  final usernameController = TextEditingController();
  final pwController = TextEditingController();
  var saveIp = false.obs;
  var isConnecting = false.obs;
  var connect = false.obs;
  var ipFormKey = GlobalKey<FormFieldState>();

  login() {
    connect.value = false;
  }

  onChanged(String value) async {
    if (ipFormKey.currentState!.validate()) {
      return debounce(() async {
        //TODO:test connection
        isConnecting.value = true;
        await Future.delayed(const Duration(milliseconds: 2000));
        isConnecting.value = false;
        ipController.clear();
        connect.value = true;
        showSnackbar("Terhubung");
      });
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
}
