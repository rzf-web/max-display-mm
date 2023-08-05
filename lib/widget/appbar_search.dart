import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:max_display_app/widget/search_textfield.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Rx<bool> searchMode;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const AppBarSearch({
    super.key,
    required this.title,
    required this.searchMode,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        title: searchMode.value ? null : const Text("Daftar Rak"),
        actions: [
          if (!searchMode.value)
            IconButton(
              onPressed: () => searchMode.value = true,
              icon: Icon(MdiIcons.magnify),
            ),
        ],
        flexibleSpace: Visibility(
          visible: searchMode.value,
          child: Center(
            child: TextFieldAppBar(
              controller: controller,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
