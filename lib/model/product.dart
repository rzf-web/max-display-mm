class Product {
  final String id;
  final String barcode;
  final String name;
  final String rack;
  final String palonogram;
  final int display;
  final double price;
  final int req;
  final int conf;

  Product({
    required this.id,
    required this.barcode,
    required this.name,
    required this.rack,
    required this.palonogram,
    required this.display,
    required this.price,
    required this.req,
    required this.conf,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['idproduk'],
        barcode = json['barcode'],
        name = json['nama'],
        rack = json['rak'],
        palonogram = json['planogram'],
        display = int.parse(json['min'].toString()),
        price = double.parse(json['retail'].toString()),
        req = int.parse(json['request'].toString()),
        conf = int.parse(json['acc'].toString());
}
