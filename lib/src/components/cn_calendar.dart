import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';
import 'cn_select.dart';

/// Selection mode variants for [CnCalendar].
enum CnCalendarSelectionMode { single, range, multiple }

/// Header style variants for [CnCalendar].
enum CnCalendarHeaderVariant { chevrons, dropdowns }

/// A builder function for customizing day rendering in [CnCalendar].
typedef CnCalendarDayBuilder =
    Widget Function(
      BuildContext context,
      DateTime date,
      CnCalendarDayState state,
    );

/// State information for a calendar day in [CnCalendar].
@immutable
class CnCalendarDayState {
  final DateTime date;
  final bool isOutside;
  final bool isDisabled;
  final bool isToday;
  final bool isSelected;
  final bool inRange;
  final bool isRangeStart;
  final bool isRangeEnd;
  final TextStyle? textStyle;

  const CnCalendarDayState({
    required this.date,
    required this.isOutside,
    required this.isDisabled,
    required this.isToday,
    required this.isSelected,
    required this.inRange,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.textStyle,
  });

  bool get isRangeEdge => isRangeStart || isRangeEnd;
  bool get isRangeMiddle => inRange && !isRangeEdge;
}

/// A calendar component for selecting dates with single, range, or multiple selection modes.
///
/// Provides a full-featured calendar with navigation, weekday labels, and customizable day rendering.
///
/// See also:
///
///  * [CnDatePickerField], for a date picker input field.
class CnCalendar extends StatefulWidget {
  final CnCalendarSelectionMode selectionMode;
  final DateTime? selectedDate;
  final DateTimeRange? selectedRange;
  final Set<DateTime>? selectedDates;
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTimeRange>? onRangeSelected;
  final ValueChanged<Set<DateTime>>? onDatesSelected;
  final DateTime? focusedMonth;
  final ValueChanged<DateTime>? onMonthChanged;
  final bool showOutsideDays;
  final bool showWeekdayLabels;
  final int firstDayOfWeek;
  final List<String>? weekdayLabels;
  final bool Function(DateTime date)? isDateDisabled;
  final bool Function(DateTime date)? isDateSelectable;
  final CnCalendarDayBuilder? dayBuilder;
  final int monthsToDisplay;
  final CnCalendarHeaderVariant headerVariant;
  final int? firstYear;
  final int? lastYear;
  final EdgeInsetsGeometry padding;
  final double daySize;
  final double gridSpacing;

  const CnCalendar({
    super.key,
    this.selectionMode = .single,
    this.selectedDate,
    this.selectedRange,
    this.selectedDates,
    this.onDateSelected,
    this.onRangeSelected,
    this.onDatesSelected,
    this.focusedMonth,
    this.onMonthChanged,
    this.showOutsideDays = true,
    this.showWeekdayLabels = true,
    this.firstDayOfWeek = DateTime.monday,
    this.weekdayLabels,
    this.isDateDisabled,
    this.isDateSelectable,
    this.dayBuilder,
    this.monthsToDisplay = 1,
    this.headerVariant = CnCalendarHeaderVariant.chevrons,
    this.firstYear,
    this.lastYear,
    this.padding = const .all(12),
    this.daySize = 40,
    this.gridSpacing = 6,
  }) : assert(monthsToDisplay > 0, 'monthsToDisplay must be at least 1.');

  @override
  State<CnCalendar> createState() => _CnCalendarState();
}

class _CnCalendarState extends State<CnCalendar> {
  late DateTime _focusedMonth;
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Set<DateTime> _selectedDates = <DateTime>{};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedMonth = _monthStart(
      widget.focusedMonth ?? DateTime(now.year, now.month, 1),
    );
    _selectedDate = widget.selectedDate;
    _selectedDates = _normalizeDates(widget.selectedDates ?? const {});
    _syncRangeFromWidget();
  }

  @override
  void didUpdateWidget(covariant CnCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusedMonth != oldWidget.focusedMonth &&
        widget.focusedMonth != null) {
      _focusedMonth = _monthStart(widget.focusedMonth!);
    }
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
    if (widget.selectedDates != oldWidget.selectedDates) {
      _selectedDates = _normalizeDates(widget.selectedDates ?? const {});
    }
    if (widget.selectedRange != oldWidget.selectedRange) {
      _syncRangeFromWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final textTheme = CnTheme.textThemeOf(context);
    final weekdayLabels = _resolvedWeekdayLabels();
    final rangeStart = _rangeStart;
    final rangeEnd = _rangeEnd;
    final selectedDate = _selectedDate;
    final months = [
      for (var i = 0; i < widget.monthsToDisplay; i++)
        _monthAtOffset(_focusedMonth, i),
    ];

    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          _buildHeader(textTheme, months),
          Row(
            crossAxisAlignment: .start,
            spacing: widget.monthsToDisplay > 1 ? 24 : 0,
            children: [
              for (final month in months)
                Expanded(
                  child: _buildMonthView(
                    month,
                    scheme,
                    textTheme,
                    weekdayLabels,
                    selectedDate,
                    rangeStart,
                    rangeEnd,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme, List<DateTime> months) {
    final header = widget.headerVariant;
    if (header == CnCalendarHeaderVariant.dropdowns &&
        widget.monthsToDisplay == 1) {
      return Row(
        children: [
          CnButton(
            variant: .ghost,
            size: .icon,
            onPressed: _handlePreviousMonth,
            child: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: .center,
              spacing: 8,
              children: [
                SizedBox(
                  width: 120,
                  child: CnSelect<int>(
                    value: _focusedMonth.month,
                    items: [
                      for (var month = 1; month <= 12; month++)
                        DropdownMenuItem(
                          value: month,
                          child: Text(_monthName(month)),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      _updateFocusedMonth(
                        DateTime(_focusedMonth.year, value, 1),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: CnSelect<int>(
                    value: _focusedMonth.year,
                    items: [
                      for (final year in _yearOptions())
                        DropdownMenuItem(
                          value: year,
                          child: Text(year.toString()),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      _updateFocusedMonth(
                        DateTime(value, _focusedMonth.month, 1),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CnButton(
            variant: .ghost,
            size: .icon,
            onPressed: _handleNextMonth,
            child: const Icon(Icons.chevron_right),
          ),
        ],
      );
    }

    return Row(
      children: [
        CnButton(
          variant: .ghost,
          size: .icon,
          onPressed: _handlePreviousMonth,
          child: const Icon(Icons.chevron_left),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: .center,
            spacing: 24,
            children: [
              for (final month in months)
                Text(
                  '${_monthName(month.month)} ${month.year}',
                  style: textTheme.titleMedium,
                ),
            ],
          ),
        ),
        CnButton(
          variant: .ghost,
          size: .icon,
          onPressed: _handleNextMonth,
          child: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildMonthView(
    DateTime month,
    ColorScheme scheme,
    TextTheme textTheme,
    List<String> weekdayLabels,
    DateTime? selectedDate,
    DateTime? rangeStart,
    DateTime? rangeEnd,
  ) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        if (widget.showWeekdayLabels)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                for (final label in weekdayLabels)
                  Expanded(
                    child: SizedBox(
                      height: widget.daySize,
                      child: Center(
                        child: Text(
                          label,
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: widget.gridSpacing,
            crossAxisSpacing: widget.gridSpacing,
            mainAxisExtent: widget.daySize,
            childAspectRatio: 1,
          ),
          itemCount: 42,
          itemBuilder: (context, index) {
            final dayInfo = _resolveDay(month, index);
            if (dayInfo == null) {
              return const SizedBox.shrink();
            }
            return _buildDayCell(
              dayInfo.date,
              scheme,
              selectedDate,
              rangeStart,
              rangeEnd,
              dayInfo.isOutside,
            );
          },
        ),
      ],
    );
  }

  Widget _buildDayCell(
    DateTime date,
    ColorScheme scheme,
    DateTime? selectedDate,
    DateTime? rangeStart,
    DateTime? rangeEnd,
    bool isOutside,
  ) {
    if (isOutside && !widget.showOutsideDays) {
      return const SizedBox.shrink();
    }
    final isDisabled = _isDisabled(date);
    final isToday = _isSameDay(date, DateTime.now());
    final isSelectedSingle =
        widget.selectionMode == .single &&
        selectedDate != null &&
        _isSameDay(date, selectedDate);
    final isSelectedMultiple =
        widget.selectionMode == .multiple &&
        _selectedDates.any((item) => _isSameDay(item, date));
    final isSelected = isSelectedSingle || isSelectedMultiple;

    final inRange =
        widget.selectionMode == .range &&
        rangeStart != null &&
        rangeEnd != null &&
        !_isBefore(date, rangeStart) &&
        !_isAfter(date, rangeEnd);
    final isRangeStart =
        widget.selectionMode == .range &&
        rangeStart != null &&
        _isSameDay(date, rangeStart);
    final isRangeEnd =
        widget.selectionMode == .range &&
        rangeEnd != null &&
        _isSameDay(date, rangeEnd);
    final isRangeEdge = isRangeStart || isRangeEnd;

    final background = isSelected || isRangeEdge
        ? scheme.primary
        : inRange
        ? scheme.primary.withValues(alpha: 0.12)
        : Colors.transparent;
    final foreground = isSelected || isRangeEdge
        ? scheme.onPrimary
        : isDisabled
        ? scheme.onSurfaceVariant.withValues(alpha: 0.5)
        : isOutside
        ? scheme.onSurfaceVariant
        : scheme.onSurface;

    final cnTheme = CnTheme.of(context);
    final baseRadius = math.max(0.0, cnTheme.radius - 6);
    final radius = inRange && !isRangeEdge
        ? BorderRadius.zero
        : BorderRadius.circular(baseRadius);
    final textStyle = CnTheme.textThemeOf(context).bodySmall?.copyWith(
      color: foreground,
      fontWeight: isSelected || isRangeEdge ? .w600 : .w500,
    );
    final state = CnCalendarDayState(
      date: date,
      isOutside: isOutside,
      isDisabled: isDisabled,
      isToday: isToday,
      isSelected: isSelected,
      inRange: inRange,
      isRangeStart: isRangeStart,
      isRangeEnd: isRangeEnd,
      textStyle: textStyle,
    );
    final label =
        widget.dayBuilder?.call(context, date, state) ??
        Text('${date.day}', style: textStyle);

    return GestureDetector(
      onTap: isDisabled ? null : () => _handleDateTap(date),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: background,
          borderRadius: radius,
          border: isToday ? Border.all(color: scheme.primary, width: 1) : null,
        ),
        child: Center(child: label),
      ),
    );
  }

  void _handleDateTap(DateTime date) {
    if (_isDisabled(date)) {
      return;
    }
    if (widget.selectionMode == .single) {
      setState(() => _selectedDate = date);
      widget.onDateSelected?.call(date);
      return;
    }

    if (widget.selectionMode == .multiple) {
      final next = _toggleDateSelection(date);
      widget.onDatesSelected?.call(next);
      return;
    }

    final rangeStart = _rangeStart;
    final rangeEnd = _rangeEnd;
    if (rangeStart == null || rangeEnd != null) {
      setState(() {
        _rangeStart = date;
        _rangeEnd = null;
      });
      return;
    }

    if (_isBefore(date, rangeStart)) {
      setState(() {
        _rangeStart = date;
        _rangeEnd = null;
      });
      return;
    }

    setState(() => _rangeEnd = date);
    widget.onRangeSelected?.call(DateTimeRange(start: rangeStart, end: date));
  }

  void _handlePreviousMonth() {
    final previous = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
    _updateFocusedMonth(previous);
  }

  void _handleNextMonth() {
    final next = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
    _updateFocusedMonth(next);
  }

  void _updateFocusedMonth(DateTime month) {
    setState(() => _focusedMonth = month);
    widget.onMonthChanged?.call(month);
  }

  _CalendarDayInfo? _resolveDay(DateTime month, int index) {
    final firstDay = _monthStart(month);
    final startOffset = _weekdayOffset(firstDay);
    final daysInMonth = _daysInMonth(month);
    final dayNumber = index - startOffset + 1;

    if (dayNumber < 1) {
      final prevMonth = DateTime(month.year, month.month - 1, 1);
      final daysInPrevMonth = _daysInMonth(prevMonth);
      final date = DateTime(
        prevMonth.year,
        prevMonth.month,
        daysInPrevMonth + dayNumber,
      );
      return _CalendarDayInfo(date: date, isOutside: true);
    }

    if (dayNumber > daysInMonth) {
      final nextMonth = DateTime(month.year, month.month + 1, 1);
      final date = DateTime(
        nextMonth.year,
        nextMonth.month,
        dayNumber - daysInMonth,
      );
      return _CalendarDayInfo(date: date, isOutside: true);
    }

    return _CalendarDayInfo(
      date: DateTime(month.year, month.month, dayNumber),
      isOutside: false,
    );
  }

  List<String> _resolvedWeekdayLabels() {
    final labels =
        widget.weekdayLabels ??
        const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (labels.length != 7) {
      return const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    }
    final startIndex = _weekdayIndex(widget.firstDayOfWeek);
    return [for (var i = 0; i < 7; i++) labels[(startIndex + i) % 7]];
  }

  void _syncRangeFromWidget() {
    _rangeStart = widget.selectedRange?.start;
    _rangeEnd = widget.selectedRange?.end;
  }

  DateTime _monthAtOffset(DateTime month, int offset) {
    return DateTime(month.year, month.month + offset, 1);
  }

  List<int> _yearOptions() {
    final current = _focusedMonth.year;
    final start = widget.firstYear ?? current - 5;
    final end = widget.lastYear ?? current + 5;
    if (end < start) {
      return [current];
    }
    return [for (var year = start; year <= end; year++) year];
  }

  bool _isDisabled(DateTime date) {
    if (widget.isDateSelectable != null) {
      return !widget.isDateSelectable!(date);
    }
    return widget.isDateDisabled?.call(date) ?? false;
  }

  Set<DateTime> _normalizeDates(Set<DateTime> dates) {
    return {for (final date in dates) _normalizeDate(date)};
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Set<DateTime> _toggleDateSelection(DateTime date) {
    final normalized = _normalizeDate(date);
    final next = Set<DateTime>.from(_selectedDates);
    final alreadySelected = next.any((item) => _isSameDay(item, normalized));
    next.removeWhere((item) => _isSameDay(item, normalized));
    if (!alreadySelected) {
      next.add(normalized);
    }
    if (widget.selectedDates == null) {
      setState(() => _selectedDates = next);
    }
    return next;
  }

  DateTime _monthStart(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  String _monthName(int month) {
    return const [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][month - 1];
  }

  int _weekdayOffset(DateTime date) {
    final weekday = date.weekday;
    final firstDay = widget.firstDayOfWeek;
    var offset = weekday - firstDay;
    if (offset < 0) {
      offset += 7;
    }
    return offset;
  }

  int _weekdayIndex(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 0;
      case DateTime.tuesday:
        return 1;
      case DateTime.wednesday:
        return 2;
      case DateTime.thursday:
        return 3;
      case DateTime.friday:
        return 4;
      case DateTime.saturday:
        return 5;
      case DateTime.sunday:
        return 6;
      default:
        return 0;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isBefore(DateTime a, DateTime b) {
    final dateA = DateTime(a.year, a.month, a.day);
    final dateB = DateTime(b.year, b.month, b.day);
    return dateA.isBefore(dateB);
  }

  bool _isAfter(DateTime a, DateTime b) {
    final dateA = DateTime(a.year, a.month, a.day);
    final dateB = DateTime(b.year, b.month, b.day);
    return dateA.isAfter(dateB);
  }
}

class _CalendarDayInfo {
  final DateTime date;
  final bool isOutside;

  const _CalendarDayInfo({required this.date, required this.isOutside});
}
