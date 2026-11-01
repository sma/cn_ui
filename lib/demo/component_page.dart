import '../cn_ui.dart';
import 'component_catalog.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key, required this.entry});
  final ComponentEntry entry;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const .symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(entry.name, style: CnTheme.of(context).heading.xl2.semibold),
          Text(entry.description, style: CnTheme.of(context).text.base),
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
  const _ExampleBlock({required this.example});
  final ComponentExample example;

  @override
  Widget build(BuildContext context) {
    final colors = CnTheme.of(context).colors;
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
              style: CnTheme.of(context).heading.base.semibold,
            ),
            if (example.description != null)
              Text(
                example.description!,
                style: CnTheme.of(context).text.xs
                    .copyWith(color: colors.mutedForeground),
              ),
          ],
        ),
        _Section(
          title: 'Preview',
          child: Container(
            width: double.infinity,
            padding: const .all(20),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: .circular(cnTheme.radius),
              border: Border.all(color: colors.border),
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
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(title, style: CnTheme.of(context).heading.base.semibold),
        child,
      ],
    );
  }
}
