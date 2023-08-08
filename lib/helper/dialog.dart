import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/view/product_list/product.page.dart';

errorDialog(String contentText, Function() btnOke) {
  return Get.dialog(AlertDialog(
    title: const Text("Error"),
    content: Text(contentText),
    actions: [
      ElevatedButton(
        onPressed: btnOke,
        child: const Text("Oke"),
      )
    ],
  ));
}

infoDialog(String contentText, Function() btnOke) {
  return Get.dialog(AlertDialog(
    title: const Text("Informasi"),
    content: Text(contentText),
    actions: [
      ElevatedButton(
        onPressed: btnOke,
        child: const Text("Oke"),
      )
    ],
  ));
}

warningDialog(String contentText, Function() btnOke) {
  return Get.dialog(AlertDialog(
    title: const Text("Warning!"),
    content: Text(contentText),
    actions: [
      ElevatedButton(
        onPressed: btnOke,
        child: const Text("Oke"),
      )
    ],
  ));
}

succesDialog(String contentText, Function() btnOke) {
  return Get.dialog(AlertDialog(
    title: const Text("Sukses"),
    content: Text(contentText),
    actions: [
      ElevatedButton(
        onPressed: btnOke,
        child: const Text("Oke"),
      )
    ],
  ));
}

showSnackbar(String message) {
  Get.rawSnackbar(
    maxWidth: 180,
    borderRadius: 80,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    backgroundColor: Colors.grey.withOpacity(0.4),
    duration: const Duration(milliseconds: 1000),
    margin: const EdgeInsets.only(bottom: 40),
    messageText: Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
    ),
  );
}

showModalBtm() async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) => const DetailProductLayout(),
  );
}
