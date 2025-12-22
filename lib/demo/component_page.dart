import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cn_ui.dart';
import 'component_catalog.dart';

class ComponentPage extends StatelessWidget {
  final ComponentEntry entry;

  const ComponentPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const .symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(entry.name, style: CnTheme.textThemeOf(context).headlineMedium),
          Text(
            entry.description,
            style: CnTheme.textThemeOf(context).bodyLarge,
          ),
          for (var index = 0; index < entry.examples.length; index++)
            Padding(
              padding: EdgeInsets.only(top: index == 0 ? 16 : 24),
              child: _ExampleBlock(example: entry.examples[index]),
            ),
        ],
      ),
    );
  }
}

class _ExampleBlock extends StatelessWidget {
  final ComponentExample example;

  const _ExampleBlock({required this.example});

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);

    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: 4,
          children: [
            Text(
              example.title,
              style: CnTheme.textThemeOf(context).titleMedium,
            ),
            if (example.description != null)
              Text(
                example.description!,
                style: CnTheme.textThemeOf(
                  context,
                ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
          ],
        ),
        _Section(
          title: 'Preview',
          child: Container(
            width: double.infinity,
            padding: const .all(20),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: .circular(cnTheme.radius),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Center(child: example.preview(context)),
          ),
        ),
        _Section(
          title: 'Code',
          child: CnCodeBlock(code: example.code),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(title, style: CnTheme.textThemeOf(context).titleMedium),
        child,
      ],
    );
  }
}

class CnCodeBlock extends StatefulWidget {
  final String code;

  const CnCodeBlock({super.key, required this.code});

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
    final scheme = CnTheme.colorSchemeOf(context);
    final radius = CnTheme.of(context).radius;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const .all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: .circular(radius),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: SelectableText.rich(
            TextSpan(
              children: [
                ...lines.expand(
                  (line) => [
                    TextSpan(
                      text: '$lineNo'.padLeft(pad),
                      style: TextStyle(color: scheme.outline),
                    ),
                    TextSpan(text: '  $line'),
                    if (lineNo++ != lines.length) TextSpan(text: '\n'),
                  ],
                ),
              ],
            ),
            style: GoogleFonts.ibmPlexMono(fontSize: 14, height: 20 / 14),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
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
                color: _copied ? scheme.primary : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
