import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:max_display_app/widget/search_textfield.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? backWidget;
  final Rx<bool> searchMode;
  final List<Widget>? actionWidgets;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const AppBarSearch({
    super.key,
    required this.title,
    required this.searchMode,
    this.controller,
    this.onChanged,
    this.backWidget,
    this.actionWidgets,
  });

  @override
  Widget build(BuildContext context) {
    var actions = <Widget>[
      ...actionWidgets ?? [],
      IconButton(
        onPressed: () => searchMode.value = true,
        icon: Icon(MdiIcons.magnify),
      ),
    ];
    return Obx(
      () => AppBar(
        leading: searchMode.value ? const SizedBox() : backWidget,
        title: searchMode.value ? null : Text(title),
        actions: [if (!searchMode.value) ...actions],
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
