import 'package:annotations_app/src/ui/core/themes/app_colors.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomToast {
  void showToast(
    BuildContext context, {
    required String message,
    required String toastType,
  }) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    Icon? getIconDefault() {
      switch (toastType) {
        case 'info':
          return Icon(Icons.info_outline_rounded, color: AppColors.info);
        case 'warning':
          return Icon(Icons.warning_amber_rounded, color: AppColors.warning);
        case 'success':
          return Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.success,
          );
        case 'error':
          return Icon(Icons.error_outline_rounded, color: AppColors.error);
        default:
          return Icon(Icons.info_outline_rounded, color: cs.onPrimary);
      }
    }

    BotToast.showCustomNotification(
      onlyOne: true, // Mantém somente uma notificação por vez
      enableSlideOff: true, // Habilita deslizar para fechar
      dismissDirections: [DismissDirection.horizontal, DismissDirection.up],
      duration: const Duration(seconds: 4),
      toastBuilder: (cancelFunc) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: cs.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getIconDefault()!,
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        message,
                        style: AppTextStyles.text14.copyWith(
                          color: cs.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
