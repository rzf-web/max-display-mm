import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/view/product_list/product.page.dart';
import 'package:max_display_app/widget/dialog_content.dart';

actionDialog(
  String message, {
  ActionDialog actionDialog = ActionDialog.success,
}) async {
  var isClosed = false;
  Get.dialog(
    transitionCurve: Curves.fastOutSlowIn,
    AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      actionsPadding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
      content: DialogContent(message: message, actionDialog: actionDialog),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  ).then((_) => isClosed = true);
  await Future.delayed(const Duration(milliseconds: 2000));
  if (isClosed == false) {
    Get.back();
  }
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
