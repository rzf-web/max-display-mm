import 'package:get/get.dart';
import 'package:max_display_app/view/rack_list/rack.controller.dart';

class RackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RackController>(() => RackController());
  }
}
