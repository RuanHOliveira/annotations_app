import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/features/details/details_controller.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final DetailsController _detailsController;

  const DetailsScreen({super.key, required DetailsController detailsController})
    : _detailsController = detailsController;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
            'Detalhes',
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
                children: [_SectionHeader(title: 'Filtros')],
              ),
              const SizedBox(height: 6),
              // if (widget.workoutsViewModel.myWorkouts.isEmpty)
              //   _EmptyState(
              //     icon: Icons.assignment_rounded,
              //     title: 'Nenhuma Detalhes criada',
              //     subtitle: 'Clique em Novo para iniciar',
              //   ),
              // ...widget.workoutsViewModel.myWorkouts.map(
              //   (workout) => WorkoutCard(selectedDate: DateTime.now()),
              // ),
            ]),
          ),
        ),
      ],
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
