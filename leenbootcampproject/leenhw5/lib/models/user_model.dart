import 'package:leenhw5/models/address_model.dart';
import 'package:leenhw5/models/company_model.dart';
import 'package:leenhw5/models/geo_model.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final GeoModel geo;
  final String phone;
  final String website;
  final CompanyModel company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.geo,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressModel.fromMap(json['address']),
      geo: GeoModel.fromMap(json['address']['geo']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyModel.fromMap(json['company']),
    );
  }
}
