class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? password;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.address,
    this.createdAt,
    this.updatedAt,
  });
}
