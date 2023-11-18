import 'package:get/get.dart';
import 'package:max_display_app/view/product_list/product.controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
