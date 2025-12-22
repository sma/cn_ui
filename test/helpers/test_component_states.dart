import 'package:flutter/material.dart';
import 'package:cn_ui/src/components/cn_button.dart';
import 'package:cn_ui/src/components/cn_badge.dart';
import 'package:cn_ui/src/components/cn_alert.dart';

/// Helper to generate all variants of a component for golden testing
class ComponentStateGenerator {
  /// Generates all button variants
  static List<Widget> allButtonVariants({
    String label = 'Button',
    CnButtonSize size = CnButtonSize.md,
  }) {
    return [
      for (final variant in CnButtonVariant.values)
        CnButton(
          variant: variant,
          size: size,
          onPressed: () {},
          child: Text(label),
        ),
    ];
  }

  /// Generates all button sizes for a specific variant
  static List<Widget> allButtonSizes({
    CnButtonVariant variant = CnButtonVariant.primary,
  }) {
    return [
      for (final size in CnButtonSize.values)
        if (size == CnButtonSize.icon)
          CnButton(
            variant: variant,
            size: size,
            onPressed: () {},
            child: const Icon(Icons.settings),
          )
        else
          CnButton(
            variant: variant,
            size: size,
            onPressed: () {},
            child: Text(size.name.toUpperCase()),
          ),
    ];
  }

  /// Generates enabled and disabled states for all button variants
  static List<Widget> allButtonVariantsDisabled({String label = 'Button'}) {
    return [
      for (final variant in CnButtonVariant.values)
        CnButton(
          variant: variant,
          onPressed: null, // Disabled
          child: Text(label),
        ),
    ];
  }

  /// Generates all badge variants
  static List<Widget> allBadgeVariants({String label = 'Badge'}) {
    return [
      for (final variant in CnBadgeVariant.values)
        CnBadge(variant: variant, child: Text(label)),
    ];
  }

  /// Generates all alert variants
  static List<Widget> allAlertVariants() {
    return [
      for (final variant in CnAlertVariant.values)
        CnAlert(
          variant: variant,
          title: Text(_alertTitle(variant)),
          description: Text(_alertDescription(variant)),
        ),
    ];
  }

  static String _alertTitle(CnAlertVariant variant) {
    return switch (variant) {
      .neutral => 'Info',
      .info => 'Heads up!',
      .success => 'Success',
      .warning => 'Warning',
      .destructive => 'Error',
    };
  }

  static String _alertDescription(CnAlertVariant variant) {
    return switch (variant) {
      .neutral => 'This is a neutral message',
      .info => 'Important information to consider',
      .success => 'Operation completed successfully',
      .warning => 'Please review this carefully',
      .destructive => 'An error has occurred',
    };
  }
}

/// Wrapper for form components to test enabled/disabled states
class FormStateWrapper {
  /// Creates enabled and disabled versions of a form component
  static List<Widget> enabledAndDisabled({
    required Widget Function(bool enabled) builder,
  }) {
    return [builder(true), builder(false)];
  }
}
