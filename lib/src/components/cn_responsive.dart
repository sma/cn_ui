import 'package:flutter/widgets.dart';

/// Width classes for [CnResponsive].
enum CnBreakpoint {
  /// Less than 576 pixels, e.g. a phone.
  small,

  /// From 576 to less than 1024 pixels, e.g. a tablet.
  medium,

  /// 1024 pixels or more, e.g. a desktop.
  large;

  /// Returns the class of a width.
  static CnBreakpoint of(double width) {
    if (width < 576) {
      return .small;
    }
    return width < 1024 ? .medium : .large;
  }
}

/// Builds a different layout depending on the available width.
///
/// It measures its own space and not the screen, like a container query. An
/// unbounded width counts as [CnBreakpoint.large].
///
/// As in Tailwind, a breakpoint without a builder uses the next smaller one, so
/// [small] is the only required builder. Use [child] for a subtree that all
/// layouts share.
class const CnResponsive({
  super.key,
  required final TransitionBuilder small,
  final TransitionBuilder? medium,
  final TransitionBuilder? large,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final builder = switch (CnBreakpoint.of(constraints.maxWidth)) {
          .small => small,
          .medium => medium ?? small,
          .large => large ?? medium ?? small,
        };
        return builder(context, child);
      },
    );
  }
}
