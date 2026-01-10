import 'package:annotations_app/src/data/models/annotations_details.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/features/details/components/details_chars_chart.dart';
import 'package:annotations_app/src/utils/%20utils.dart';
import 'package:flutter/material.dart';

class SummaryAndDetailsContentCard extends StatelessWidget {
  final AnnotationsDetails details;
  final String selectedFilter;

  const SummaryAndDetailsContentCard({
    super.key,
    required this.details,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final int edits = Utils.editsByFilter(details, selectedFilter);
    final int chars = Utils.charsByFilter(details, selectedFilter);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Resumo',
                style: AppTextStyles.textBold14.copyWith(
                  color: cs.inversePrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  selectedFilter,
                  style: AppTextStyles.textBold12.copyWith(
                    color: cs.primary.withAlpha(170),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _MetricTile(
            icon: Icons.edit_rounded,
            label: 'Edições',
            value: edits,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          _MetricTile(
            icon: Icons.text_fields_rounded,
            label: 'Caracteres',
            value: chars,
            color: Colors.orange,
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Text(
                'Detalhes',
                style: AppTextStyles.textBold14.copyWith(
                  color: cs.inversePrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DetailsCharsChart(details: details, selectedFilter: selectedFilter),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.text14.copyWith(color: cs.inversePrimary),
            ),
          ),
          Text(
            value.toString(),
            style: AppTextStyles.textBold16.copyWith(
              color: cs.inversePrimary,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
