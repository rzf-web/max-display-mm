import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
