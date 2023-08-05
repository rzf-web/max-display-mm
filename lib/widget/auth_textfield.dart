import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:max_display_app/helper/theme.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final bool isLoading;
  final Key? keyForm;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.isLoading = false,
    this.onChanged,
    this.keyForm,
  });

  @override
  Widget build(BuildContext context) {
    var hide = isPassword.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4f4f4f),
          ),
        ),
        Stack(
          children: [
            Obx(
              () => TextFormField(
                key: keyForm,
                keyboardType: keyboardType,
                textAlignVertical: getTextAlignVertical(),
                obscureText: hide.value,
                controller: controller,
                validator: validator,
                onChanged: onChanged,
                style: const TextStyle(fontSize: 14),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 10.0,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  suffixIcon: getSuffixIcon(hide.value, () {
                    hide.value = !hide.value;
                  }),
                  hintText: hint,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 18.0),
                child: Visibility(
                  visible: isLoading,
                  child: const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget? getSuffixIcon(bool hide, Function() ontap) {
    return isPassword
        ? IconButton(
            onPressed: ontap,
            icon: hide
                ? Icon(MdiIcons.eyeOutline, color: primaryColor)
                : Icon(MdiIcons.eyeOffOutline, color: primaryColor),
          )
        : null;
  }

  TextAlignVertical getTextAlignVertical() {
    return isPassword ? TextAlignVertical.center : TextAlignVertical.top;
  }
}
