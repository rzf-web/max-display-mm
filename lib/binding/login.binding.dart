import 'package:get/get.dart';
import 'package:max_display_app/view/login/login.controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
