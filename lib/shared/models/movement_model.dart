import 'package:equatable/equatable.dart';

class MovementModel extends Equatable {
  final int id;
  final String type;       // entry | exit | transfer | adjustment
  final int productId;
  final String productName;
  final String? productSku;
  final int siteId;
  final String siteName;
  final int? destinationSiteId;
  final String? destinationSiteName;
  final int quantity;
  final String status;     // pending | validated | rejected
  final String? motif;
  final String? supplier;
  final String? userName;
  final String? rejectionReason;
  final DateTime createdAt;

  const MovementModel({
    required this.id, required this.type,
    required this.productId, required this.productName,
    this.productSku,
    required this.siteId, required this.siteName,
    this.destinationSiteId, this.destinationSiteName,
    required this.quantity, required this.status,
    this.motif, this.supplier, this.userName,
    this.rejectionReason, required this.createdAt,
  });

  bool get isEntry    => type == 'entry';
  bool get isExit     => type == 'exit';
  bool get isTransfer => type == 'transfer';
  bool get isPending   => status == 'pending';
  bool get isValidated => status == 'validated';
  bool get isRejected  => status == 'rejected';

  factory MovementModel.fromJson(Map<String, dynamic> j) => MovementModel(
    id:                   j['id']                    as int,
    type:                 j['type']                  as String,
    productId:            j['product_id']            as int,
    productName:          j['product_name']          as String? ?? '',
    productSku:           j['sku']                   as String?,
    siteId:               j['site_id']               as int,
    siteName:             j['site_name']             as String? ?? '',
    destinationSiteId:    j['destination_site_id']   as int?,
    destinationSiteName:  j['destination_site_name'] as String?,
    quantity:             j['quantity']              as int,
    status:               j['status']                as String,
    motif:                j['motif']                 as String?,
    supplier:             j['supplier']              as String?,
    userName:             j['user_name']             as String?,
    rejectionReason:      j['rejection_reason']      as String?,
    createdAt: DateTime.parse(j['created_at'] as String),
  );

  @override
  List<Object?> get props => [id];
}
