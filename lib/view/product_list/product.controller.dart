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
  final dataArguments = Get.arguments;
  final searchController = TextEditingController();
  final idController = TextEditingController();
  final paloController = TextEditingController();
  final nameController = TextEditingController();
  final barcodeController = TextEditingController();
  final priceController = TextEditingController();
  final rackController = TextEditingController();
  final displayController = TextEditingController();
  final stockController = TextEditingController();
  final reqController = TextEditingController();
  final confController = TextEditingController();
  final _products = <Product>[];
  final products = <Product>[].obs;
  Product? data;
  var inputMode = InputMode.confirm.obs;
  var filter = Filter.request;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var rack = "";

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
    String? valid = doubleIntValidator(
      "Jumlah Request",
      reqController.text,
    );

    if (valid == null) {
      var response = await ApiService.put(
        url + productUrl,
        data: _jsonSubmit(data.id, reqController.text, data.conf),
      );
      var success = await manageResponse(response, success: true);
      if (success) {
        Get.back();
        getData();
        inputMode.value = InputMode.confirm;
      }
    } else {
      warningDialog(valid, () => Get.back());
      warningDialog(
        "Jumlah Request harus lebih kecil atau sama dengan jumlah max display",
        () => Get.back(),
      );
    }
  }

  submitConfrim(Product data) async {
    var confStr = confController.text.replaceAll(',', '.');
    var reqStr = reqController.text.replaceAll(',', '.');
    var conf = double.tryParse(confStr) ?? 0;
    var req = double.tryParse(reqStr) ?? 0.0;
    String? valid = doubleIntValidator("Jumlah Konfirmasi", confStr);

    if (valid == null && conf <= req) {
      var response = await ApiService.put(
        url + productUrl,
        data: _jsonSubmit(data.id, data.req, confController.text),
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

  Object? _jsonSubmit(String id, String req, String conf) {
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
    displayController.text = data!.display;
    stockController.text = doubleFormatter(data!.stock);
    if (data!.req != "0") reqController.text = data!.req;
    if (data!.req != "0") {
      if (data!.stock >= double.parse(data!.req)) {
        confController.text = data!.req;
      } else {
        confController.text = doubleFormatter(data!.stock);
      }
    }
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

  initialize() {
    if (dataArguments != null) {
      rack = dataArguments as String;
    }
  }

  @override
  Future<void> onInit() async {
    await getData();
    super.onInit();
  }
}
