import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/core/widgets/inputs/custom_text_form_field.dart';
import 'package:annotations_app/src/ui/core/widgets/useful/custom_toast.dart';
import 'package:annotations_app/src/ui/features/annotations/annotations_controller.dart';
import 'package:annotations_app/src/ui/features/annotations/components/annotation_card.dart';
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
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverAppBar(
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Notas',
            style: AppTextStyles.textBold22.copyWith(
              color: cs.inversePrimary,
              letterSpacing: -0.5,
            ),
          ),
          leading: Row(
            children: [
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.menu_rounded,
                    color: cs.inversePrimary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SectionHeader(title: 'Minhas notas'),
                  _AddButton(onTap: () => _showAddAnnotation(context)),
                ],
              ),
              const SizedBox(height: 6),
              Observer(
                builder: (_) {
                  if (widget._annotationsController.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final list = widget._annotationsController.annotations;

                  if (list.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: const _EmptyState(
                        icon: Icons.sticky_note_2_outlined,
                        title: 'Nenhuma nota criada',
                        subtitle: 'Clique em Novo para iniciar',
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      children: list
                          .map(
                            (a) => AnnotationCard(
                              annotation: a,
                              onConfirmEdit: (updated) async {
                                await widget._annotationsController.update(
                                  updated,
                                );
                              },
                              onConfirmDelete: (id) async {
                                await widget._annotationsController.delete(id);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _showAddAnnotation(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _AddAnnotation(
        annotationsController: widget._annotationsController,
        userId: 1, // TODO: pegar da sessão
      ),
    );
  }
}

class _AddAnnotation extends StatefulWidget {
  final AnnotationsController annotationsController;
  final int userId;

  const _AddAnnotation({
    required this.annotationsController,
    required this.userId,
  });

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
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      customToast.showToast(
        context,
        message: 'Campo(s) obrigatório(s) vazio(s)!',
        toastType: 'error',
      );
      return;
    }

    await widget.annotationsController.create(
      userId: widget.userId,
      title: title,
      content: content,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nova nota',
              style: AppTextStyles.textBold20.copyWith(
                color: cs.inversePrimary,
              ),
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
                    style: AppTextStyles.textBold16.copyWith(
                      color: cs.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

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

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

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
              icon,
              size: 32,
              color: cs.primary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.textBold14.copyWith(color: cs.primary),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.text12.copyWith(
              color: cs.primary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
    );
  }
}
