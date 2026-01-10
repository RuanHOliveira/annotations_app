import 'package:annotations_app/src/ui/core/components/useful/custom_app_bar.dart';
import 'package:annotations_app/src/ui/core/components/useful/section_header.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/core/components/inputs/custom_text_form_field.dart';
import 'package:annotations_app/src/ui/core/components/useful/custom_toast.dart';
import 'package:annotations_app/src/ui/features/annotations/annotations_controller.dart';
import 'package:annotations_app/src/ui/features/annotations/components/annotation_card.dart';
import 'package:annotations_app/src/ui/features/annotations/components/custom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AnnotationsScreen extends StatefulWidget {
  final AnnotationsController _annotationsController;

  const AnnotationsScreen({
    super.key,
    required AnnotationsController annotationsController,
  }) : _annotationsController = annotationsController;

  @override
  State<AnnotationsScreen> createState() => _AnnotationsScreenState();
}

class _AnnotationsScreenState extends State<AnnotationsScreen> {
  @override
  void initState() {
    super.initState();
    widget._annotationsController.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CustomAppBar(
          title: 'Notas',
          actions: [
            CustomActions(annotationsController: widget._annotationsController),
          ],
        ),
        SliverPadding(
          padding: padding,
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionHeader(title: 'Minhas notas'),
                    GestureDetector(
                      onTap: () => _showAddAnnotation(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: cs.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Novo',
                          style: AppTextStyles.textBold12.copyWith(
                            color: cs.primary.withValues(alpha: 0.5),
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
        Observer(
          builder: (_) {
            if (widget._annotationsController.isLoading) {
              return SliverPadding(
                padding: padding,
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: cs.inversePrimary,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              );
            }

            if (widget._annotationsController.annotations.isEmpty) {
              return SliverPadding(
                padding: padding,
                sliver: const SliverToBoxAdapter(child: _EmptyState()),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final annotation =
                        widget._annotationsController.annotations[index];

                    return AnnotationCard(
                      annotation: annotation,
                      onConfirmEdit: (updated) async {
                        await widget._annotationsController.update(updated);
                      },
                      onConfirmDelete: (id) async {
                        await widget._annotationsController.delete(id);
                      },
                    );
                  },
                  childCount: widget._annotationsController.annotations.length,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showAddAnnotation(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) =>
          _AddAnnotation(annotationsController: widget._annotationsController),
    );
  }
}

class _AddAnnotation extends StatefulWidget {
  final AnnotationsController annotationsController;

  const _AddAnnotation({required this.annotationsController});

  @override
  State<_AddAnnotation> createState() => _AddAnnotationState();
}

class _AddAnnotationState extends State<_AddAnnotation> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final CustomToast customToast = CustomToast();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _addAnnotation() async {
    final title = _titleController.text.trim();
    final content = _contentController.text;

    if (title.isEmpty || content.isEmpty) {
      customToast.showToast(
        context,
        message: 'Campo(s) obrigatório(s) vazio(s)!',
        toastType: 'error',
      );
      return;
    }

    await widget.annotationsController.create(title: title, content: content);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        bottomInset > 0 ? bottomInset + 16 : 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nova nota',
            style: AppTextStyles.textBold20.copyWith(color: cs.inversePrimary),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            padding: EdgeInsets.all(0),
            controller: _titleController,
            hintText: 'Título',
            borderRadius: 12,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            padding: EdgeInsets.all(0),
            controller: _contentController,
            hintText: 'Digite aqui o conteúdo da nota...',
            borderRadius: 12,
            minLines: 6,
            maxLines: 6,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async => _addAnnotation(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: cs.inversePrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Adicionar',
                  style: AppTextStyles.textBold16.copyWith(color: cs.secondary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: cs.secondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cs.outline.withValues(alpha: 0.1),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.sticky_note_2_outlined,
              size: 32,
              color: cs.primary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma nota criada',
            style: AppTextStyles.textBold14.copyWith(color: cs.primary),
          ),
          const SizedBox(height: 4),
          Text(
            'Clique em Novo para iniciar',
            style: AppTextStyles.text12.copyWith(
              color: cs.primary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
