import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../cn_ui.dart';

class CnCodeBlock extends StatefulWidget {
  const CnCodeBlock({super.key, required this.code});
  final String code;

  @override
  State<CnCodeBlock> createState() => _CnCodeBlockState();
}

class _CnCodeBlockState extends State<CnCodeBlock> {
  bool _copied = false;

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (!mounted) {
      return;
    }
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.code.split('\n');
    final pad = lines.length.toString().length;
    var lineNo = 1;
    final colors = CnTheme.of(context).colors;
    final radius = CnTheme.of(context).radius;

    return Stack(
      children: [
        Container(
          width: .infinity,
          padding: const .all(16),
          decoration: BoxDecoration(
            color: colors.muted,
            borderRadius: .circular(radius),
          ),
          child: SelectableText.rich(
            TextSpan(
              children: [
                ...lines.expand(
                  (line) => [
                    TextSpan(
                      text: '$lineNo'.padLeft(pad),
                      style: TextStyle(color: colors.mutedForeground),
                    ),
                    TextSpan(text: '  $line'),
                    if (lineNo++ != lines.length) TextSpan(text: '\n'),
                  ],
                ),
              ],
            ),
            style: CnTheme.of(context).mono.sm,
          ),
        ),
        PositionedDirectional(
          top: 8,
          end: 8,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: _handleCopy,
              tooltip: _copied ? 'Copied' : 'Copy',
              iconSize: 16,
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              icon: Icon(
                _copied ? Icons.check_rounded : Icons.copy_rounded,
                color: _copied ? colors.primary : colors.mutedForeground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
