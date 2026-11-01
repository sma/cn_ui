import 'package:material_ui/material_ui.dart';

/// A date picker input field component.
///
/// Provides a text field that opens a date picker dialog when tapped.
///
/// See also:
///
///  * [CnCalendar], for inline calendar selection.
class CnDatePicker extends StatefulWidget {
  const CnDatePicker({
    super.key,
    this.value,
    this.onChanged,
    this.firstDate,
    this.lastDate,
    this.focusedDate,
    this.placeholder,
    this.clearable = true,
  });
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// The month to show while there is no [value].
  final DateTime? focusedDate;
  final String? placeholder;
  final bool clearable;

  @override
  State<CnDatePicker> createState() => _CnDatePickerState();
}

class _CnDatePickerState extends State<CnDatePicker> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncText();
  }

  @override
  void didUpdateWidget(CnDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncText();
    }
  }

  void _syncText() {
    if (widget.value == null) {
      _controller.text = '';
      return;
    }
    final localizations = MaterialLocalizations.of(context);
    _controller.text = localizations.formatMediumDate(widget.value!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    if (widget.onChanged == null) {
      return;
    }
    final initial = widget.value ?? widget.focusedDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (picked != null) {
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      enabled: widget.onChanged != null,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        suffixIcon: Row(
          mainAxisSize: .min,
          children: [
            if (widget.clearable && widget.value != null)
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                tooltip: 'Clear',
                onPressed: () => widget.onChanged?.call(null),
              ),
            IconButton(
              icon: const Icon(Icons.calendar_today, size: 16),
              tooltip: 'Pick date',
              onPressed: _pickDate,
            ),
          ],
        ),
      ),
      onTap: _pickDate,
    );
  }
}
