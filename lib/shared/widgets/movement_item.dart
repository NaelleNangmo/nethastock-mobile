import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_formatter.dart';
import '../../shared/models/movement_model.dart';
import 'app_badge.dart';

class MovementItem extends StatelessWidget {
  final MovementModel movement;
  final VoidCallback? onTap;

  const MovementItem({super.key, required this.movement, this.onTap});

  @override
  Widget build(BuildContext context) {
    final (icon, dotColor, qtyColor, qtyPrefix) = switch (movement.type) {
      'entry'    => ('⬇️', AppColors.green.withValues(alpha: 0.15),  AppColors.green,  '+'),
      'exit'     => ('⬆️', AppColors.red.withValues(alpha: 0.15),    AppColors.red,    '-'),
      'transfer' => ('🔄', AppColors.cyan.withValues(alpha: 0.15),   AppColors.cyan,   '×'),
      _          => ('⚙️', AppColors.purple.withValues(alpha: 0.15), AppColors.purple, '~'),
    };

    final (badgeLabel, badgeColor) = switch (movement.status) {
      'validated' => ('Validé',     BadgeColor.green),
      'rejected'  => ('Rejeté',     BadgeColor.red),
      _           => ('En attente', BadgeColor.orange),
    };

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: dotColor, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movement.productName, style: const TextStyle(
                    fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w600,
                  )),
                  Text(
                    '${movement.userName ?? ''} · ${DateFormatter.relative(movement.createdAt)}',
                    style: const TextStyle(fontFamily: 'DMSans', fontSize: 10,
                        color: AppColors.darkText3),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$qtyPrefix${movement.quantity}', style: TextStyle(
                  fontFamily: 'DMSans', fontSize: 13,
                  fontWeight: FontWeight.w800, color: qtyColor,
                )),
                const SizedBox(height: 2),
                AppBadge(label: badgeLabel, color: badgeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
