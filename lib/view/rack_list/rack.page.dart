// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:max_display_app/view/rack_list/rack.controller.dart';
import 'package:max_display_app/widget/app_data_not_found.dart';
import 'package:max_display_app/widget/appbar_search.dart';
import 'package:max_display_app/widget/card_list.dart';
import 'package:max_display_app/widget/loading_widget.dart';
import 'package:max_display_app/widget/remove_indicator_scroll_widget.dart';

class RackPage extends GetView<RackController> {
  const RackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.getBack,
      child: Scaffold(
        appBar: AppBarSearch(
          title: "Daftar Rak",
          searchMode: controller.searchMode,
          controller: controller.searchController,
          onChanged: controller.onSearch,
          actionWidgets: [
            SizedBox(
              height: 22,
              width: 42,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: controller.logout,
                icon: Icon(MdiIcons.logout, size: 22),
              ),
            ),
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : Stack(
                  children: [
                    if (controller.rackList().isEmpty) const AppDataNotFound(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async => await controller.getData(),
                        child: RemoveScrollIndicator(
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              ...controller.rackList().map(
                                    (e) => CardList(
                                      title: e.name,
                                      content: "${e.totalQty} Qty",
                                      subtitle: "${e.totalProduct} Product",
                                      onTap: () =>
                                          controller.productPage(e.name),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
