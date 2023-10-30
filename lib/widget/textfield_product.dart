import 'package:flutter/material.dart';
import 'package:max_display_app/helper/theme.dart';

class TextFieldProduct extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function()? onTap;
  const TextFieldProduct({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.multiline,
    this.validator,
    this.focusNode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Theme(
        data: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor),
        ),
        child: TextFormField(
          focusNode: focusNode,
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: primaryColor),
            ),
            prefixIcon: Icon(icon, color: primaryColor),
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFFB8B8B8),
            ),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
