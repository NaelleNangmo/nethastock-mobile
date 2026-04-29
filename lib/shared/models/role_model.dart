import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  final int id;
  final String name;
  final String label;
  final int level;

  const RoleModel({required this.id, required this.name, required this.label, required this.level});

  factory RoleModel.fromJson(Map<String, dynamic> j) => RoleModel(
    id:    j['id']    as int,
    name:  j['name']  as String,
    label: j['label'] as String? ?? j['name'] as String,
    level: j['level'] as int? ?? 1,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'label': label, 'level': level};

  @override
  List<Object?> get props => [id, name];
}
