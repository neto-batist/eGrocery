// data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    String? password,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
    id: id,
    name: name,
    email: email,
    phone: phone,
    password: password,
    address: address,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? '',
      password: json['password'],
      address: json['address'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      if (password != null) 'password': password,
      if (address != null) 'address': address,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// De Entity para Model
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      password: user.password,
      address: user.address,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  /// De Model para Entity
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      password: password,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
