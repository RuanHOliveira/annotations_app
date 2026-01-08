import 'package:annotations_app/src/ui/core/widgets/navigation/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AnnotationsScreen extends StatefulWidget {
  const AnnotationsScreen({super.key});

  @override
  State<AnnotationsScreen> createState() => _AnnotationsScreenState();
}

class _AnnotationsScreenState extends State<AnnotationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Anotações',
          showDrawerButton: true,
          showBackButton: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            ],
          ),
        ),
      ],
    );
  }
}
