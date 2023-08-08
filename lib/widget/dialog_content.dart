import 'package:flutter/material.dart';

enum ActionDialog { error, warning, success }

class DialogContent extends StatelessWidget {
  final String message;
  final ActionDialog actionDialog;
  final Widget? action;
  const DialogContent({
    super.key,
    required this.message,
    required this.actionDialog,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Text(
            getTitle(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
          action ?? const SizedBox(height: 32),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  String getTitle() {
    switch (actionDialog) {
      case ActionDialog.error:
        return "Gagal!";
      case ActionDialog.warning:
        return "Warning!";
      default:
        return "Berhasil!";
    }
  }
}
