import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final int id;
  final String title;
  final String? body;
  final String type;
  final bool read;
  final int? referenceId;
  final String? referenceType;
  final DateTime createdAt;

  const NotificationModel({
    required this.id, required this.title, this.body,
    required this.type, required this.read,
    this.referenceId, this.referenceType, required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> j) => NotificationModel(
    id:            j['id']             as int,
    title:         j['title']          as String,
    body:          j['body']           as String?,
    type:          j['type']           as String? ?? 'system',
    read:          j['read']           as bool? ?? false,
    referenceId:   j['reference_id']   as int?,
    referenceType: j['reference_type'] as String?,
    createdAt: DateTime.parse(j['created_at'] as String),
  );

  @override
  List<Object?> get props => [id];
}
