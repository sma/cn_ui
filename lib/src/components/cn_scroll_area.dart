import 'package:material_ui/material_ui.dart';

/// A scrollable area with a scrollbar.
class CnScrollArea extends StatefulWidget {
  const CnScrollArea({
    super.key,
    required this.child,
    this.direction = .vertical,
    this.height,
    this.width,
    this.controller,
    this.thumbVisibility = false,
    this.trackVisibility = false,
  });
  final Widget child;
  final Axis direction;
  final double? height;
  final double? width;
  final ScrollController? controller;
  final bool thumbVisibility;
  final bool trackVisibility;

  @override
  State<CnScrollArea> createState() => _CnScrollAreaState();
}

class _CnScrollAreaState extends State<CnScrollArea> {
  // The scrollbar and the scroll view have to share a controller.
  final _ownController = ScrollController();

  @override
  void dispose() {
    _ownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller ?? _ownController;

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Scrollbar(
        controller: controller,
        thumbVisibility: widget.thumbVisibility,
        trackVisibility: widget.trackVisibility,
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: widget.direction,
          child: widget.child,
        ),
      ),
    );
  }
}
