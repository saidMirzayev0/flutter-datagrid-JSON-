class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name_surname: json['name_surname'],
        phone: json['phone'],
        email: json['email'],
        address: json['address'],
        tracking_number: json['tracking_number'],
        total: json['total'],
        currency: json['currency']);
  }
  Product({
    required this.name_surname,
    required this.phone,
    required this.email,
    required this.address,
    required this.tracking_number,
    required this.total,
    required this.currency,
  });

  final String? name_surname;
  final String? phone;
  final String? email;
  final String? address;
  final String? tracking_number;
  final String? total;
  final String? currency;
}
