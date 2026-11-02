import 'dart:math' as math;

import '../../cn_ui.dart';

/// Chart type variants for [CnChartSeries].
enum CnChartType { bar, line, area }

/// A data point in a [CnChartSeries].
class CnChartPoint {
  const CnChartPoint(this.label, this.value);
  final String label;
  final double value;
}

/// A data series for [CnChart].
class CnChartSeries {
  const CnChartSeries({
    required this.name,
    required this.data,
    this.type = .bar,
    this.color,
    this.lineWidth = 2,
    this.fillColor,
    this.showPoints = true,
  });
  final String name;
  final List<CnChartPoint> data;
  final CnChartType type;
  final Color? color;
  final double lineWidth;
  final Color? fillColor;
  final bool showPoints;
}

/// A simple chart component for displaying bar, line, and area charts.
///
/// Provides basic charting functionality with customizable series, grid, and legend.
class CnChart extends StatelessWidget {
  const CnChart({
    super.key,
    required this.series,
    this.height = 220,
    this.showLegend = true,
    this.showGrid = true,
    this.gridLines = 4,
    this.stacked = false,
    this.curved = false,
  });
  final List<CnChartSeries> series;
  final double height;
  final bool showLegend;
  final bool showGrid;
  final int gridLines;

  /// Puts each series on top of the ones before it.
  final bool stacked;

  /// Draws lines and areas as smooth curves.
  final bool curved;

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;
    final labels = _resolveLabels(series);
    final resolvedSeries = _resolveSeries(context, labels, series);
    final legendItems = [
      for (final entry in resolvedSeries)
        CnChartLegendItem(label: entry.name, color: entry.color),
    ];

    final chart = SizedBox(
      height: height,
      child: CustomPaint(
        painter: _CnChartPainter(
          labels: labels,
          series: resolvedSeries,
          padding: const EdgeInsets.all(16),
          showGrid: showGrid,
          gridLines: gridLines,
          gridColor: colors.border.withValues(alpha: 0.4),
          stacked: stacked,
          curved: curved,
        ),
      ),
    );

    final hasBars = series.any((entry) => entry.type == .bar);
    final labelRow = labels.isEmpty
        ? null
        : Padding(
            padding: const .symmetric(horizontal: 16),
            child: SizedBox(
              height: 16,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Shows only as many labels as fit next to each other.
                  final stride = math.max(
                    1,
                    (labels.length * 64 / constraints.maxWidth).ceil(),
                  );
                  final last = math.max(1, labels.length - 1);
                  return Stack(
                    children: [
                      for (var i = 0; i < labels.length; i += stride)
                        Align(
                          alignment: Alignment(
                            hasBars
                                ? (i + 0.5) / labels.length * 2 - 1
                                : i / last * 2 - 1,
                            0,
                          ),
                          child: Text(
                            labels[i],
                            maxLines: 1,
                            softWrap: false,
                            style: CnTheme.of(context).text.xs
                                .copyWith(color: colors.mutedForeground),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          );

    return Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        chart,
        ?labelRow,
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
    final colors = CnTheme.of(context).colors;
    final palette = colors.charts;
    final totals = List.filled(labels.length, 0.0);

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
            for (var i = 0; i < labels.length; i++)
              totals[i] =
                  (stacked ? totals[i] : 0) +
                  series[index].data
                      .firstWhere(
                        (point) => point.label == labels[i],
                        orElse: () => const CnChartPoint('', 0),
                      )
                      .value,
          ],
        ),
    ];
  }
}

class CnChartLegend extends StatelessWidget {
  const CnChartLegend({
    super.key,
    required this.items,
    this.spacing = 12,
    this.runSpacing = 8,
  });
  final List<CnChartLegendItem> items;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    final textStyle = CnTheme.of(context).text.xs
        .copyWith(color: CnTheme.of(context).colors.mutedForeground);

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
  const CnChartLegendItem({required this.label, required this.color});
  final String label;
  final Color color;
}

class _CnChartSeriesLayout {
  const _CnChartSeriesLayout({
    required this.name,
    required this.values,
    required this.type,
    required this.color,
    required this.lineWidth,
    required this.fillColor,
    required this.showPoints,
  });
  final String name;
  final List<double> values;
  final CnChartType type;
  final Color color;
  final double lineWidth;
  final Color? fillColor;
  final bool showPoints;
}

class _CnChartPainter extends CustomPainter {
  const _CnChartPainter({
    required this.labels,
    required this.series,
    required this.padding,
    required this.showGrid,
    required this.gridLines,
    required this.gridColor,
    required this.stacked,
    required this.curved,
  });
  final List<String> labels;
  final List<_CnChartSeriesLayout> series;
  final EdgeInsets padding;
  final bool showGrid;
  final int gridLines;
  final Color gridColor;
  final bool stacked;
  final bool curved;

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
    final count = labels.length;
    final step = count == 1 ? 0.0 : rect.width / (count - 1);

    for (final entry in lineSeries) {
      final paint = Paint()
        ..color = entry.color
        ..strokeWidth = entry.lineWidth
        ..style = .stroke;
      canvas.drawPath(_linePath(entry, rect, maxValue), paint);

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

  Path _linePath(_CnChartSeriesLayout entry, Rect rect, double maxValue) {
    final count = labels.length;
    final step = count == 1 ? 0.0 : rect.width / (count - 1);
    final path = Path();
    for (var index = 0; index < entry.values.length; index++) {
      final x = rect.left + step * index;
      final y = rect.bottom - (entry.values[index] / maxValue) * rect.height;
      if (index == 0) {
        path.moveTo(x, y);
      } else if (curved) {
        final previous =
            rect.bottom - (entry.values[index - 1] / maxValue) * rect.height;
        final middle = x - step / 2;
        path.cubicTo(middle, previous, middle, y, x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    return path;
  }

  void _paintAreas(Canvas canvas, Rect rect, double maxValue) {
    final areaSeries = series.where((entry) => entry.type == .area).toList();

    // The highest stack comes first, so the others stay visible on top of it.
    for (final entry in stacked ? areaSeries.reversed : areaSeries) {
      final path = _linePath(entry, rect, maxValue)
        ..lineTo(rect.right, rect.bottom)
        ..lineTo(rect.left, rect.bottom)
        ..close();
      final fillPaint = Paint()..style = .fill;
      if (entry.fillColor != null) {
        fillPaint.color = entry.fillColor!;
      } else {
        fillPaint.shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            entry.color.withValues(alpha: 0.6),
            entry.color.withValues(alpha: 0.1),
          ],
        ).createShader(rect);
      }
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
        oldDelegate.gridColor != gridColor ||
        oldDelegate.stacked != stacked ||
        oldDelegate.curved != curved;
  }
}
