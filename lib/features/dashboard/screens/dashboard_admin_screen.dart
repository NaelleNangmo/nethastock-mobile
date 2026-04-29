import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/alert_row.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/kpi_card.dart';
import '../../../shared/widgets/movement_item.dart';
import '../../../shared/widgets/app_card.dart';
import '../../auth/providers/auth_provider.dart';
import '../../notifications/services/notification_service.dart';
import '../providers/dashboard_provider.dart';

class DashboardAdminScreen extends StatefulWidget {
  const DashboardAdminScreen({super.key});

  @override
  State<DashboardAdminScreen> createState() => _DashboardAdminScreenState();
}

class _DashboardAdminScreenState extends State<DashboardAdminScreen> {
  int _navIndex = 0;
  int _unreadNotifs = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final siteId = context.read<AuthProvider>().user?.site?.id;
    await context.read<DashboardProvider>().load(siteId: siteId);
    try {
      final count = await NotificationService.getUnreadCount();
      if (mounted) setState(() => _unreadNotifs = count);
    } catch (_) {}
  }

  void _onNavTap(int i) {
    setState(() => _navIndex = i);
    switch (i) {
      case 1: context.push('/products');  break;
      case 2: context.push('/movements/new'); break;
      case 3: context.push('/users');     break;
      case 4: context.push('/profile');   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth   = context.watch<AuthProvider>();
    final dash   = context.watch<DashboardProvider>();
    final user   = auth.user;

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _load,
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────────────
            SliverToBoxAdapter(child: _Header(
              user:         user,
              isDark:       isDark,
              unreadNotifs: _unreadNotifs,
            )),

            if (dash.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              )
            else ...[
              // ── KPIs ──────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate([
                    KpiCard(
                      icon: '📦',
                      value: '${dash.stats?.totalStock ?? 0}',
                      label: 'Articles en stock',
                      valueColor: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                    KpiCard(
                      icon: '⚠️',
                      value: '${dash.stats?.alertCount ?? 0}',
                      label: 'Alertes seuil bas',
                      valueColor: AppColors.red,
                    ),
                    KpiCard(
                      icon: '⬇️',
                      value: '+${dash.stats?.todayMovements ?? 0}',
                      label: 'Mouvements auj.',
                      valueColor: AppColors.green,
                    ),
                    KpiCard(
                      icon: '🏪',
                      value: '${dash.stats?.totalSites ?? 0}',
                      label: 'Sites actifs',
                      valueColor: AppColors.cyan,
                    ),
                  ]),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                ),
              ),

              // ── Alertes critiques ──────────────────────────
              if (dash.alerts.isNotEmpty)
                SliverToBoxAdapter(child: _Section(
                  title: '🚨 Articles critiques',
                  isDark: isDark,
                  child: Column(
                    children: dash.alerts.take(3).map((a) => AlertRow(
                      icon:     '📦',
                      name:     a.name,
                      quantity: a.quantity,
                      minStock: a.minStock,
                    )).toList(),
                  ),
                )),

              // ── Derniers mouvements ────────────────────────
              if (dash.recentMovements.isNotEmpty)
                SliverToBoxAdapter(child: _Section(
                  title: 'Derniers mouvements',
                  isDark: isDark,
                  actionLabel: 'Voir tout',
                  onAction: () => context.push('/movements/history'),
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: dash.recentMovements.map((m) => MovementItem(
                        movement: m,
                        onTap: () => context.push('/movements/${m.id}'),
                      )).toList(),
                    ),
                  ),
                )),

              // ── Stocks par magasin ─────────────────────────
              if (dash.sitesStock.isNotEmpty)
                SliverToBoxAdapter(child: _Section(
                  title: '🏪 Stocks par magasin',
                  isDark: isDark,
                  child: AppCard(
                    child: Column(
                      children: dash.sitesStock.map((s) {
                        final maxStock = dash.sitesStock
                            .map((x) => x.totalStock)
                            .fold(1, (a, b) => a > b ? a : b);
                        final ratio = maxStock > 0 ? s.totalStock / maxStock : 0.0;
                        final color = ratio > 0.6
                            ? AppColors.green
                            : ratio > 0.3
                                ? AppColors.orange
                                : AppColors.red;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(children: [
                            Text(_siteIcon(s.type), style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 10),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.name, style: const TextStyle(
                                  fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w700,
                                )),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: LinearProgressIndicator(
                                    value: ratio.clamp(0.0, 1.0),
                                    backgroundColor: isDark ? AppColors.darkSurface3 : AppColors.lightSurface3,
                                    color: color,
                                    minHeight: 6,
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(width: 10),
                            Text('${s.totalStock}', style: TextStyle(
                              fontFamily: 'DMSans', fontSize: 12,
                              fontWeight: FontWeight.w700, color: color,
                            )),
                          ]),
                        );
                      }).toList(),
                    ),
                  ),
                )),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavItem(label: 'Accueil',      icon: Icons.home_outlined,       activeIcon: Icons.home),
          BottomNavItem(label: 'Produits',     icon: Icons.inventory_2_outlined, activeIcon: Icons.inventory_2),
          BottomNavItem(label: 'Mouvement',    icon: Icons.swap_vert_outlined,   activeIcon: Icons.swap_vert),
          BottomNavItem(label: 'Utilisateurs', icon: Icons.group_outlined,       activeIcon: Icons.group),
          BottomNavItem(label: 'Profil',       icon: Icons.settings_outlined,    activeIcon: Icons.settings),
        ],
      ),
    );
  }

  String _siteIcon(String type) {
    return switch (type) {
      'magasin'  => '🏪',
      'depot'    => '📦',
      'agence'   => '🏢',
      _          => '🏭',
    };
  }
}

// ── Widgets internes ─────────────────────────────────────────────

class _Header extends StatelessWidget {
  final dynamic user;
  final bool isDark;
  final int unreadNotifs;

  const _Header({this.user, required this.isDark, required this.unreadNotifs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bonjour 👋', style: TextStyle(
                  fontFamily: 'DMSans', fontSize: 13,
                  color: isDark ? AppColors.darkText2 : AppColors.lightText2,
                )),
                const SizedBox(height: 2),
                Text(user?.fullName ?? 'Utilisateur', style: TextStyle(
                  fontFamily: 'DMSans', fontSize: 20, fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                )),
                const SizedBox(height: 6),
                if (user?.site != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.cyan.withValues(alpha: 0.2)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text('🏪', style: TextStyle(fontSize: 11)),
                      const SizedBox(width: 5),
                      Text(user!.site!.name, style: const TextStyle(
                        fontFamily: 'DMSans', fontSize: 11,
                        color: AppColors.cyan, fontWeight: FontWeight.w600,
                      )),
                    ]),
                  ),
              ],
            ),
          ),
          // Cloche notifications
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: AppColors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_outlined, size: 20, color: AppColors.red),
              ),
              if (unreadNotifs > 0)
                Positioned(
                  top: -2, right: -2,
                  child: Container(
                    width: 14, height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.darkBg : AppColors.lightBg,
                        width: 1.5,
                      ),
                    ),
                    child: Center(child: Text(
                      unreadNotifs > 9 ? '9+' : '$unreadNotifs',
                      style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.w800),
                    )),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final bool isDark;
  final Widget child;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _Section({
    required this.title,
    required this.isDark,
    required this.child,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(
                fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w800,
                letterSpacing: 1.5, textBaseline: TextBaseline.alphabetic,
                color: isDark ? AppColors.darkText3 : AppColors.lightText3,
              )),
              const Spacer(),
              if (actionLabel != null)
                GestureDetector(
                  onTap: onAction,
                  child: Text(actionLabel!, style: const TextStyle(
                    fontFamily: 'DMSans', fontSize: 11,
                    color: AppColors.primaryLight, fontWeight: FontWeight.w600,
                  )),
                ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
