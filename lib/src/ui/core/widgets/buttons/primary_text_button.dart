import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryTextButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool disable;
  final bool? isLoading;
  final String text;
  final IconData? icon;
  final bool rtlText;

  const PrimaryTextButton({
    super.key,
    this.onPressed,
    required this.disable,
    this.isLoading,
    required this.text,
    this.icon,
    this.rtlText = false,
  });

  @override
  State<PrimaryTextButton> createState() => _PrimaryTextButtonState();
}

class _PrimaryTextButtonState extends State<PrimaryTextButton> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final Color backgroundColor = widget.disable
        ? cs.primary.withValues(alpha: 0.4)
        : cs.primary;

    final Color textColor = widget.disable
        ? cs.onPrimary.withValues(alpha: 0.7)
        : cs.onPrimary;

    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: backgroundColor,
      ),
      onPressed: !widget.disable ? widget.onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.rtlText && widget.icon != null) ...[
            Icon(widget.icon, color: textColor),
            const SizedBox(width: 6),
          ],
          Text(
            widget.text,
            style: AppTextStyles.textBold18.copyWith(
              color: textColor,
            ),
          ),
          if (!widget.rtlText && widget.icon != null) ...[
            const SizedBox(width: 6),
            Icon(widget.icon, color: textColor),
          ],
        ],
      ),
    );
  }
}
