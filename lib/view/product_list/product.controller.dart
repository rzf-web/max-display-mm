import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/dialog.dart';
import 'package:max_display_app/helper/formatter.dart';
import 'package:max_display_app/helper/validator.dart';
import 'package:max_display_app/model/product.dart';
import 'package:max_display_app/services/api/api_helper.dart';
import 'package:max_display_app/services/api/api_service.dart';

enum InputMode { request, confirm }

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
  var inputMode = InputMode.request.obs;
  var searchMode = false.obs;
  var isLoading = false.obs;
  var rack = "";

  ProductController(this.rack);

  submit() {
    if (inputMode.value == InputMode.request) {
      submitRequest();
    } else {
      submitConfrim();
    }
  }

  submitRequest() {
    String? valid = phoneValidator(
      "Jumlah Request",
      reqController.text,
    );

    if (valid == null) {
      //TODO:do something
    } else {
      warningDialog(valid, () => Get.back());
    }
  }

  submitConfrim() {
    String? valid = phoneValidator(
      "Jumlah Konfirmasi",
      confController.text,
    );

    if (valid == null) {
      //TODO:do something
    } else {
      warningDialog(valid, () => Get.back());
    }
  }

  getData() async {
    isLoading.value = true;
    var response = await ApiService.get(
      url + product,
      queryParameters: {"rak": rack},
    );
    isLoading.value = false;
    var success = await manageResponse(response);
    if (success) {
      var data = getDataResponse(response);
      _products.clear();
      for (var item in data['data'] as List<dynamic>) {
        _products.add(Product.fromJson(item));
      }
      products.value = _products;
    }
  }

  showDetail(Product data) async {
    innitData(data);
    await showModalBtm();
  }

  innitData(Product data) {
    idController.text = data.id;
    paloController.text = data.palonogram;
    nameController.text = data.name;
    barcodeController.text = data.barcode;
    priceController.text = moneyFormatter(data.price);
    rackController.text = data.rack;
    displayController.text = data.display.toString();
    reqController.text = data.req.toString();
    confController.text = data.conf.toString();
  }

  onSearch(String value) {}

  changeInputMode(InputMode? data) {
    if (data != null) {
      inputMode.value = data;
    }
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
    super.onInit();
  }
}
