import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/dialog.dart';
import 'package:max_display_app/helper/formatter.dart';
import 'package:max_display_app/helper/global_variable.dart';
import 'package:max_display_app/helper/validator.dart';
import 'package:max_display_app/model/product.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:max_display_app/services/api/api_service.dart';

enum InputMode { request, confirm }

enum Filter { all, request }

class ProductController extends GetxController {
  final searchController = TextEditingController();
  final idController = TextEditingController();
  final paloController = TextEditingController();
  final nameController = TextEditingController();
  final barcodeController = TextEditingController();
  final priceController = TextEditingController();
  final rackController = TextEditingController();
  final displayController = TextEditingController();
  final reqController = TextEditingController();
  final confController = TextEditingController();
  final _products = <Product>[];
  final products = <Product>[].obs;
  Product? data;
  var inputMode = InputMode.request.obs;
  var filter = Filter.all;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var rack = "";

  ProductController(this.rack);

  submit() {
    if (data != null) {
      if (inputMode.value == InputMode.request) {
        submitRequest(data!);
      } else {
        submitConfrim(data!);
      }
    }
  }

  submitRequest(Product data) async {
    String? valid = phoneValidator(
      "Jumlah Request",
      reqController.text,
    );

    var req = int.tryParse(reqController.text) ?? 0;
    if (valid == null && req <= data.display) {
      var response = await ApiService.put(
        url + productUrl,
        data: _jsonSubmit(data.id, req, data.conf),
      );
      var success = await manageResponse(response, success: true);
      if (success) {
        Get.back();
        getData();
      }
    } else {
      if (valid != null) warningDialog(valid, () => Get.back());
      if (valid == null) {
        warningDialog(
          "Jumlah Request harus lebih kecil atau sama dengan jumlah max display",
          () => Get.back(),
        );
      }
    }
  }

  submitConfrim(Product data) async {
    String? valid = phoneValidator(
      "Jumlah Konfirmasi",
      confController.text,
    );
    var conf = int.tryParse(confController.text) ?? 0;
    var req = int.tryParse(reqController.text) ?? 0;

    if (valid == null && conf <= req) {
      var response = await ApiService.put(
        url + productUrl,
        data: _jsonSubmit(data.id, data.req, conf),
      );
      var success = await manageResponse(response, success: true);
      if (success) {
        Get.back();
        getData();
      }
    } else {
      if (valid != null) warningDialog(valid, () => Get.back());
      if (valid == null) {
        warningDialog(
          "Jumlah Konfirmasi harus lebih kecil atau sama dengan jumlah request",
          () => Get.back(),
        );
      }
    }
  }

  Object? _jsonSubmit(String id, int req, int conf) {
    return {
      "user": username,
      "idproduk": id,
      "request": req,
      "confirm": conf,
      "jenis": inputMode.value.name.toCapitalized(),
    };
  }

  changeFilter(Filter data) async {
    filter = data;
    await getData();
  }

  getData() async {
    isLoading.value = true;
    var filter = this.filter == Filter.all ? "" : "1";
    var response = await ApiService.get(
      url + productUrl,
      queryParameters: {
        "rak": rack,
        "filter": filter,
      },
    );
    isLoading.value = false;
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response);
      _products.clear();
      for (var item in data['data'] as List<dynamic>) {
        _products.add(Product.fromJson(item));
      }
      if (searchController.text != "") {
        onSearch(searchController.text);
      } else {
        products.value = _products;
      }
    }
  }

  showDetail(Product data) async {
    this.data = data;
    innitData();
    await showModalBtm();
    this.data = null;
    clear();
  }

  clear() {
    reqController.clear();
    confController.clear();
  }

  innitData() {
    idController.text = data!.id;
    paloController.text = data!.palonogram;
    nameController.text = data!.name;
    barcodeController.text = data!.barcode;
    priceController.text = moneyFormatter(data!.price);
    rackController.text = data!.rack;
    displayController.text = data!.display.toString();
    if (data!.req != 0) reqController.text = data!.req.toString();
    if (data!.req != 0) confController.text = data!.req.toString();
  }

  onSearch(String? value) {
    if (value != "" && value != null) {
      final searchProduct = _products.where((e) {
        var titleLower = e.name.toLowerCase().obs;
        final searchLower = value.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
      products.value = searchProduct;
    } else {
      products.value = _products;
    }
  }

  changeInputMode(InputMode? data) {
    if (data != null) {
      inputMode.value = data;
      if (data == InputMode.confirm) {
        reqController.text = this.data!.req.toString();
      } else {
        clear();
      }
    }
  }

  Future<bool> getBack() async {
    if (searchMode.value) {
      searchMode.value = false;
      searchController.clear();
      return false;
    }
    return true;
  }

  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
  }
}
