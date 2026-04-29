import 'package:equatable/equatable.dart';

class InventoryItemModel extends Equatable {
  final int id;
  final int sessionId;
  final int productId;
  final String productName;
  final String? productSku;
  final int theoreticalQty;
  final int? countedQty;
  final int gap;

  const InventoryItemModel({
    required this.id, required this.sessionId,
    required this.productId, required this.productName,
    this.productSku, required this.theoreticalQty,
    this.countedQty, this.gap = 0,
  });

  factory InventoryItemModel.fromJson(Map<String, dynamic> j) => InventoryItemModel(
    id:             j['id']              as int,
    sessionId:      j['session_id']      as int,
    productId:      j['product_id']      as int,
    productName:    j['product_name']    as String? ?? '',
    productSku:     j['sku']             as String?,
    theoreticalQty: j['theoretical_qty'] as int? ?? 0,
    countedQty:     j['counted_qty']     as int?,
    gap:            j['gap']             as int? ?? 0,
  );

  @override
  List<Object?> get props => [id, productId];
}

class InventorySessionModel extends Equatable {
  final int id;
  final int siteId;
  final String siteName;
  final String mode;    // complet | tournant
  final String status;  // in_progress | closed | validated
  final DateTime startedAt;
  final DateTime? endedAt;
  final List<InventoryItemModel> items;

  const InventorySessionModel({
    required this.id, required this.siteId, required this.siteName,
    required this.mode, required this.status, required this.startedAt,
    this.endedAt, this.items = const [],
  });

  bool get isActive => status == 'in_progress';
  int get countedCount => items.where((i) => i.countedQty != null).length;
  int get totalCount   => items.length;

  factory InventorySessionModel.fromJson(Map<String, dynamic> j) => InventorySessionModel(
    id:        j['id']        as int,
    siteId:    j['site_id']   as int,
    siteName:  j['site_name'] as String? ?? '',
    mode:      j['mode']      as String,
    status:    j['status']    as String,
    startedAt: DateTime.parse(j['started_at'] as String),
    endedAt:   j['ended_at'] != null ? DateTime.parse(j['ended_at'] as String) : null,
    items: (j['items'] as List<dynamic>?)
        ?.map((e) => InventoryItemModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
  );

  @override
  List<Object?> get props => [id];
}
