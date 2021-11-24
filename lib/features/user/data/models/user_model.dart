import 'package:nubank_marketplace/features/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({String id, String name, int balance})
      : super(id: id, name: name, balance: balance);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      balance: json['balance'] != null ? int.tryParse(json['balance']) : 0);
}
