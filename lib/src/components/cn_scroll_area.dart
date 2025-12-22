import 'package:flutter/material.dart';

/// A scrollable container with customizable scrollbar visibility.
///
/// Provides a consistent interface for scrollable content with optional scrollbar controls.
///
/// See also:
///
///  * [SingleChildScrollView], the underlying scroll widget.
///  * [Scrollbar], for scrollbar customization.
class CnScrollArea extends StatelessWidget {
  final Widget child;
  final Axis direction;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool thumbVisibility;
  final bool trackVisibility;
  final bool? interactive;
  final ScrollbarOrientation? scrollbarOrientation;

  const CnScrollArea({
    super.key,
    required this.child,
    this.direction = .vertical,
    this.height,
    this.width,
    this.padding,
    this.controller,
    this.thumbVisibility = false,
    this.trackVisibility = false,
    this.interactive,
    this.scrollbarOrientation,
  });

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      controller: controller,
      scrollDirection: direction,
      padding: padding,
      child: child,
    );

    return SizedBox(
      height: height,
      width: width,
      child: Scrollbar(
        controller: controller,
        thumbVisibility: thumbVisibility,
        trackVisibility: trackVisibility,
        interactive: interactive,
        scrollbarOrientation: scrollbarOrientation,
        child: content,
      ),
    );
  }
}
