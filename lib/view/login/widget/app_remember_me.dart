import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/theme.dart';

class AppRememberMe extends StatefulWidget {
  final Function(bool) onChanged;
  const AppRememberMe({super.key, required this.onChanged});

  @override
  State<AppRememberMe> createState() => _AppRememberMeState();
}

class _AppRememberMeState extends State<AppRememberMe> {
  var checkBoxValue = false.obs;

  onChanged() {
    checkBoxValue.value = !checkBoxValue.value;
    widget.onChanged(checkBoxValue.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(),
      child: Row(
        children: [
          Obx(
            () => SizedBox(
              height: 22.0,
              width: 22.0,
              child: Checkbox(
                value: checkBoxValue.value,
                onChanged: (_) => onChanged(),
                activeColor: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            "Ingat Saya",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
