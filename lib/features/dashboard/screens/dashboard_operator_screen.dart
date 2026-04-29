import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/alert_row.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/bottom_nav.dart';
import '../../../shared/widgets/movement_item.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';

class DashboardOperatorScreen extends StatefulWidget {
  const DashboardOperatorScreen({super.key});

  @override
  State<DashboardOperatorScreen> createState() => _DashboardOperatorScreenState();
}

class _DashboardOperatorScreenState extends State<DashboardOperatorScreen> {
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final siteId = context.read<AuthProvider>().user?.site?.id;
      context.read<DashboardProvider>().load(siteId: siteId);
    });
  }

  void _onNavTap(int i) {
    setState(() => _navIndex = i);
    switch (i) {
      case 1: context.push('/products');          break;
      case 2: context.push('/scanner');           break;
      case 3: context.push('/movements/history'); break;
      case 4: context.push('/profile');           break;
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
        onRefresh: () async {
          final siteId = auth.user?.site?.id;
          await dash.refresh(siteId: siteId);
        },
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
                child: Row(
                  children: [
                    Expanded(child: Column(
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
                      ],
                    )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _roleLabel(user?.role?.name ?? ''),
                        style: const TextStyle(
                          fontFamily: 'DMSans', fontSize: 11,
                          color: AppColors.cyan, fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (dash.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              )
            else ...[
              // ── Actions rapides ────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverToBoxAdapter(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Actions rapides', style: TextStyle(
                      fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: isDark ? AppColors.darkText3 : AppColors.lightText3,
                    )),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.6,
                      children: [
                        _QuickAction(
                          icon: '⬇️', label: 'Réception',
                          color: AppColors.green,
                          onTap: () => context.push('/movements/new?type=entry'),
                        ),
                        _QuickAction(
                          icon: '⬆️', label: 'Sortie',
                          color: AppColors.red,
                          onTap: () => context.push('/movements/new?type=exit'),
                        ),
                        _QuickAction(
                          icon: '📷', label: 'Scanner',
                          color: AppColors.cyan,
                          onTap: () => context.push('/scanner'),
                        ),
                        _QuickAction(
                          icon: '🔄', label: 'Transfert',
                          color: AppColors.orange,
                          onTap: () => context.push('/movements/transfer'),
                        ),
                      ],
                    ),
                  ],
                )),
              ),

              // ── Alertes ────────────────────────────────────
              if (dash.alerts.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverToBoxAdapter(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('⚠️ Alertes stock bas', style: TextStyle(
                        fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: isDark ? AppColors.darkText3 : AppColors.lightText3,
                      )),
                      const SizedBox(height: 10),
                      ...dash.alerts.take(3).map((a) => AlertRow(
                        icon: '📦', name: a.name,
                        quantity: a.quantity, minStock: a.minStock,
                      )),
                    ],
                  )),
                ),

              // ── Mes dernières opérations ───────────────────
              if (dash.recentMovements.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverToBoxAdapter(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mes dernières opérations', style: TextStyle(
                        fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: isDark ? AppColors.darkText3 : AppColors.lightText3,
                      )),
                      const SizedBox(height: 10),
                      AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: dash.recentMovements.map((m) => MovementItem(
                            movement: m,
                            onTap: () => context.push('/movements/${m.id}'),
                          )).toList(),
                        ),
                      ),
                    ],
                  )),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavItem(label: 'Accueil',    icon: Icons.home_outlined,        activeIcon: Icons.home),
          BottomNavItem(label: 'Produits',   icon: Icons.inventory_2_outlined,  activeIcon: Icons.inventory_2),
          BottomNavItem(label: 'Scanner',    icon: Icons.qr_code_scanner_outlined, activeIcon: Icons.qr_code_scanner),
          BottomNavItem(label: 'Historique', icon: Icons.history_outlined,      activeIcon: Icons.history),
          BottomNavItem(label: 'Profil',     icon: Icons.settings_outlined,     activeIcon: Icons.settings),
        ],
      ),
    );
  }

  String _roleLabel(String role) => switch (role) {
    'operator_stock' => 'Op. Stock',
    'controller'     => 'Contrôleur',
    'site_manager'   => 'Resp. Site',
    'viewer'         => 'Lecteur',
    _                => role,
  };
}

class _QuickAction extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(
              fontFamily: 'DMSans', fontSize: 12,
              fontWeight: FontWeight.w700, color: color,
            )),
          ],
        ),
      ),
    );
  }
}
