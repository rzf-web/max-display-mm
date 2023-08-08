import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:max_display_app/model/rack.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:max_display_app/services/api/api_service.dart';
import 'package:max_display_app/view/login/login.controller.dart';
import 'package:max_display_app/view/login/login.page.dart';
import 'package:max_display_app/view/product_list/product.controller.dart';
import 'package:max_display_app/view/product_list/product.page.dart';

class RackController extends GetxController {
  final searchController = TextEditingController();
  final _rackList = <Rack>[];
  var rackList = <Rack>[].obs;
  var searchMode = false.obs;
  var isLoading = false.obs;

  getData() async {
    isLoading.value = true;
    var response = await ApiService.get(url + rack);
    isLoading.value = false;
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response);
      _rackList.clear();
      for (var item in data['data'] as List<dynamic>) {
        _rackList.add(Rack.fromJson(item));
      }
      rackList.value = _rackList;
    }
  }

  onSearch(String? value) {
    if (value != "" && value != null) {
      final searchRack = _rackList.where((e) {
        var titleLower = e.name.toLowerCase().obs;
        final searchLower = value.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
      rackList.value = searchRack;
    } else {
      rackList.value = _rackList;
    }
  }

  productPage(String rack) {
    Get.to(
      const ProductPage(),
      binding: BindingsBuilder.put(() => ProductController(rack)),
    );
  }

  logout() {
    Get.offAll(
      const LoginPage(),
      binding: BindingsBuilder.put(() => LoginController()),
    );
  }

  Future<bool> getBack() async {
    if (searchMode.value) {
      searchMode.value = false;
      return false;
    }
    return true;
  }

  @override
  Future<void> onInit() async {
    await getData();
    Get.delete<LoginController>();
    super.onInit();
  }
}
