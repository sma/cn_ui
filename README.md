# CN UI

Flutter UI library inspired by shadcn/ui, with a web demo that mirrors the component documentation and examples, **created by Codex 5.2** and refactored by **Opus 5.5**, with a tiny bit of help by a human **as a test** whether an AI is capable to do such a task.

Starting with an initial prompt to port, this has been refined by 10 additional prompts. The human added line numbers to the code block widget, fixed the collapsible and wrote the avatar group widget which was then integrated by the AI.

## Goals

- Port core shadcn/ui components to Flutter with a consistent API.
- Provide a demo catalog with live previews and code snippets.
- Support global theming via `CnTheme` (style, colors, fonts, radius, menu).

## Current State

- Work in progress; many components are implemented and actively refined.
- `components.md` tracks what is done and what is still missing.
- The demo app includes a component catalog, theme tokens, and blocks.
- There's a test suite with golden tests (created by Claude)

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:cn_ui/cn_ui.dart';

MaterialApp(
  theme: const CnTheme().toThemeData(),
  darkTheme: const CnTheme(colors: CnColors.dark).toThemeData(),
)
```

## Demo

Run the [web demo](https://sma.github.io/cn_ui/):

```bash
flutter pub get
flutter run -d chrome
```

## Theming

Use `CnTheme` to configure the component system:

- `colors`: the color tokens, named like the shadcn/ui CSS variables (`CnColors.light`, `CnColors.dark`)
- `fontFamily`
- `radius`: the base of the radius scale

Components read tokens through `CnTheme.of(context)`, e.g. `.colors.accent`, `.text.sm` or `.radii.md`. `toThemeData` configures Material from the same tokens.

See [conventions.md](conventions.md) for the rules the component APIs follow.

## Components

See [components.md](components.md) for a list of supported components.

## License

MIT. See [LICENSE](LICENSE).
