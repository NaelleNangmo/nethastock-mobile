class DashboardStats {
  final int totalProducts;
  final int totalStock;
  final int totalSites;
  final int alertCount;
  final int todayMovements;

  const DashboardStats({
    this.totalProducts  = 0,
    this.totalStock     = 0,
    this.totalSites     = 0,
    this.alertCount     = 0,
    this.todayMovements = 0,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> j) => DashboardStats(
    totalProducts:  j['total_products']  as int? ?? 0,
    totalStock:     j['total_stock']     as int? ?? 0,
    totalSites:     j['total_sites']     as int? ?? 0,
    alertCount:     j['alert_count']     as int? ?? 0,
    todayMovements: j['today_movements'] as int? ?? 0,
  );
}

class AlertProduct {
  final int    id;
  final String name;
  final String sku;
  final int    quantity;
  final int    minStock;
  final String siteName;

  const AlertProduct({
    required this.id,
    required this.name,
    required this.sku,
    required this.quantity,
    required this.minStock,
    required this.siteName,
  });

  bool get isCritical => quantity <= minStock ~/ 2;

  factory AlertProduct.fromJson(Map<String, dynamic> j) => AlertProduct(
    id:       j['id']        as int,
    name:     j['name']      as String,
    sku:      j['sku']       as String? ?? '',
    quantity: j['quantity']  as int? ?? 0,
    minStock: j['min_stock'] as int? ?? 0,
    siteName: j['site_name'] as String? ?? '',
  );
}

class SiteStockSummary {
  final int    id;
  final String name;
  final String type;
  final int    totalStock;
  final int    productCount;
  final int    alertCount;

  const SiteStockSummary({
    required this.id,
    required this.name,
    required this.type,
    required this.totalStock,
    required this.productCount,
    required this.alertCount,
  });

  factory SiteStockSummary.fromJson(Map<String, dynamic> j) => SiteStockSummary(
    id:           j['id']            as int,
    name:         j['site_name']     as String? ?? j['name'] as String? ?? '',
    type:         j['type']          as String? ?? 'entrepot',
    totalStock:   j['total_stock']   as int? ?? 0,
    productCount: j['product_count'] as int? ?? 0,
    alertCount:   j['alert_count']   as int? ?? 0,
  );
}
