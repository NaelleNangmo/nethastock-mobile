import 'package:equatable/equatable.dart';
import 'role_model.dart';
import 'site_model.dart';

class UserModel extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final RoleModel? role;
  final SiteModel? site;
  final bool active;

  const UserModel({
    required this.id, required this.email,
    required this.firstName, required this.lastName,
    this.role, this.site, this.active = true,
  });

  String get fullName => '$firstName $lastName';
  String get initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty  ? lastName[0].toUpperCase()  : '';
    return '$f$l';
  }

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
    id:        j['id']         as int,
    email:     j['email']      as String,
    firstName: j['first_name'] as String? ?? j['firstName'] as String? ?? '',
    lastName:  j['last_name']  as String? ?? j['lastName']  as String? ?? '',
    role:      j['role'] != null ? RoleModel.fromJson(j['role'] as Map<String, dynamic>) : null,
    site:      j['site'] != null ? SiteModel.fromJson(j['site'] as Map<String, dynamic>) : null,
    active:    j['active'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'email': email, 'first_name': firstName, 'last_name': lastName,
    'role': role?.toJson(), 'site': site?.toJson(), 'active': active,
  };

  @override
  List<Object?> get props => [id, email];
}
