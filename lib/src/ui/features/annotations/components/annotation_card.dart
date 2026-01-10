import 'package:annotations_app/src/data/models/annotation.dart';
import 'package:annotations_app/src/ui/core/components/useful/section_header.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/core/components/inputs/custom_text_form_field.dart';
import 'package:annotations_app/src/ui/core/components/useful/custom_toast.dart';
import 'package:annotations_app/src/utils/%20utils.dart';
import 'package:flutter/material.dart';

class AnnotationCard extends StatelessWidget {
  final Annotation _annotation;
  final Future<void> Function(Annotation updated) onConfirmEdit;
  final Future<void> Function(int id) onConfirmDelete;

  const AnnotationCard({
    super.key,
    required Annotation annotation,
    required this.onConfirmEdit,
    required this.onConfirmDelete,
  }) : _annotation = annotation;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showDialogNote(context, _annotation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.secondary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _annotation.title,
                    style: AppTextStyles.textBold16.copyWith(
                      color: cs.inversePrimary,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async => _showDialogEdit(context, _annotation),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.edit_rounded,
                  color: cs.primary.withAlpha(150),
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async => _showDeleteConfirmation(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogNote(
    BuildContext context,
    Annotation annotation,
  ) async {
    final cs = Theme.of(context).colorScheme;

    final content = annotation.content;
    final totalChars = content.length;
    final totalLetters = Utils.countLetters(content);
    final totalNumbers = Utils.countNumbers(content);
    final totalEmpty = Utils.countEmpty(content);
    final totalSpecial = Utils.countSpecial(content);

    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withAlpha(102),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, animation, secondaryAnimation) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cs.secondary,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.sticky_note_2_outlined,
                        size: 22,
                        color: cs.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        annotation.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.textBold18.copyWith(
                          color: cs.inversePrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cs.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: cs.primary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionHeader(title: 'Conteúdo'),
                const SizedBox(height: 6),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 110,
                    minHeight: 110,
                    minWidth: double.infinity,
                  ),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: cs.outline.withValues(alpha: 0.08),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      annotation.content,
                      style: AppTextStyles.text14.copyWith(
                        color: cs.inversePrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SectionHeader(title: 'Detalhes'),
                const SizedBox(height: 6),
                _StatsGrid(
                  totalChars: totalChars,
                  totalLetters: totalLetters,
                  totalNumbers: totalNumbers,
                  totalEmpty: totalEmpty,
                  totalSpecial: totalSpecial,
                  totalEdits: annotation.editCount,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (context, anim, secondaryAnim, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final cs = Theme.of(context).colorScheme;

    final bool? confirmed = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withAlpha(102),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: cs.secondary,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(26),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Deletar',
                  style: AppTextStyles.textBold20.copyWith(
                    color: cs.inversePrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Remover "${_annotation.title}"?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.text16.copyWith(color: cs.primary),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context, false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: cs.surface,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'Cancelar',
                              style: AppTextStyles.text16.copyWith(
                                color: cs.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context, true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'Remover',
                              style: AppTextStyles.text16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (context, anim, secondaryAnim, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );

    if (confirmed == true && _annotation.id != null) {
      await onConfirmDelete(_annotation.id!);
    }
  }

  Future<void> _showDialogEdit(
    BuildContext context,
    Annotation annotation,
  ) async {
    final cs = Theme.of(context).colorScheme;
    final CustomToast customToast = CustomToast();

    final titleController = TextEditingController(text: annotation.title);
    final contentController = TextEditingController(text: annotation.content);

    final Annotation? updated = await showGeneralDialog<Annotation?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withAlpha(102),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, animation, secondaryAnimation) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: cs.secondary,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Editar',
                      style: AppTextStyles.textBold20.copyWith(
                        color: cs.inversePrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  padding: EdgeInsets.zero,
                  controller: titleController,
                  hintText: 'Título',
                  borderRadius: 12,
                  fillColor: cs.surface,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  padding: EdgeInsets.zero,
                  controller: contentController,
                  hintText: 'Digite aqui o conteúdo da nota...',
                  borderRadius: 12,
                  minLines: 6,
                  maxLines: 6,
                  fillColor: cs.surface,
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(dialogContext, null),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: cs.surface,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'Cancelar',
                              style: AppTextStyles.text16.copyWith(
                                color: cs.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          final title = titleController.text.trim();
                          final content = contentController.text;

                          if (title.isEmpty || content.isEmpty) {
                            customToast.showToast(
                              dialogContext,
                              message: 'Campo(s) obrigatório(s) vazio(s)!',
                              toastType: 'error',
                            );
                            return;
                          }

                          final updated = annotation.copyWith(
                            title: title,
                            content: content,
                          );

                          Navigator.pop(dialogContext, updated);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'Editar',
                              style: AppTextStyles.text16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (context, anim, secondaryAnim, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );

    if (updated != null) {
      await onConfirmEdit(updated);
    }
  }
}

class _StatsGrid extends StatelessWidget {
  final int totalChars;
  final int totalLetters;
  final int totalNumbers;
  final int totalEmpty;
  final int totalSpecial;
  final int totalEdits;

  const _StatsGrid({
    required this.totalChars,
    required this.totalLetters,
    required this.totalNumbers,
    required this.totalEmpty,
    required this.totalSpecial,
    required this.totalEdits,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget tile(String label, int value, IconData icon, Color iconColor) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outline.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: AppTextStyles.textBold12.copyWith(
                      color: cs.primary.withValues(alpha: 0.55),
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value.toString(),
                    style: AppTextStyles.textBold16.copyWith(
                      color: cs.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: tile(
                'Edições',
                totalEdits,
                Icons.edit_rounded,
                Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: tile(
                'Caracteres',
                totalChars,
                Icons.text_fields_rounded,
                Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: tile(
                'Letras',
                totalLetters,
                Icons.abc_rounded,
                Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: tile(
                'Números',
                totalNumbers,
                Icons.pin_rounded,
                Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: tile(
                'Vazios (em branco)',
                totalEmpty,
                Icons.space_bar_rounded,
                cs.inversePrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: tile(
                'Especiais (ex: "!@#%")',
                totalSpecial,
                Icons.code_rounded,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
