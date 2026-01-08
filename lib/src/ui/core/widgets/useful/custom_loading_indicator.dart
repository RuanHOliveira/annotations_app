import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double? size;

  const CustomLoadingIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Center(
      child: CircularProgressIndicator(
        // color: cs.onPrimary.withValues(alpha: 0.9),
        color: cs.inversePrimary,
        strokeWidth: 2.5,
      ),
    );
  }
}
