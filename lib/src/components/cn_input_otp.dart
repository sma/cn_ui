import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/cn_theme.dart';

/// An input component for one-time password (OTP) entry.
///
/// Displays a series of individual input boxes for entering verification codes with support for paste, keyboard navigation, and optional grouping.
///
/// See also:
///
///  * [CnInput], for standard text input.
class CnInputOtp extends StatefulWidget {
  final int length;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final bool numericOnly;
  final double boxSize;
  final TextStyle? textStyle;
  final int? groupSize;
  final Widget? separator;

  const CnInputOtp({
    super.key,
    required this.length,
    this.value,
    this.onChanged,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.numericOnly = true,
    this.boxSize = 48,
    this.textStyle,
    this.groupSize,
    this.separator,
  }) : assert(length > 0, 'length must be greater than zero');

  @override
  State<CnInputOtp> createState() => _CnInputOtpState();
}

class _CnInputOtpState extends State<CnInputOtp> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  bool _handlingPaste = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              _controllers[index].text.isEmpty) {
            if (index > 0) {
              _controllers[index - 1].selection = TextSelection.collapsed(
                offset: _controllers[index - 1].text.length,
              );
              _focusNodes[index - 1].requestFocus();
            }
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
      )..addListener(() => setState(() {})),
    );
    _setValue(widget.value ?? '');
  }

  @override
  void didUpdateWidget(CnInputOtp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      throw FlutterError('CnInputOtp length cannot change dynamically.');
    }
    if (widget.value != null && widget.value != _combinedValue()) {
      _setValue(widget.value!);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _setValue(String value) {
    final chars = value.split('');
    for (var i = 0; i < widget.length; i++) {
      final next = i < chars.length ? chars[i] : '';
      _controllers[i].text = next;
    }
    setState(() {});
  }

  String _combinedValue() {
    return _controllers.map((controller) => controller.text).join();
  }

  void _handleChanged(int index, String value) {
    if (_handlingPaste) {
      return;
    }
    if (value.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
      widget.onChanged?.call(_combinedValue());
      return;
    }

    if (value.length > 1) {
      _applyPaste(index, value);
      return;
    }

    if (index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
    }

    widget.onChanged?.call(_combinedValue());
  }

  void _applyPaste(int startIndex, String value) {
    _handlingPaste = true;
    final chars = value.split('');
    var currentIndex = startIndex;
    for (final char in chars) {
      if (currentIndex >= widget.length) {
        break;
      }
      _controllers[currentIndex].text = char;
      currentIndex += 1;
    }
    _handlingPaste = false;

    if (currentIndex >= widget.length) {
      _focusNodes.last.unfocus();
    } else {
      _focusNodes[currentIndex].requestFocus();
    }

    widget.onChanged?.call(_combinedValue());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final separator = widget.separator ?? const SizedBox(width: 12);

    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var index = 0; index < widget.length; index++) ...[
          if (widget.groupSize != null &&
              index > 0 &&
              index % widget.groupSize! == 0)
            separator,
          _OtpSlot(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            enabled: widget.enabled,
            autofocus: widget.autofocus && index == 0,
            obscureText: widget.obscureText,
            numericOnly: widget.numericOnly,
            size: widget.boxSize,
            textStyle: widget.textStyle,
            radius: math.max(0, cnTheme.radius - 6),
            borderColor: _borderColorFor(index, scheme),
            fillColor: scheme.surface,
            onChanged: (value) => _handleChanged(index, value),
          ),
        ],
      ],
    );
  }

  Color _borderColorFor(int index, ColorScheme scheme) {
    if (_focusNodes[index].hasFocus) {
      return scheme.primary;
    }
    if (_controllers[index].text.isNotEmpty) {
      return scheme.outline;
    }
    return scheme.outlineVariant;
  }
}

class _OtpSlot extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final bool numericOnly;
  final double size;
  final TextStyle? textStyle;
  final double radius;
  final Color borderColor;
  final Color fillColor;
  final ValueChanged<String> onChanged;

  const _OtpSlot({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.autofocus,
    required this.obscureText,
    required this.numericOnly,
    required this.size,
    required this.textStyle,
    required this.radius,
    required this.borderColor,
    required this.fillColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final inputFormatters = <TextInputFormatter>[
      if (numericOnly) FilteringTextInputFormatter.digitsOnly,
    ];

    return SizedBox(
      width: size,
      height: size,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        autofocus: autofocus,
        obscureText: obscureText,
        textAlign: .center,
        keyboardType: numericOnly ? TextInputType.number : TextInputType.text,
        textInputAction: TextInputAction.next,
        style: textStyle ?? CnTheme.textThemeOf(context).titleMedium,
        inputFormatters: inputFormatters,
        maxLines: 1,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: fillColor,
          contentPadding: .zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: .circular(radius),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: .circular(radius),
            borderSide: BorderSide(color: borderColor, width: 1.4),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: .circular(radius),
            borderSide: BorderSide(color: borderColor.withValues(alpha: 0.4)),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
