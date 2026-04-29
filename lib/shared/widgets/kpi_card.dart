import 'package:flutter/material.dart';
import 'app_card.dart';

class KpiCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color valueColor;

  const KpiCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(
            fontFamily: 'DMSans', fontSize: 24,
            fontWeight: FontWeight.w800, color: valueColor, height: 1,
          )),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(
            fontFamily: 'DMSans', fontSize: 10,
            fontWeight: FontWeight.w500,
          )),
        ],
      ),
    );
  }
}
