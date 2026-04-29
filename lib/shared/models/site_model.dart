import 'package:equatable/equatable.dart';

class SiteModel extends Equatable {
  final int id;
  final String name;
  final String type;
  final String? city;
  final String? country;
  final bool active;

  const SiteModel({
    required this.id, required this.name, required this.type,
    this.city, this.country, this.active = true,
  });

  factory SiteModel.fromJson(Map<String, dynamic> j) => SiteModel(
    id:      j['id']      as int,
    name:    j['name']    as String,
    type:    j['type']    as String? ?? 'entrepot',
    city:    j['city']    as String?,
    country: j['country'] as String?,
    active:  j['active']  as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'type': type,
    'city': city, 'country': country, 'active': active,
  };

  @override
  List<Object?> get props => [id, name];
}
