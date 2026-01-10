import 'package:annotations_app/src/data/models/annotations_details.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class RecordsSummaryCard extends StatelessWidget {
  final AnnotationsDetails details;

  const RecordsSummaryCard({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _RecordItem(
            label: 'Criados',
            value: details.totalCreated,
            color: Colors.orange,
            icon: Icons.sticky_note_2_outlined,
          ),
          _VerticalDivider(),
          _RecordItem(
            label: 'Ativos',
            value: details.totalActive,
            color: Colors.green,
            icon: Icons.check_circle_outline_outlined,
          ),
          _VerticalDivider(),
          _RecordItem(
            label: 'Deletados',
            value: details.totalDeleted,
            color: Colors.red,
            icon: Icons.delete_outline_outlined,
          ),
        ],
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;

  const _RecordItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(26),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 4),
              Text(
                value.toString(),
                style: AppTextStyles.textBold20.copyWith(
                  color: cs.inversePrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.text12.copyWith(
            color: cs.primary.withAlpha(150),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(height: 36, width: 1, color: cs.primary.withAlpha(50));
  }
}
