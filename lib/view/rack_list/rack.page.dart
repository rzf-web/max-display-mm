import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_display_app/helper/theme.dart';
import 'package:max_display_app/helper/utils.dart';
import 'package:max_display_app/model/rack.dart';
import 'package:max_display_app/view/rack_list/rack.controller.dart';
import 'package:max_display_app/widget/appbar_search.dart';
import 'package:max_display_app/widget/loading_widget.dart';
import 'package:max_display_app/widget/remove_indicator_scroll_widget.dart';
part 'widget/card_list.dart';

class RackPage extends GetView<RackController> {
  const RackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.getBack,
      child: Scaffold(
        appBar: AppBarSearch(
          title: "title",
          searchMode: controller.searchMode,
          controller: controller.searchController,
          onChanged: controller.onSearch,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : Padding(
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
                          ...controller.rackList().map((e) => _CardRackList(e)),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}