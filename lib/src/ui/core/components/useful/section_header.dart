import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Text(
      title.toUpperCase(),
      style: AppTextStyles.textBold12.copyWith(
        color: cs.primary.withValues(alpha: 0.5),
      ),
    );
  }
}
