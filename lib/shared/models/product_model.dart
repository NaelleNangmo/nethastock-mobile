import 'package:equatable/equatable.dart';

class ProductVariant extends Equatable {
  final int? id;
  final String type;
  final String value;
  final String? skuSuffix;

  const ProductVariant({this.id, required this.type, required this.value, this.skuSuffix});

  factory ProductVariant.fromJson(Map<String, dynamic> j) => ProductVariant(
    id:        j['id']           as int?,
    type:      j['variant_type'] as String? ?? j['type'] as String? ?? '',
    value:     j['variant_value'] as String? ?? j['value'] as String? ?? '',
    skuSuffix: j['sku_suffix']   as String?,
  );

  Map<String, dynamic> toJson() => {'type': type, 'value': value, 'sku_suffix': skuSuffix};

  @override
  List<Object?> get props => [id, type, value];
}

class ProductStockBySite extends Equatable {
  final int siteId;
  final String siteName;
  final int quantity;
  final int minStock;
  final int maxStock;
  final String? location;

  const ProductStockBySite({
    required this.siteId, required this.siteName,
    required this.quantity, required this.minStock,
    required this.maxStock, this.location,
  });

  bool get isAlert => quantity <= minStock;

  factory ProductStockBySite.fromJson(Map<String, dynamic> j) => ProductStockBySite(
    siteId:   j['site_id']   as int,
    siteName: j['site_name'] as String? ?? '',
    quantity: j['quantity']  as int? ?? 0,
    minStock: j['min_stock'] as int? ?? 0,
    maxStock: j['max_stock'] as int? ?? 9999,
    location: j['location']  as String?,
  );

  @override
  List<Object?> get props => [siteId];
}

class ProductModel extends Equatable {
  final int id;
  final String sku;
  final String name;
  final String? barcode;
  final String? brand;
  final String unit;
  final String? description;
  final int? categoryId;
  final String? categoryName;
  final double purchasePrice;
  final double salePrice;
  final String? photoUrl;
  final String? qrCodeUrl;
  final int totalStock;
  final bool active;
  final List<ProductVariant> variants;
  final List<ProductStockBySite> stocks;

  const ProductModel({
    required this.id, required this.sku, required this.name,
    this.barcode, this.brand, this.unit = 'piece',
    this.description, this.categoryId, this.categoryName,
    this.purchasePrice = 0, this.salePrice = 0,
    this.photoUrl, this.qrCodeUrl,
    this.totalStock = 0, this.active = true,
    this.variants = const [], this.stocks = const [],
  });

  bool get isAlert => stocks.any((s) => s.isAlert);

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
    id:            j['id']            as int,
    sku:           j['sku']           as String,
    name:          j['name']          as String,
    barcode:       j['barcode']       as String?,
    brand:         j['brand']         as String?,
    unit:          j['unit']          as String? ?? 'piece',
    description:   j['description']   as String?,
    categoryId:    j['category_id']   as int?,
    categoryName:  j['category_name'] as String?,
    purchasePrice: (j['purchase_price'] as num?)?.toDouble() ?? 0,
    salePrice:     (j['sale_price']     as num?)?.toDouble() ?? 0,
    photoUrl:      j['photo_url']     as String?,
    qrCodeUrl:     j['qr_code_url']   as String?,
    totalStock:    j['total_stock']   as int? ?? 0,
    active:        j['active']        as bool? ?? true,
    variants: (j['variants'] as List<dynamic>?)
        ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
    stocks: (j['stocks'] as List<dynamic>?)
        ?.map((e) => ProductStockBySite.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
  );

  @override
  List<Object?> get props => [id, sku];
}
