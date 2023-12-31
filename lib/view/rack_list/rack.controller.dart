import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:max_display_app/model/rack.dart';
import 'package:max_display_app/routes/app_pages.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:max_display_app/services/api/api_service.dart';
import 'package:max_display_app/services/shared/shared_pref.dart';
import 'package:max_display_app/view/login/login.controller.dart';

class RackController extends GetxController {
  final searchController = TextEditingController();
  final _rackList = <Rack>[];
  var rackList = <Rack>[].obs;
  var searchMode = false.obs;
  var isLoading = false.obs;

  getData() async {
    isLoading.value = true;
    var response = await ApiService.get(url + rackUrl);
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

  productPage(String rack) async {
    await Get.toNamed(Routes.product, arguments: rack);
    await getData();
  }

  logout() {
    Get.offAllNamed(Routes.login);
    SharedPref.saveUserLogin(false);
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
