import 'package:flutter/material.dart';
import '../../../shared/models/movement_model.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardStats?        _stats;
  List<AlertProduct>     _alerts         = [];
  List<MovementModel>    _recentMovements = [];
  List<SiteStockSummary> _sitesStock     = [];
  bool   _isLoading = false;
  String? _error;

  DashboardStats?        get stats           => _stats;
  List<AlertProduct>     get alerts          => _alerts;
  List<MovementModel>    get recentMovements => _recentMovements;
  List<SiteStockSummary> get sitesStock      => _sitesStock;
  bool    get isLoading => _isLoading;
  String? get error     => _error;

  Future<void> load({int? siteId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        DashboardService.getDashboard(siteId: siteId),
        DashboardService.getAlerts(siteId: siteId),
        DashboardService.getRecentMovements(siteId: siteId),
        DashboardService.getSitesStock(),
      ]);

      _stats           = results[0] as DashboardStats;
      _alerts          = results[1] as List<AlertProduct>;
      _recentMovements = results[2] as List<MovementModel>;
      _sitesStock      = results[3] as List<SiteStockSummary>;
    } catch (e) {
      _error = 'Impossible de charger le tableau de bord';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh({int? siteId}) => load(siteId: siteId);
}
