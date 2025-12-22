import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';

/// An item in a [CnCombobox].
class CnComboboxItem<T> {
  final T value;
  final String label;
  final Widget? leading;
  final bool enabled;

  const CnComboboxItem({
    required this.value,
    required this.label,
    this.leading,
    this.enabled = true,
  });
}

/// A searchable dropdown select component with autocomplete functionality.
///
/// Provides a text input with filtered dropdown suggestions for selecting values.
///
/// See also:
///
///  * [CnSelect], for simple dropdown selection.
///  * [CnCommand], for command palette-style selection.
class CnCombobox<T> extends StatefulWidget {
  final List<CnComboboxItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final bool enabled;
  final bool autofocus;
  final bool allowCustom;
  final double menuMaxHeight;
  final double? menuWidth;

  const CnCombobox({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder,
    this.enabled = true,
    this.autofocus = false,
    this.allowCustom = false,
    this.menuMaxHeight = 240,
    this.menuWidth,
  });

  @override
  State<CnCombobox<T>> createState() => _CnComboboxState<T>();
}

class _CnComboboxState<T> extends State<CnCombobox<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _ownsController;
  late bool _ownsFocus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _ownsController = true;
    _ownsFocus = true;
    _syncControllerWithValue();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(CnCombobox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncControllerWithValue();
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && !widget.allowCustom) {
      _syncControllerWithValue();
    }
  }

  void _syncControllerWithValue() {
    final label = _labelForValue(widget.value);
    if (label != null) {
      _controller.value = TextEditingValue(
        text: label,
        selection: TextSelection.collapsed(offset: label.length),
      );
    } else if (_controller.text.isNotEmpty) {
      _controller.clear();
    }
  }

  String? _labelForValue(T? value) {
    if (value == null) {
      return null;
    }
    return widget.items
        .firstWhere(
          (item) => item.value == value,
          orElse: () => CnComboboxItem(value: value, label: value.toString()),
        )
        .label;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsController) {
      _controller.dispose();
    }
    if (_ownsFocus) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<CnComboboxItem<T>>(
      textEditingController: _controller,
      focusNode: _focusNode,
      optionsBuilder: (value) {
        final query = value.text.trim().toLowerCase();
        if (query.isEmpty) {
          return widget.items.where((item) => item.enabled);
        }
        return widget.items.where(
          (item) => item.enabled && item.label.toLowerCase().contains(query),
        );
      },
      displayStringForOption: (option) => option.label,
      onSelected: (option) {
        widget.onChanged?.call(option.value);
      },
      fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            suffixIcon: const Icon(Icons.expand_more),
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              widget.onChanged?.call(null);
            }
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        final cnTheme = CnTheme.of(context);
        final scheme = CnTheme.colorSchemeOf(context);
        final entries = options.toList();

        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const .only(top: 8),
              constraints: BoxConstraints(
                maxHeight: widget.menuMaxHeight,
                minWidth: widget.menuWidth ?? 260,
                maxWidth: widget.menuWidth ?? 320,
              ),
              decoration: BoxDecoration(
                color: cnTheme.menuColor,
                borderRadius: .circular(cnTheme.radius),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: ListView.builder(
                padding: const .symmetric(vertical: 6),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final option = entries[index];
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const .symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        spacing: 8,
                        children: [
                          if (option.leading != null) ...[option.leading!],
                          Expanded(
                            child: Text(
                              option.label,
                              style: CnTheme.textThemeOf(context).bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
