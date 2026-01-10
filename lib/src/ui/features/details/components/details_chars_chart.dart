import 'dart:math' as math;

import 'package:annotations_app/src/data/models/annotations_details.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/utils/%20utils.dart';
import 'package:flutter/material.dart';

class DetailsCharsChart extends StatelessWidget {
  final AnnotationsDetails details;
  final String selectedFilter;

  const DetailsCharsChart({
    super.key,
    required this.details,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final letters = Utils.lettersByFilter(details, selectedFilter);
    final numbers = Utils.numbersByFilter(details, selectedFilter);
    final empty = Utils.emptyByFilter(details, selectedFilter);
    final special = Utils.specialByFilter(details, selectedFilter);

    final total = letters + numbers + empty + special;
    final base = cs.inverseSurface;

    final raw = <_DonutSegment>[
      _DonutSegment(
        key: 'letters',
        label: 'Letras',
        value: letters,
        color: base,
      ),
      _DonutSegment(
        key: 'numbers',
        label: 'Números',
        value: numbers,
        color: base,
      ),
      _DonutSegment(key: 'empty', label: 'Vazios', value: empty, color: base),
      _DonutSegment(
        key: 'special',
        label: 'Especiais',
        value: special,
        color: base,
      ),
    ];

    const fixedOrder = <String, int>{
      'letters': 0,
      'numbers': 1,
      'empty': 2,
      'special': 3,
    };

    final ranked = [...raw]
      ..sort((a, b) {
        final byValue = b.value.compareTo(a.value);
        if (byValue != 0) return byValue;
        final ao = fixedOrder[a.key] ?? 999;
        final bo = fixedOrder[b.key] ?? 999;
        return ao.compareTo(bo);
      });

    const alphas = <double>[1.0, 0.75, 0.5, 0.3];

    final segments = <_DonutSegment>[
      for (var i = 0; i < ranked.length; i++)
        ranked[i].copyWith(
          color: base.withValues(alpha: alphas[i.clamp(0, alphas.length - 1)]),
        ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DonutChart(
            segments: segments,
            size: 100,
            strokeWidth: 16,
            backgroundColor: cs.surface,
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final s in segments) ...[
                  Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Text(
                          s.pctText(total),
                          textAlign: TextAlign.left,
                          style: AppTextStyles.textBold12.copyWith(
                            color: s.color,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      Text(
                        s.label,
                        style: AppTextStyles.textBold12.copyWith(
                          color: s.color,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        s.value.toString(),
                        style: AppTextStyles.textBold12.copyWith(
                          color: s.color,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DonutChart extends StatelessWidget {
  final List<_DonutSegment> segments;
  final double strokeWidth;
  final double size;
  final Color backgroundColor;

  const DonutChart({
    super.key,
    required this.segments,
    this.strokeWidth = 14,
    this.size = 140,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final total = segments.fold<int>(0, (s, e) => s + e.value);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DonutPainter(
          segments: segments,
          total: total,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<_DonutSegment> segments;
  final int total;
  final Color backgroundColor;
  final double strokeWidth;

  _DonutPainter({
    required this.segments,
    required this.total,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) / 2) - strokeWidth / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, radius, bgPaint);

    var startAngle = -math.pi / 2;
    for (final s in segments) {
      if (total == 0 || s.value == 0) continue;

      final sweep = 2 * math.pi * (s.value / total);

      final paint = Paint()
        ..color = s.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        false,
        paint,
      );

      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) {
    if (old.total != total ||
        old.backgroundColor != backgroundColor ||
        old.strokeWidth != strokeWidth ||
        old.segments.length != segments.length) {
      return true;
    }

    for (var i = 0; i < segments.length; i++) {
      if (old.segments[i].value != segments[i].value ||
          old.segments[i].color != segments[i].color) {
        return true;
      }
    }
    return false;
  }
}

class _DonutSegment {
  final String key;
  final String label;
  final int value;
  final Color color;

  const _DonutSegment({
    required this.key,
    required this.label,
    required this.value,
    required this.color,
  });

  _DonutSegment copyWith({
    String? key,
    String? label,
    int? value,
    Color? color,
  }) {
    return _DonutSegment(
      key: key ?? this.key,
      label: label ?? this.label,
      value: value ?? this.value,
      color: color ?? this.color,
    );
  }

  double pct(int total) => total == 0 ? 0.0 : value / total;
  String pctText(int total) => '${(pct(total) * 100).toStringAsFixed(0)}%';
}
