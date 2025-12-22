import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_toggle.dart';

/// A group of toggle buttons for single or multiple selection.
///
/// Supports both single and multiple selection modes, with options for joined or separated layouts.
///
/// See also:
///
///  * [CnToggle], for individual toggle buttons.
///  * [CnRadioGroup], for single-selection radio buttons.
class CnToggleGroup extends StatelessWidget {
  final List<CnToggleGroupItem> items;
  final Set<Object?> selectedValues;
  final ValueChanged<Set<Object?>> onChanged;
  final bool allowMultiple;
  final bool allowEmpty;
  final bool joined;
  final CnToggleVariant variant;
  final CnToggleSize size;
  final double spacing;
  final double runSpacing;

  const CnToggleGroup({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    this.allowMultiple = false,
    this.allowEmpty = true,
    this.joined = false,
    this.variant = .outline,
    this.size = .md,
    this.spacing = 8,
    this.runSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (joined) {
      return _JoinedToggleGroup(
        items: items,
        selectedValues: selectedValues,
        onChanged: onChanged,
        allowMultiple: allowMultiple,
        allowEmpty: allowEmpty,
        variant: variant,
        size: size,
      );
    }
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: [
        for (final item in items)
          CnToggle(
            value: selectedValues.contains(item.value),
            onChanged: item.enabled
                ? (value) => _handleToggle(item.value, value)
                : null,
            variant: variant,
            size: size,
            enabled: item.enabled,
            child: item.child,
          ),
      ],
    );
  }

  void _handleToggle(Object? value, bool isSelected) {
    final next = {...selectedValues};

    if (allowMultiple) {
      if (isSelected) {
        next.add(value);
      } else {
        next.remove(value);
      }
      onChanged(next);
      return;
    }

    if (isSelected) {
      onChanged({value});
      return;
    }

    if (allowEmpty) {
      next.remove(value);
      onChanged(next);
    }
  }
}

/// An item in a [CnToggleGroup].
class CnToggleGroupItem {
  final Object? value;
  final Widget child;
  final bool enabled;

  const CnToggleGroupItem({
    required this.value,
    required this.child,
    this.enabled = true,
  });
}

class _JoinedToggleGroup extends StatelessWidget {
  final List<CnToggleGroupItem> items;
  final Set<Object?> selectedValues;
  final ValueChanged<Set<Object?>> onChanged;
  final bool allowMultiple;
  final bool allowEmpty;
  final CnToggleVariant variant;
  final CnToggleSize size;

  const _JoinedToggleGroup({
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    required this.allowMultiple,
    required this.allowEmpty,
    required this.variant,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final radius = math.max(0.0, cnTheme.radius - 4);

    return IntrinsicHeight(
      child: DecoratedBox(
        position: .foreground,
        decoration: BoxDecoration(
          borderRadius: .circular(radius),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          mainAxisSize: .min,
          children: [
            for (var index = 0; index < items.length; index++) ...[
              _JoinedToggleItem(
                item: items[index],
                selected: selectedValues.contains(items[index].value),
                isFirst: index == 0,
                isLast: index == items.length - 1,
                radius: radius,
                variant: variant,
                size: size,
                onChanged: (value) => _handleToggle(items[index].value, value),
              ),
              if (index != items.length - 1)
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: scheme.outlineVariant,
                ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleToggle(Object? value, bool isSelected) {
    final next = {...selectedValues};

    if (allowMultiple) {
      if (isSelected) {
        next.add(value);
      } else {
        next.remove(value);
      }
      onChanged(next);
      return;
    }

    if (isSelected) {
      onChanged({value});
      return;
    }

    if (allowEmpty) {
      next.remove(value);
      onChanged(next);
    }
  }
}

class _JoinedToggleItem extends StatelessWidget {
  final CnToggleGroupItem item;
  final bool selected;
  final bool isFirst;
  final bool isLast;
  final double radius;
  final CnToggleVariant variant;
  final CnToggleSize size;
  final ValueChanged<bool> onChanged;

  const _JoinedToggleItem({
    required this.item,
    required this.selected,
    required this.isFirst,
    required this.isLast,
    required this.radius,
    required this.variant,
    required this.size,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.horizontal(
      left: isFirst ? .circular(radius) : .zero,
      right: isLast ? .circular(radius) : .zero,
    );

    return CnToggle(
      value: selected,
      onChanged: item.enabled ? onChanged : null,
      variant: variant,
      size: size,
      enabled: item.enabled,
      showBorder: false,
      borderRadius: borderRadius,
      child: item.child,
    );
  }
}
