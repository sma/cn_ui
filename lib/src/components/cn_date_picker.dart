import 'package:flutter/material.dart';

/// A date picker input field component.
///
/// Provides a text field that opens a date picker dialog when tapped.
///
/// See also:
///
///  * [CnCalendar], for inline calendar selection.
class CnDatePickerField extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final String? placeholder;
  final bool enabled;
  final bool allowClear;

  CnDatePickerField({
    super.key,
    this.value,
    this.onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
    this.initialDate,
    this.placeholder,
    this.enabled = true,
    this.allowClear = true,
  }) : firstDate = firstDate ?? DateTime(2000),
       lastDate = lastDate ?? DateTime(2100);

  @override
  State<CnDatePickerField> createState() => _CnDatePickerFieldState();
}

class _CnDatePickerFieldState extends State<CnDatePickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.value == null ? '' : '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncText();
  }

  @override
  void didUpdateWidget(CnDatePickerField oldWidget) {
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
    if (!widget.enabled) {
      return;
    }
    final now = DateTime.now();
    final initial = widget.value ?? widget.initialDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
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
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        suffixIcon: Row(
          mainAxisSize: .min,
          children: [
            if (widget.allowClear && widget.value != null)
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Clear',
                onPressed: () => widget.onChanged?.call(null),
              ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
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
