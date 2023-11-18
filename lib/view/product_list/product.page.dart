import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:max_display_app/helper/formatter.dart';
import 'package:max_display_app/helper/style_utils.dart';
import 'package:max_display_app/helper/theme.dart';
import 'package:max_display_app/view/product_list/product.controller.dart';
import 'package:max_display_app/widget/app_data_not_found.dart';
import 'package:max_display_app/widget/appbar_search.dart';
import 'package:max_display_app/widget/card_list.dart';
import 'package:max_display_app/widget/custom_btn.dart';
import 'package:max_display_app/widget/loading_widget.dart';
import 'package:max_display_app/widget/remove_indicator_scroll_widget.dart';
import 'package:max_display_app/widget/textfield_product.dart';
part 'widget/detail_product_layout.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.getBack,
      child: Scaffold(
        appBar: AppBarSearch(
          title: "Daftar Produk",
          searchMode: controller.searchMode,
          controller: controller.searchController,
          onChanged: controller.onSearch,
          backWidget: const BackButton(),
          actionWidgets: const [_ShowFilter()],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : Stack(
                  children: [
                    if (controller.products().isEmpty) const AppDataNotFound(),
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
                              ...controller.products().map(
                                    (e) => CardList(
                                      title: e.name,
                                      subtitle:
                                          "Req: ${e.req} - Stok: ${doubleFormatter(e.stock)}",
                                      content: moneyFormatter(e.price),
                                      onTap: () => controller.showDetail(e),
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

class _ShowFilter extends GetView<ProductController> {
  const _ShowFilter();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      shadowColor: const Color(0xFFACACAC).withOpacity(0.2),
      position: PopupMenuPosition.under,
      offset: const Offset(0, 8),
      elevation: 4,
      itemBuilder: (context) {
        return [
          ...Filter.values.map(
            (e) => PopupMenuItem(
              onTap: () => controller.changeFilter(e),
              child: Text(e.name.capitalize!),
            ),
          ),
        ];
      },
    );
  }
}
