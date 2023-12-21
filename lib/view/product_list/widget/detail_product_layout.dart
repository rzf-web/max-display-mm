part of '../product.page.dart';

class DetailProductLayout extends GetView<ProductController> {
  const DetailProductLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.0,
        16.0,
        16.0,
        MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFAEAEAE),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: _DropDownInputMode(),
                ),
              ),
              TextFieldProduct(
                label: "Nama",
                hint: "Nama Produk",
                icon: MdiIcons.foodTakeoutBoxOutline,
                controller: controller.nameController,
                readOnly: true,
              ),
              TextFieldProduct(
                label: "Planogram",
                hint: "Planogram",
                icon: MdiIcons.gateArrowRight,
                controller: controller.paloController,
                readOnly: true,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldProduct(
                      label: "Harga",
                      hint: "Harga",
                      icon: MdiIcons.currencyUsd,
                      controller: controller.priceController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFieldProduct(
                      label: "Rak",
                      hint: "Rak",
                      icon: MdiIcons.viewDashboardVariantOutline,
                      controller: controller.rackController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldProduct(
                      label: "ID Produk",
                      hint: "ID Produk",
                      icon: MdiIcons.tagOutline,
                      controller: controller.idController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFieldProduct(
                      label: "Barcode",
                      hint: "Barcode",
                      icon: MdiIcons.barcode,
                      controller: controller.barcodeController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldProduct(
                      label: "Stok Gudang",
                      hint: "Stok Gudang",
                      icon: MdiIcons.package,
                      controller: controller.stockController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFieldProduct(
                      label: "Max Display",
                      hint: "Max Display",
                      icon: MdiIcons.cartOutline,
                      controller: controller.displayController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(bottom: 10.0),
                width: double.infinity,
                color: const Color(0xFFABABAB),
              ),
              if (controller.inputMode.value == InputMode.request)
                TextFieldProduct(
                  label: "Request",
                  hint: "Masukan Request",
                  icon: MdiIcons.arrowUpRight,
                  controller: controller.reqController,
                  keyboardType: TextInputType.number,
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextFieldProduct(
                        label: "Request",
                        hint: "Masukan Request",
                        icon: MdiIcons.arrowDown,
                        controller: controller.reqController,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFieldProduct(
                        label: "Konfirmasi",
                        hint: "Konfirmasi",
                        icon: MdiIcons.arrowUpRight,
                        controller: controller.confController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              TemplateButton(
                onTap: controller.submit,
                child: const Text("Submit", style: btnStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropDownInputMode extends GetView<ProductController> {
  const _DropDownInputMode();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 140,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: primaryColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<InputMode>(
              elevation: 1,
              isDense: true,
              isExpanded: true,
              value: controller.inputMode.value,
              items: InputMode.values.map(buildMenuItem).toList(),
              icon: Icon(
                MdiIcons.chevronDown,
                color: const Color(0xFF4F4F4F),
                size: 22,
              ),
              onChanged: (value) => controller.changeInputMode(value),
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<InputMode> buildMenuItem(InputMode item) => DropdownMenuItem(
        value: item,
        child: Text(
          item.name.toCapitalized(),
          style: const TextStyle(color: Color(0xFF4F4F4F), fontSize: 14),
        ),
      );
}
