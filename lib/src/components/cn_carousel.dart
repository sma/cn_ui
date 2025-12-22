import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';

/// A carousel component for displaying a slideshow of content.
///
/// Provides navigation arrows, indicators, autoplay, and looping functionality for cycling through items.
class CnCarousel extends StatefulWidget {
  final List<Widget> items;
  final PageController? controller;
  final int initialPage;
  final double viewportFraction;
  final double? height;
  final double? aspectRatio;
  final EdgeInsetsGeometry padding;
  final bool showIndicators;
  final bool showArrows;
  final bool loop;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimation;
  final Curve autoPlayCurve;
  final ValueChanged<int>? onPageChanged;
  final double indicatorSize;
  final double indicatorSpacing;
  final double indicatorActiveWidth;
  final double indicatorPadding;

  const CnCarousel({
    super.key,
    required this.items,
    this.controller,
    this.initialPage = 0,
    this.viewportFraction = 1,
    this.height,
    this.aspectRatio,
    this.padding = .zero,
    this.showIndicators = true,
    this.showArrows = true,
    this.loop = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlayAnimation = const Duration(milliseconds: 450),
    this.autoPlayCurve = Curves.easeOutCubic,
    this.onPageChanged,
    this.indicatorSize = 8,
    this.indicatorSpacing = 6,
    this.indicatorActiveWidth = 20,
    this.indicatorPadding = 12,
  }) : assert(items.length > 0, 'CnCarousel requires at least one item.');

  @override
  State<CnCarousel> createState() => _CnCarouselState();
}

class _CnCarouselState extends State<CnCarousel> {
  late PageController _controller;
  bool _ownsController = false;
  int _currentIndex = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage.clamp(0, widget.items.length - 1);
    _controller = _resolveController();
    _restartAutoPlay();
  }

  @override
  void didUpdateWidget(covariant CnCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _controller.dispose();
      }
      _controller = _resolveController();
    } else if (_ownsController &&
        oldWidget.viewportFraction != widget.viewportFraction) {
      _controller.dispose();
      _controller = _resolveController();
    }

    final maxIndex = widget.items.length - 1;
    if (_currentIndex > maxIndex) {
      _currentIndex = maxIndex;
      if (_controller.hasClients) {
        _controller.jumpToPage(_currentIndex);
      }
    }

    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval ||
        oldWidget.items.length != widget.items.length ||
        oldWidget.loop != widget.loop) {
      _restartAutoPlay();
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  PageController _resolveController() {
    if (widget.controller != null) {
      _ownsController = false;
      return widget.controller!;
    }
    _ownsController = true;
    return PageController(
      initialPage: _currentIndex,
      viewportFraction: widget.viewportFraction,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cnTheme = CnTheme.of(context);
    final scheme = CnTheme.colorSchemeOf(context);

    Widget pageView = PageView.builder(
      controller: _controller,
      itemCount: widget.items.length,
      onPageChanged: _handlePageChanged,
      itemBuilder: (context, index) => widget.items[index],
    );

    if (widget.height != null) {
      pageView = SizedBox(height: widget.height, child: pageView);
    } else if (widget.aspectRatio != null) {
      pageView = AspectRatio(aspectRatio: widget.aspectRatio!, child: pageView);
    }

    final stack = Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(borderRadius: .circular(cnTheme.radius), child: pageView),
        if (widget.showArrows && widget.items.length > 1)
          Positioned(
            left: 12,
            child: _buildArrow(
              icon: Icons.chevron_left,
              enabled: widget.loop || _currentIndex > 0,
              onPressed: _handlePrevious,
            ),
          ),
        if (widget.showArrows && widget.items.length > 1)
          Positioned(
            right: 12,
            child: _buildArrow(
              icon: Icons.chevron_right,
              enabled: widget.loop || _currentIndex < widget.items.length - 1,
              onPressed: _handleNext,
            ),
          ),
        if (widget.showIndicators && widget.items.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: widget.indicatorPadding,
            child: Row(
              mainAxisAlignment: .center,
              children: [
                for (var i = 0; i < widget.items.length; i++)
                  Padding(
                    padding: .symmetric(
                      horizontal: widget.indicatorSpacing / 2,
                    ),
                    child: GestureDetector(
                      onTap: () => _animateToPage(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: widget.indicatorSize,
                        width: _currentIndex == i
                            ? widget.indicatorActiveWidth
                            : widget.indicatorSize,
                        decoration: BoxDecoration(
                          color: _currentIndex == i
                              ? scheme.primary
                              : scheme.outlineVariant,
                          borderRadius: .circular(widget.indicatorSize),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );

    return Padding(padding: widget.padding, child: stack);
  }

  Widget _buildArrow({
    required IconData icon,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    return CnButton(
      variant: .outline,
      size: .icon,
      onPressed: enabled ? onPressed : null,
      child: Icon(icon),
    );
  }

  void _handlePrevious() {
    if (_currentIndex == 0 && !widget.loop) {
      return;
    }
    final nextIndex = _currentIndex == 0
        ? widget.items.length - 1
        : _currentIndex - 1;
    _animateToPage(nextIndex);
  }

  void _handleNext() {
    if (_currentIndex == widget.items.length - 1 && !widget.loop) {
      return;
    }
    final nextIndex = _currentIndex == widget.items.length - 1
        ? 0
        : _currentIndex + 1;
    _animateToPage(nextIndex);
  }

  void _animateToPage(int index) {
    if (!_controller.hasClients) {
      setState(() => _currentIndex = index);
      return;
    }
    _controller.animateToPage(
      index,
      duration: widget.autoPlayAnimation,
      curve: widget.autoPlayCurve,
    );
  }

  void _handlePageChanged(int index) {
    setState(() => _currentIndex = index);
    widget.onPageChanged?.call(index);
  }

  void _restartAutoPlay() {
    _autoPlayTimer?.cancel();
    if (!widget.autoPlay || widget.items.length <= 1) {
      return;
    }
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted) {
        return;
      }
      if (!widget.loop && _currentIndex >= widget.items.length - 1) {
        return;
      }
      final next = _currentIndex + 1;
      if (next >= widget.items.length) {
        _animateToPage(0);
      } else {
        _animateToPage(next);
      }
    });
  }
}
