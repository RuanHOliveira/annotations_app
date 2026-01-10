import 'package:annotations_app/src/ui/core/components/useful/custom_app_bar.dart';
import 'package:annotations_app/src/ui/core/components/useful/section_header.dart';
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
    final padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CustomAppBar(title: 'Detalhes'),
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SectionHeader(title: 'Detalhes'),
            ]),
          ),
        ),
      ],
    );
  }
}
