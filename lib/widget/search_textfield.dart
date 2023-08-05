import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TextFieldAppBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const TextFieldAppBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.white,
            ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
              ),
              contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              prefixIcon: Icon(
                MdiIcons.magnify,
                color: const Color(0xffffffff),
              ),
              hintText: "Search...",
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            autofocus: true,
            cursorColor: const Color(0xFFFFFFFF),
            style: const TextStyle(color: Colors.white),
            controller: controller,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
