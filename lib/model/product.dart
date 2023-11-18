class Product {
  final String id;
  final String barcode;
  final String name;
  final String rack;
  final String palonogram;
  final String display;
  final double price;
  final double stock;
  final String req;
  final String conf;

  Product({
    required this.id,
    required this.barcode,
    required this.name,
    required this.rack,
    required this.palonogram,
    required this.display,
    required this.stock,
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
        display = json['max'].toString(),
        price = double.parse(json['retail'].toString()),
        stock = double.parse(json['stok'].toString()),
        req = json['request'].toString(),
        conf = json['acc'].toString();
}
