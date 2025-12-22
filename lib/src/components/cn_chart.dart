import '../../cn_ui.dart';

/// Chart type variants for [CnChartSeries].
enum CnChartType { bar, line, area }

/// A data point in a [CnChartSeries].
class CnChartPoint {
  final String label;
  final double value;

  const CnChartPoint(this.label, this.value);
}

/// A data series for [CnChart].
class CnChartSeries {
  final String name;
  final List<CnChartPoint> data;
  final CnChartType type;
  final Color? color;
  final double lineWidth;
  final Color? fillColor;
  final bool showPoints;

  const CnChartSeries({
    required this.name,
    required this.data,
    this.type = .bar,
    this.color,
    this.lineWidth = 2,
    this.fillColor,
    this.showPoints = true,
  });
}

/// A simple chart component for displaying bar, line, and area charts.
///
/// Provides basic charting functionality with customizable series, grid, and legend.
class CnChart extends StatelessWidget {
  final List<CnChartSeries> series;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool showLegend;
  final bool showGrid;
  final int gridLines;
  final TextStyle? labelStyle;

  const CnChart({
    super.key,
    required this.series,
    this.height = 220,
    this.padding = const EdgeInsets.all(16),
    this.showLegend = true,
    this.showGrid = true,
    this.gridLines = 4,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final labels = _resolveLabels(series);
    final resolvedSeries = _resolveSeries(context, labels, series);
    final legendItems = [
      for (final entry in resolvedSeries)
        CnChartLegendItem(label: entry.name, color: entry.color),
    ];
    final resolvedPadding = padding.resolve(Directionality.of(context));

    final chart = SizedBox(
      height: height,
      child: CustomPaint(
        painter: _CnChartPainter(
          labels: labels,
          series: resolvedSeries,
          padding: resolvedPadding,
          showGrid: showGrid,
          gridLines: gridLines,
          gridColor: scheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
    );

    final labelRow = labels.isEmpty
        ? null
        : Row(
            children: [
              for (final label in labels)
                Expanded(
                  child: Text(
                    label,
                    textAlign: .center,
                    style:
                        labelStyle ??
                        CnTheme.textThemeOf(context).bodySmall?.copyWith(
                          color: CnTheme.colorSchemeOf(
                            context,
                          ).onSurfaceVariant,
                        ),
                  ),
                ),
            ],
          );

    return Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        chart,
        if (labelRow != null) labelRow,
        if (showLegend) CnChartLegend(items: legendItems),
      ],
    );
  }

  List<String> _resolveLabels(List<CnChartSeries> series) {
    final labels = <String>[];
    final seen = <String>{};
    for (final entry in series) {
      for (final point in entry.data) {
        if (seen.add(point.label)) {
          labels.add(point.label);
        }
      }
    }
    return labels;
  }

  List<_CnChartSeriesLayout> _resolveSeries(
    BuildContext context,
    List<String> labels,
    List<CnChartSeries> series,
  ) {
    final scheme = CnTheme.colorSchemeOf(context);
    final palette = [
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      scheme.error,
    ];

    return [
      for (var index = 0; index < series.length; index++)
        _CnChartSeriesLayout(
          name: series[index].name,
          type: series[index].type,
          color: series[index].color ?? palette[index % palette.length],
          lineWidth: series[index].lineWidth,
          fillColor: series[index].fillColor,
          showPoints: series[index].showPoints,
          values: [
            for (final label in labels)
              series[index].data
                  .firstWhere(
                    (point) => point.label == label,
                    orElse: () => const CnChartPoint('', 0),
                  )
                  .value,
          ],
        ),
    ];
  }
}

class CnChartLegend extends StatelessWidget {
  final List<CnChartLegendItem> items;
  final double spacing;
  final double runSpacing;

  const CnChartLegend({
    super.key,
    required this.items,
    this.spacing = 12,
    this.runSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CnTheme.textThemeOf(context).bodySmall?.copyWith(
      color: CnTheme.colorSchemeOf(context).onSurfaceVariant,
    );

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: [
        for (final entry in items)
          Row(
            mainAxisSize: .min,
            spacing: 6,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: entry.color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Text(entry.label, style: textStyle),
            ],
          ),
      ],
    );
  }
}

class CnChartLegendItem {
  final String label;
  final Color color;

  const CnChartLegendItem({required this.label, required this.color});
}

class _CnChartSeriesLayout {
  final String name;
  final List<double> values;
  final CnChartType type;
  final Color color;
  final double lineWidth;
  final Color? fillColor;
  final bool showPoints;

  const _CnChartSeriesLayout({
    required this.name,
    required this.values,
    required this.type,
    required this.color,
    required this.lineWidth,
    required this.fillColor,
    required this.showPoints,
  });
}

class _CnChartPainter extends CustomPainter {
  final List<String> labels;
  final List<_CnChartSeriesLayout> series;
  final EdgeInsets padding;
  final bool showGrid;
  final int gridLines;
  final Color gridColor;

  const _CnChartPainter({
    required this.labels,
    required this.series,
    required this.padding,
    required this.showGrid,
    required this.gridLines,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (labels.isEmpty || series.isEmpty) {
      return;
    }

    final chartRect = Rect.fromLTWH(
      padding.left,
      padding.top,
      size.width - padding.horizontal,
      size.height - padding.vertical,
    );

    if (chartRect.width <= 0 || chartRect.height <= 0) {
      return;
    }

    final maxValue = _resolveMaxValue(series);
    final valueScale = maxValue == 0 ? 1.0 : maxValue;

    if (showGrid && gridLines > 0) {
      final gridPaint = Paint()..color = gridColor;
      for (var i = 0; i <= gridLines; i++) {
        final y = chartRect.bottom - (chartRect.height / gridLines) * i;
        canvas.drawLine(
          Offset(chartRect.left, y),
          Offset(chartRect.right, y),
          gridPaint,
        );
      }
    }

    _paintBars(canvas, chartRect, valueScale);
    _paintAreas(canvas, chartRect, valueScale);
    _paintLines(canvas, chartRect, valueScale);
  }

  void _paintBars(Canvas canvas, Rect rect, double maxValue) {
    final barSeries = series.where((entry) => entry.type == .bar).toList();
    if (barSeries.isEmpty) {
      return;
    }

    final groupCount = labels.length;
    final groupWidth = rect.width / groupCount;
    final barGroupWidth = groupWidth * 0.7;
    final barWidth = barGroupWidth / barSeries.length;
    final inset = (groupWidth - barGroupWidth) / 2;

    for (var seriesIndex = 0; seriesIndex < barSeries.length; seriesIndex++) {
      final entry = barSeries[seriesIndex];
      final paint = Paint()..color = entry.color;

      for (var index = 0; index < entry.values.length; index++) {
        final value = entry.values[index];
        final barHeight = (value / maxValue) * rect.height;
        final left =
            rect.left + (groupWidth * index) + inset + barWidth * seriesIndex;
        final top = rect.bottom - barHeight;
        final barRect = Rect.fromLTWH(left, top, barWidth, barHeight);
        final radius = Radius.circular(barWidth * 0.3);
        canvas.drawRRect(
          RRect.fromRectAndCorners(barRect, topLeft: radius, topRight: radius),
          paint,
        );
      }
    }
  }

  void _paintLines(Canvas canvas, Rect rect, double maxValue) {
    final lineSeries = series
        .where((entry) => entry.type == .line || entry.type == .area)
        .toList();
    if (lineSeries.isEmpty) {
      return;
    }

    final count = labels.length;
    final step = count == 1 ? 0.0 : rect.width / (count - 1);

    for (final entry in lineSeries) {
      final path = Path();
      final paint = Paint()
        ..color = entry.color
        ..strokeWidth = entry.lineWidth
        ..style = PaintingStyle.stroke;

      for (var index = 0; index < entry.values.length; index++) {
        final value = entry.values[index];
        final x = rect.left + step * index;
        final y = rect.bottom - (value / maxValue) * rect.height;
        if (index == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);

      if (entry.showPoints) {
        final pointPaint = Paint()..color = entry.color;
        for (var index = 0; index < entry.values.length; index++) {
          final value = entry.values[index];
          final x = rect.left + step * index;
          final y = rect.bottom - (value / maxValue) * rect.height;
          canvas.drawCircle(Offset(x, y), 3, pointPaint);
        }
      }
    }
  }

  void _paintAreas(Canvas canvas, Rect rect, double maxValue) {
    final areaSeries = series.where((entry) => entry.type == .area).toList();
    if (areaSeries.isEmpty) {
      return;
    }

    final count = labels.length;
    final step = count == 1 ? 0.0 : rect.width / (count - 1);

    for (final entry in areaSeries) {
      final path = Path();
      for (var index = 0; index < entry.values.length; index++) {
        final value = entry.values[index];
        final x = rect.left + step * index;
        final y = rect.bottom - (value / maxValue) * rect.height;
        if (index == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.lineTo(rect.right, rect.bottom);
      path.lineTo(rect.left, rect.bottom);
      path.close();

      final fillPaint = Paint()
        ..color = entry.fillColor ?? entry.color.withValues(alpha: 0.18)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }
  }

  double _resolveMaxValue(List<_CnChartSeriesLayout> series) {
    var maxValue = 0.0;
    for (final entry in series) {
      for (final value in entry.values) {
        if (value > maxValue) {
          maxValue = value;
        }
      }
    }
    return maxValue;
  }

  @override
  bool shouldRepaint(covariant _CnChartPainter oldDelegate) {
    return oldDelegate.labels != labels ||
        oldDelegate.series != series ||
        oldDelegate.padding != padding ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.gridLines != gridLines ||
        oldDelegate.gridColor != gridColor;
  }
}
