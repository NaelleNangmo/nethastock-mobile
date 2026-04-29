import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_badge.dart';

class AlertRow extends StatelessWidget {
  final String icon;
  final String name;
  final int quantity;
  final int minStock;

  const AlertRow({
    super.key,
    required this.icon,
    required this.name,
    required this.quantity,
    required this.minStock,
  });

  @override
  Widget build(BuildContext context) {
    final isCritical = quantity <= minStock ~/ 2;
    final bg    = isCritical
        ? AppColors.red.withValues(alpha: 0.1)
        : AppColors.orange.withValues(alpha: 0.1);
    final bord  = isCritical
        ? AppColors.red.withValues(alpha: 0.2)
        : AppColors.orange.withValues(alpha: 0.2);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bord),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(
                  fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w700,
                ), overflow: TextOverflow.ellipsis),
                Text('Stock : $quantity | Min : $minStock',
                    style: const TextStyle(fontFamily: 'DMSans', fontSize: 10,
                        color: AppColors.darkText3)),
              ],
            ),
          ),
          AppBadge(
            label: isCritical ? 'Critique' : 'Bas',
            color: isCritical ? BadgeColor.red : BadgeColor.orange,
          ),
        ],
      ),
    );
  }
}
