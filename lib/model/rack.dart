class Rack {
  final String name;
  final int totalProduct;
  final int totalQty;

  Rack({
    required this.name,
    required this.totalProduct,
    required this.totalQty,
  });

  factory Rack.fromJson(Map<String, dynamic> json) {
    return Rack(
      name: json['rak'],
      totalProduct: json['totalProduct'],
      totalQty: json['totalQty'],
    );
  }
}
