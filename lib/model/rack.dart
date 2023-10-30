class Rack {
  final String name;
  final String totalProduct;
  final String totalQty;

  Rack({
    required this.name,
    required this.totalProduct,
    required this.totalQty,
  });

  factory Rack.fromJson(Map<String, dynamic> json) {
    return Rack(
      name: json['rak'],
      totalProduct: json['total_product'].toString(),
      totalQty: json['total_qty'].toString(),
    );
  }
}
