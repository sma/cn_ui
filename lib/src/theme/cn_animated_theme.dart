import 'package:flutter/widgets.dart';

import 'cn_theme.dart';

/// Animates between [CnTheme]s and rebuilds below with the current one.
///
/// Put it above the app and switch off the animation of Material, so that all
/// colors are derived from the same tokens in every frame:
///
/// ```dart
/// CnAnimatedTheme(
///   theme: theme,
///   builder: (context, theme) => MaterialApp(
///     theme: theme.toThemeData(),
///     themeAnimationDuration: Duration.zero,
///   ),
/// )
/// ```
class CnAnimatedTheme extends ImplicitlyAnimatedWidget {
  const CnAnimatedTheme({
    super.key,
    required this.theme,
    required this.builder,
    super.duration = const Duration(milliseconds: 200),
    super.curve = Curves.easeInOut,
  });
  final CnTheme theme;
  final Widget Function(BuildContext context, CnTheme theme) builder;

  @override
  AnimatedWidgetBaseState<CnAnimatedTheme> createState() =>
      _CnAnimatedThemeState();
}

class _CnAnimatedThemeState extends AnimatedWidgetBaseState<CnAnimatedTheme> {
  _CnThemeTween? _theme;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _theme = visitor(
      _theme,
      widget.theme,
      (value) => _CnThemeTween(begin: value as CnTheme),
    ) as _CnThemeTween?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _theme!.evaluate(animation));
  }
}

class _CnThemeTween extends Tween<CnTheme> {
  _CnThemeTween({super.begin});

  @override
  CnTheme lerp(double t) => begin!.lerp(end, t);
}
