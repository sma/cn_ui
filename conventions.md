# API Conventions

We take names and features from shadcn/ui. The shape of the API follows Flutter.

## Composition

- Fixed structure uses named slots: `CnCard(title: ..., action: ..., content: ..., footer: ...)`.
- Lists of options use data classes with a type parameter: `CnAccordionItem<T>`.
- Sub-widgets exist only where the structure is really free, e.g. `CnSidebar`, `CnInputGroup`.
- A parent that affects its children exposes that through `of`. `CnButtonGroup.of(context)` tells a button its position in the group; the button adapts its own corners and border. `CnField.hasError` works the same way for inputs.

## Slots

- Slots are `Widget`s. Use `String` only if the component needs the text itself, e.g. to filter it. There is no `label` + `labelText`.
- Side slots are `leading` and `trailing` on everything that can show an icon, e.g. buttons, badges, inputs and items.
- Main content is `child` on pure wrappers and `content` next to a title or description.

## State

- Components are controlled: `value` and `onChanged`, like Flutter. The surrounding code owns the state.
- There is no `initialValue`. Purely internal state such as hover or scroll position stays internal.
- Values replace indices where items have an identity: `CnAccordion<T>`, `CnTabs<T>`.
- Overlays are opened through a trigger or a `show...` function, not through a value. A `builder` trigger receives a `toggle` callback.

## Naming

| Topic | Rule |
| --- | --- |
| Disabling | A `null` callback disables. `enabled` exists only where no callback is required, e.g. text inputs and list items. |
| Default variant | `primary` on `CnButton` and `CnBadge`, `standard` elsewhere. |
| Sizes | `xs`, `sm`, `md`, `lg`. Icon-only buttons use `CnButton.icon`. |
| Booleans | No `is` or `allow` prefix: `multiple`, `expand`. |
| Axis | `direction: Axis`. `CnFieldLayout` stays because it also knows `responsive`. |
| Position | `start` and `end`, never `left` and `right`. |
| Alternatives | A named constructor, not "A or B" with an `assert`: `CnPopover.builder`, `CnText.h1`. |
| Types | Generics instead of `Object?`. |

## Overlays

- `showCnX(context:, builder:)` with a `WidgetBuilder`. Close with `Navigator.pop`.
- `side` and `align` use the shared `CnSide` and `CnAlign` enums.
- All menus share `CnMenuEntry`.

## Theming

- Components read tokens only: `CnTheme.of(context).colors.accent`, `.text.sm`, `.heading.xl`, `.mono.sm`, `.radii.md`.
- Titles use `heading`, code uses `mono`, everything else uses `text`.
- Colors must not animate on their own, or they lag behind a theme change. Use `Container` instead of `AnimatedContainer` and a zero `animationDuration` on `Material` and `ButtonStyle`.
- Components never read `ColorScheme` or `TextTheme`. `CnTheme.toThemeData` configures Material from the tokens, or a component passes an explicit style such as `ButtonStyle`.
- A `CnColor` is a `Color` and a `WidgetStateProperty<Color>` with predefined rest, hover, pressed and disabled values. There are no extra tokens such as `primaryHover`.
- Components have no color, radius or padding parameters. Layout values such as `spacing` and `width` stay.

## Material

- Material may be used internally. Public signatures contain no Material types.

## Code

- Use primary constructors. Use a classic class only where a named constructor needs private fields.
- Before 1.0 we break the API without deprecations.
