import 'package:annotations_app/src/ui/core/components/useful/custom_app_bar.dart';
import 'package:annotations_app/src/ui/core/components/useful/section_header.dart';
import 'package:annotations_app/src/ui/features/details/components/records_summary_card.dart';
import 'package:annotations_app/src/ui/features/details/components/summary_and_details_content_card.dart';
import 'package:annotations_app/src/ui/features/details/details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DetailsScreen extends StatefulWidget {
  final DetailsController _detailsController;

  const DetailsScreen({super.key, required DetailsController detailsController})
    : _detailsController = detailsController;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    widget._detailsController.load();
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
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        CustomAppBar(title: 'Detalhes'),
        Observer(
          builder: (_) {
            if (widget._detailsController.isLoading) {
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

            return SliverPadding(
              padding: padding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SectionHeader(title: 'Registros'),
                  const SizedBox(height: 6),
                  RecordsSummaryCard(
                    details: widget._detailsController.annotationsDetails,
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeader(title: 'Conteúdo'),
                      Wrap(
                        spacing: 6,
                        children: [
                          _FilterChip(
                            label: 'Todos',
                            isSelected:
                                widget._detailsController.selectedFilter ==
                                'Todos',
                            onTap: () =>
                                widget._detailsController.changeFilter('Todos'),
                          ),
                          _FilterChip(
                            label: 'Ativos',
                            isSelected:
                                widget._detailsController.selectedFilter ==
                                'Ativos',
                            onTap: () => widget._detailsController.changeFilter(
                              'Ativos',
                            ),
                          ),
                          _FilterChip(
                            label: 'Deletados',
                            isSelected:
                                widget._detailsController.selectedFilter ==
                                'Deletados',
                            onTap: () => widget._detailsController.changeFilter(
                              'Deletados',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SummaryAndDetailsContentCard(
                    details: widget._detailsController.annotationsDetails,
                    selectedFilter: widget._detailsController.selectedFilter,
                  ),
                ]),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? cs.inversePrimary : cs.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? cs.secondary : cs.primary,
          ),
        ),
      ),
    );
  }
}
