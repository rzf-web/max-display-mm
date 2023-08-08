import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:max_display_app/json_dummy.dart';
import 'package:max_display_app/model/rack.dart';
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
    _rackList.clear();
    for (var item in jsonRacks) {
      _rackList.add(Rack.fromJson(item));
    }
    rackList.value = _rackList;
    await Future.delayed(const Duration(milliseconds: 100));
    isLoading.value = false;
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

  productPage() {
    Get.to(
      const ProductPage(),
      binding: BindingsBuilder.put(() => ProductController()),
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
  void onInit() {
    getData();
    super.onInit();
  }
}
