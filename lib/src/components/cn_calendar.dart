import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';
import 'cn_select.dart';

/// Header style variants for [CnCalendar].
enum CnCalendarHeaderVariant { chevrons, dropdowns }

/// A builder function for customizing day rendering in [CnCalendar].
typedef CnCalendarDayBuilder = Widget Function(
  BuildContext context,
  DateTime date,
  CnCalendarDayState state,
);

/// State information for a calendar day in [CnCalendar].
@immutable
class CnCalendarDayState {
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
  final DateTime date;
  final bool isOutside;
  final bool isDisabled;
  final bool isToday;
  final bool isSelected;
  final bool inRange;
  final bool isRangeStart;
  final bool isRangeEnd;
  final TextStyle? textStyle;

  bool get isRangeEdge => isRangeStart || isRangeEnd;
  bool get isRangeMiddle => inRange && !isRangeEdge;
}

/// A range of days in a [CnCalendar].
@immutable
class const CnDateRange({
  required final DateTime start,
  required final DateTime end,
});

enum _CalendarMode { single, range, multiple }

/// A month grid for choosing dates.
///
/// Use [CnCalendar.single], [CnCalendar.range] or [CnCalendar.multiple]. The
/// month is internal state, which [focusedMonth] can move.
///
/// See also:
///
///  * [CnDatePicker], for a date picker input field.
class CnCalendar extends StatefulWidget {
  /// Creates a calendar for choosing one day.
  const CnCalendar.single({
    super.key,
    DateTime? value,
    ValueChanged<DateTime>? onChanged,
    this.focusedMonth,
    this.onMonthChanged,
    this.showOutsideDays = true,
    this.showWeekdayLabels = true,
    this.firstDayOfWeek = DateTime.monday,
    this.weekdayLabels,
    this.isDateDisabled,
    this.dayBuilder,
    this.monthsToDisplay = 1,
    this.headerVariant = .chevrons,
    this.firstYear,
    this.lastYear,
    this.daySize = 32,
    this.gridSpacing = 4,
  }) : _mode = .single,
       _date = value,
       _onDate = onChanged,
       _range = null,
       _onRange = null,
       _dates = null,
       _onDates = null;

  /// Creates a calendar for choosing a range of days.
  const CnCalendar.range({
    super.key,
    CnDateRange? value,
    ValueChanged<CnDateRange>? onChanged,
    this.focusedMonth,
    this.onMonthChanged,
    this.showOutsideDays = true,
    this.showWeekdayLabels = true,
    this.firstDayOfWeek = DateTime.monday,
    this.weekdayLabels,
    this.isDateDisabled,
    this.dayBuilder,
    this.monthsToDisplay = 1,
    this.headerVariant = .chevrons,
    this.firstYear,
    this.lastYear,
    this.daySize = 32,
    this.gridSpacing = 4,
  }) : _mode = .range,
       _date = null,
       _onDate = null,
       _range = value,
       _onRange = onChanged,
       _dates = null,
       _onDates = null;

  /// Creates a calendar for choosing several days.
  const CnCalendar.multiple({
    super.key,
    Set<DateTime> value = const {},
    ValueChanged<Set<DateTime>>? onChanged,
    this.focusedMonth,
    this.onMonthChanged,
    this.showOutsideDays = true,
    this.showWeekdayLabels = true,
    this.firstDayOfWeek = DateTime.monday,
    this.weekdayLabels,
    this.isDateDisabled,
    this.dayBuilder,
    this.monthsToDisplay = 1,
    this.headerVariant = .chevrons,
    this.firstYear,
    this.lastYear,
    this.daySize = 32,
    this.gridSpacing = 4,
  }) : assert(monthsToDisplay > 0, 'monthsToDisplay must be at least 1.'),
       _mode = .multiple,
       _date = null,
       _onDate = null,
       _range = null,
       _onRange = null,
       _dates = value,
       _onDates = onChanged;

  final _CalendarMode _mode;
  final DateTime? _date;
  final ValueChanged<DateTime>? _onDate;
  final CnDateRange? _range;
  final ValueChanged<CnDateRange>? _onRange;
  final Set<DateTime>? _dates;
  final ValueChanged<Set<DateTime>>? _onDates;
  final DateTime? focusedMonth;
  final ValueChanged<DateTime>? onMonthChanged;
  final bool showOutsideDays;
  final bool showWeekdayLabels;
  final int firstDayOfWeek;
  final List<String>? weekdayLabels;
  final bool Function(DateTime date)? isDateDisabled;
  final CnCalendarDayBuilder? dayBuilder;
  final int monthsToDisplay;
  final CnCalendarHeaderVariant headerVariant;
  final int? firstYear;
  final int? lastYear;
  final double daySize;
  final double gridSpacing;

  @override
  State<CnCalendar> createState() => _CnCalendarState();
}

class _CnCalendarState extends State<CnCalendar> {
  late DateTime _focusedMonth;

  /// The first day of a range while the user is about to pick the last one.
  DateTime? _pendingStart;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedMonth = _monthStart(
      widget.focusedMonth ?? widget._date ?? widget._range?.start ?? now,
    );
  }

  @override
  void didUpdateWidget(covariant CnCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusedMonth != oldWidget.focusedMonth &&
        widget.focusedMonth != null) {
      _focusedMonth = _monthStart(widget.focusedMonth!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;
    final text = CnTheme.of(context).text;
    final weekdayLabels = _resolvedWeekdayLabels();
    final rangeStart = _pendingStart ?? widget._range?.start;
    final rangeEnd = _pendingStart != null ? null : widget._range?.end;
    final selectedDate = widget._date;
    final months = [
      for (var i = 0; i < widget.monthsToDisplay; i++)
        _monthAtOffset(_focusedMonth, i),
    ];

    return Padding(
      padding: const .all(12),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          _buildHeader(text, months),
          Row(
            crossAxisAlignment: .start,
            spacing: widget.monthsToDisplay > 1 ? 24 : 0,
            children: [
              for (final month in months)
                Expanded(
                  child: _buildMonthView(
                    month,
                    colors,
                    text,
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

  Widget _buildHeader(CnTextStyles text, List<DateTime> months) {
    final header = widget.headerVariant;
    if (header == CnCalendarHeaderVariant.dropdowns &&
        widget.monthsToDisplay == 1) {
      return Row(
        children: [
          CnButton.icon(
            variant: .ghost,
            size: .sm,
            onPressed: _handlePreviousMonth,
            icon: const Icon(Icons.chevron_left),
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
                        CnSelectItem(
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
                        CnSelectItem(value: year, child: Text(year.toString())),
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
          CnButton.icon(
            variant: .ghost,
            size: .sm,
            onPressed: _handleNextMonth,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      );
    }

    return Row(
      children: [
        CnButton.icon(
          variant: .ghost,
          size: .sm,
          onPressed: _handlePreviousMonth,
          icon: const Icon(Icons.chevron_left),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: .center,
            spacing: 24,
            children: [
              for (final month in months)
                Text(
                  '${_monthName(month.month)} ${month.year}',
                  style: text.base.semibold,
                ),
            ],
          ),
        ),
        CnButton.icon(
          variant: .ghost,
          size: .sm,
          onPressed: _handleNextMonth,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildMonthView(
    DateTime month,
    CnColors colors,
    CnTextStyles text,
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
                          style: text.xs.semibold.copyWith(
                            color: colors.mutedForeground,
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
              colors,
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
    CnColors colors,
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
        widget._mode == .single &&
        selectedDate != null &&
        _isSameDay(date, selectedDate);
    final isSelectedMultiple =
        widget._mode == .multiple &&
        widget._dates!.any((item) => _isSameDay(item, date));
    final isSelected = isSelectedSingle || isSelectedMultiple;

    final inRange =
        widget._mode == .range &&
        rangeStart != null &&
        rangeEnd != null &&
        !_isBefore(date, rangeStart) &&
        !_isAfter(date, rangeEnd);
    final isRangeStart =
        widget._mode == .range &&
        rangeStart != null &&
        _isSameDay(date, rangeStart);
    final isRangeEnd =
        widget._mode == .range &&
        rangeEnd != null &&
        _isSameDay(date, rangeEnd);
    final isRangeEdge = isRangeStart || isRangeEnd;

    final background = isSelected || isRangeEdge
        ? colors.primary
        : inRange
        ? colors.primary.withValues(alpha: 0.12)
        : Colors.transparent;
    final foreground = isSelected || isRangeEdge
        ? colors.primaryForeground
        : isDisabled
        ? colors.mutedForeground.withValues(alpha: 0.5)
        : isOutside
        ? colors.mutedForeground
        : colors.foreground;

    final cnTheme = CnTheme.of(context);
    final baseRadius = cnTheme.radii.sm;
    final radius = inRange && !isRangeEdge
        ? BorderRadius.zero
        : BorderRadius.circular(baseRadius);
    final textStyle = CnTheme.of(context).text.xs
        .weight(isSelected || isRangeEdge ? .w600 : .w500)
        .copyWith(color: foreground);
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
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: radius,
          border: isToday ? Border.all(color: colors.primary, width: 1) : null,
        ),
        child: Center(child: label),
      ),
    );
  }

  void _handleDateTap(DateTime date) {
    if (_isDisabled(date)) {
      return;
    }
    if (widget._mode == .single) {
      widget._onDate?.call(date);
      return;
    }

    if (widget._mode == .multiple) {
      widget._onDates?.call(_toggleDateSelection(date));
      return;
    }

    final start = _pendingStart;
    if (start == null || _isBefore(date, start)) {
      setState(() => _pendingStart = date);
      return;
    }

    setState(() => _pendingStart = null);
    widget._onRange?.call(CnDateRange(start: start, end: date));
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
    return widget.isDateDisabled?.call(date) ?? false;
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Set<DateTime> _toggleDateSelection(DateTime date) {
    final normalized = _normalizeDate(date);
    final next = {for (final item in widget._dates!) _normalizeDate(item)};
    final alreadySelected = next.any((item) => _isSameDay(item, normalized));
    next.removeWhere((item) => _isSameDay(item, normalized));
    if (!alreadySelected) {
      next.add(normalized);
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
  const _CalendarDayInfo({required this.date, required this.isOutside});
  final DateTime date;
  final bool isOutside;
}
