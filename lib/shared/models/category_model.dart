import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int? siteId;
  final int productCount;
  final bool active;

  const CategoryModel({
    required this.id, required this.name,
    this.description, this.siteId,
    this.productCount = 0, this.active = true,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> j) => CategoryModel(
    id:           j['id']            as int,
    name:         j['name']          as String,
    description:  j['description']   as String?,
    siteId:       j['site_id']       as int?,
    productCount: j['product_count'] as int? ?? 0,
    active:       j['active']        as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'description': description,
    'site_id': siteId, 'active': active,
  };

  @override
  List<Object?> get props => [id, name];
}
