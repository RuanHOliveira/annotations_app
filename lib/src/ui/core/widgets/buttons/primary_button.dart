import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/core/widgets/useful/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool disable;
  final bool? isLoading;
  final String text;
  final IconData? icon;
  final double? inkHeight;
  final double? inkWidth;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.disable,
    this.isLoading = false,
    this.onPressed,
    this.inkHeight,
    this.borderRadius,
    this.inkWidth,
    this.textStyle,
    this.icon,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final BorderRadius borderRadius =
        widget.borderRadius ?? const BorderRadius.all(Radius.circular(12));

    final Color backgroundColor = widget.disable
        ? cs.secondary.withValues(alpha: 0.4)
        : cs.secondary;

    final Color textColor = widget.disable
        ? cs.onSecondary.withValues(alpha: 0.7)
        : cs.onSecondary;

    return Material(
      color: Colors.transparent,
      child: Ink(
        height: widget.inkHeight ?? 54.0,
        width: widget.inkWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: !widget.disable ? widget.onPressed : null,
          splashColor: cs.onSecondary.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          child: Center(
            child: widget.isLoading!
                ? const CustomLoadingIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, color: textColor),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style:
                            widget.textStyle ??
                            AppTextStyles.text18.copyWith(
                              color: textColor,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
