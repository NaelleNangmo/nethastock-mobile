class ApiConstants {
  ApiConstants._();

  // ── Base URL ─────────────────────────────────────────────────
  // Android emulator : 10.0.2.2 pointe vers localhost de la machine hôte
  static const String baseUrl = 'http://10.0.2.2:4000/api/v1';
  // iOS simulator   : static const String baseUrl = 'http://localhost:4000/api/v1';
  // Device physique : static const String baseUrl = 'http://192.168.x.x:4000/api/v1';

  // ── Auth ─────────────────────────────────────────────────────
  static const String login   = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout  = '/auth/logout';
  static const String me      = '/auth/me';

  // ── Sites ────────────────────────────────────────────────────
  static const String sites = '/sites';
  static String siteById(int id) => '/sites/$id';
  static String siteToggle(int id) => '/sites/$id/toggle';

  // ── Roles ────────────────────────────────────────────────────
  static const String roles = '/roles';

  // ── Users ────────────────────────────────────────────────────
  static const String users      = '/users';
  static const String myProfile  = '/users/me';
  static const String myPassword = '/users/me/password';
  static String userById(int id)     => '/users/$id';
  static String userToggle(int id)   => '/users/$id/toggle';

  // ── Categories ───────────────────────────────────────────────
  static const String categories = '/categories';
  static String categoryById(int id) => '/categories/$id';

  // ── Products ─────────────────────────────────────────────────
  static const String products      = '/products';
  static const String productAlerts = '/products/alerts';
  static String productById(int id)       => '/products/$id';
  static String productScan(String code)  => '/products/scan/$code';
  static String productQr(int id)         => '/products/$id/qrcode';
  static String productPhoto(int id)      => '/products/$id/photo';
  static String productVariants(int id)   => '/products/$id/variants';

  // ── Stocks ───────────────────────────────────────────────────
  static const String stocks         = '/stocks';
  static const String stockTransfer  = '/stocks/transfer';
  static String stockByProductSite(int productId, int siteId) =>
      '/stocks/$productId/$siteId';

  // ── Movements ────────────────────────────────────────────────
  static const String movements         = '/movements';
  static const String movementsPending  = '/movements/pending';
  static const String movementsIn       = '/movements/in';
  static const String movementsOut      = '/movements/out';
  static const String movementsTransfer = '/movements/transfer';
  static String movementById(int id)       => '/movements/$id';
  static String movementValidate(int id)   => '/movements/$id/validate';
  static String movementReject(int id)     => '/movements/$id/reject';

  // ── Inventory ────────────────────────────────────────────────
  static const String inventorySessions       = '/inventory/sessions';
  static const String inventoryActiveSession  = '/inventory/sessions/active';
  static String inventorySessionById(int id)          => '/inventory/sessions/$id';
  static String inventorySessionItems(int id)         => '/inventory/sessions/$id/items';
  static String inventorySessionItem(int id, int iid) => '/inventory/sessions/$id/items/$iid';
  static String inventorySessionGaps(int id)          => '/inventory/sessions/$id/gaps';
  static String inventorySessionValidate(int id)      => '/inventory/sessions/$id/validate';
  static String inventorySessionClose(int id)         => '/inventory/sessions/$id/close';

  // ── Reports ──────────────────────────────────────────────────
  static const String reportDashboard = '/reports/dashboard';
  static const String reportAlerts    = '/reports/alerts';
  static const String reportStock     = '/reports/stock';
  static const String reportMovements = '/reports/movements';

  // ── Notifications ────────────────────────────────────────────
  static const String notifications        = '/notifications';
  static const String notificationsReadAll = '/notifications/read-all';
  static const String notificationsFcm     = '/notifications/fcm-token';
  static String notificationById(int id)   => '/notifications/$id';
  static String notificationRead(int id)   => '/notifications/$id/read';
}
