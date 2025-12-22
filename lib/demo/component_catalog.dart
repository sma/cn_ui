import 'package:flutter/material.dart';

import '../cn_ui.dart';

class ComponentEntry {
  final String name;
  final String description;
  final List<ComponentExample> examples;

  const ComponentEntry({
    required this.name,
    required this.description,
    required this.examples,
  });
}

class ComponentExample {
  final String title;
  final String? description;
  final Widget Function(BuildContext context) preview;
  final String code;

  const ComponentExample({
    required this.title,
    this.description,
    required this.preview,
    required this.code,
  });
}

final List<ComponentEntry> componentCatalog = [
  ComponentEntry(
    name: 'Button',
    description: 'Pressable actions with tonal variants and sizes.',
    examples: [
      ComponentExample(
        title: 'Variants',
        description:
            'Primary, secondary, outline, ghost, destructive, and link.',
        preview: (context) => Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            CnButton(onPressed: () {}, child: const Text('Primary')),
            CnButton(
              variant: .secondary,
              onPressed: () {},
              child: const Text('Secondary'),
            ),
            CnButton(
              variant: .outline,
              onPressed: () {},
              child: const Text('Outline'),
            ),
            CnButton(
              variant: .ghost,
              onPressed: () {},
              child: const Text('Ghost'),
            ),
            CnButton(
              variant: .destructive,
              onPressed: () {},
              child: const Text('Destructive'),
            ),
            CnButton(
              variant: .link,
              onPressed: () {},
              child: const Text('Link'),
            ),
          ],
        ),
        code: '''CnButton(
  onPressed: () {},
  child: Text('Primary'),
)

CnButton(
  variant: .outline,
  onPressed: () {},
  child: Text('Outline'),
)''',
      ),
      ComponentExample(
        title: 'Sizes',
        description: 'Small, medium, large, and icon-only buttons.',
        preview: (context) => Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            CnButton(size: .sm, onPressed: () {}, child: const Text('Small')),
            CnButton(onPressed: () {}, child: const Text('Medium')),
            CnButton(size: .lg, onPressed: () {}, child: const Text('Large')),
            CnButton(
              size: .icon,
              onPressed: () {},
              child: const Icon(Icons.star_border),
            ),
          ],
        ),
        code: '''CnButton(size: .sm, onPressed: () {}, child: Text('Small'))

CnButton(onPressed: () {}, child: Text('Medium'))

CnButton(size: .lg, onPressed: () {}, child: Text('Large'))

CnButton(
  size: .icon,
  onPressed: () {},
  child: Icon(Icons.star_border),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Button Group',
    description: 'Grouped buttons with separators or labels.',
    examples: [
      ComponentExample(
        title: 'Joined actions',
        description: 'Buttons share a single outline.',
        preview: (context) => const _ButtonGroupJoinedPreview(),
        code: '''final radius = CnTheme.of(context).radius - 4;

CnButtonGroup(
  children: [
    CnButton(
      variant: .ghost,
      borderRadius: BorderRadius.horizontal(left: Radius.circular(radius)),
      onPressed: () {},
      child: Text('Back'),
    ),
    CnButtonGroupSeparator(),
    CnButton(
      variant: .ghost,
      borderRadius: BorderRadius.zero,
      onPressed: () {},
      child: Text('Details'),
    ),
    CnButtonGroupSeparator(),
    CnButton(
      variant: .ghost,
      borderRadius: BorderRadius.horizontal(right: Radius.circular(radius)),
      onPressed: () {},
      child: Text('Next'),
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Vertical stack',
        description: 'Mix text and separators between actions.',
        preview: (context) => const _ButtonGroupStackedPreview(),
        code: '''CnButtonGroup(
  orientation: .vertical,
  children: [
    CnButton(variant: .ghost, onPressed: () {}, child: Text('Personal')),
    CnButtonGroupSeparator(),
    CnButtonGroupText(child: Text('or')),
    CnButtonGroupSeparator(),
    CnButton(variant: .ghost, onPressed: () {}, child: Text('Team')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Badge',
    description: 'Compact label to highlight status or metadata.',
    examples: [
      ComponentExample(
        title: 'Variants',
        description: 'Primary, secondary, outline, and destructive badges.',
        preview: (context) => Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            CnBadge(child: Text('New')),
            CnBadge(variant: .secondary, child: Text('Beta')),
            CnBadge(variant: .outline, child: Text('Outline')),
            CnBadge(variant: .destructive, child: Text('Alert')),
          ],
        ),
        code: '''CnBadge(child: Text('New'))

CnBadge(variant: .outline, child: Text('Outline'))''',
      ),
      ComponentExample(
        title: 'With icon',
        description: 'Combine badges with compact icons.',
        preview: (context) => Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            CnBadge(
              child: Row(
                mainAxisSize: .min,
                spacing: 6,
                children: const [
                  Icon(Icons.fiber_manual_record, size: 10),
                  Text('Live'),
                ],
              ),
            ),
            CnBadge(
              variant: .outline,
              child: Row(
                mainAxisSize: .min,
                spacing: 6,
                children: const [
                  Icon(Icons.local_fire_department_outlined, size: 14),
                  Text('Trending'),
                ],
              ),
            ),
          ],
        ),
        code: '''CnBadge(
  child: Row(
    mainAxisSize: .min,
    spacing: 6,
    children: [
      Icon(Icons.fiber_manual_record, size: 10),
      Text('Live'),
    ],
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Card',
    description: 'Surface container for grouped content.',
    examples: [
      ComponentExample(
        title: 'Header and footer',
        description: 'Structured content with actions.',
        preview: (context) => CnCard(
          header: Text(
            'Project Alpha',
            style: CnTheme.textThemeOf(context).titleMedium,
          ),
          content: Text(
            'Track milestones, review feedback, and share updates in one place.',
            style: CnTheme.textThemeOf(context).bodyMedium,
          ),
          footer: CnButton(
            variant: .outline,
            onPressed: () {},
            child: const Text('View details'),
          ),
        ),
        code: '''CnCard(
  header: Text('Project Alpha'),
  content: Text('Track milestones and share updates.'),
  footer: CnButton(
    variant: .outline,
    onPressed: () {},
    child: Text('View details'),
  ),
)''',
      ),
      ComponentExample(
        title: 'Media card',
        description: 'Combine imagery, text, and actions.',
        preview: (context) {
          final scheme = CnTheme.colorSchemeOf(context);
          final radius = CnTheme.of(context).radius;
          return SizedBox(
            width: 320,
            child: CnCard(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 12,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: .circular(radius - 4),
                      gradient: LinearGradient(
                        colors: [
                          scheme.primaryContainer,
                          scheme.secondaryContainer,
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Summer release',
                    style: CnTheme.textThemeOf(context).titleSmall,
                  ),
                  Text(
                    'New components, tokens, and layouts for the web kit.',
                    style: CnTheme.textThemeOf(context).bodySmall,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      const CnBadge(variant: .outline, child: Text('Update')),
                      CnButton(
                        size: .sm,
                        onPressed: () {},
                        child: const Text('View'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        code: '''CnCard(
  child: Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [
      Container(height: 140),
      Text('Summer release'),
      Text('New components, tokens, and layouts.'),
      Row(
        spacing: 8,
        children: [
          CnBadge(variant: .outline, child: Text('Update')),
          CnButton(size: .sm, onPressed: () {}, child: Text('View')),
        ],
      ),
    ],
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Carousel',
    description: 'Scrollable panels with controls and indicators.',
    examples: [
      ComponentExample(
        title: 'Autoplay',
        description: 'Looping carousel with indicators.',
        preview: (context) => const _CarouselPreview(),
        code: '''CnCarousel(
  height: 220,
  showIndicators: true,
  showArrows: true,
  loop: true,
  autoPlay: true,
  items: [
    Container(color: Colors.blueGrey),
    Container(color: Colors.amber),
    Container(color: Colors.teal),
  ],
)''',
      ),
      ComponentExample(
        title: 'Manual',
        description: 'Compact carousel without indicators.',
        preview: (context) {
          final scheme = CnTheme.colorSchemeOf(context);
          return SizedBox(
            width: 520,
            child: CnCarousel(
              height: 180,
              showIndicators: false,
              showArrows: true,
              loop: false,
              autoPlay: false,
              items: [
                Container(
                  color: scheme.surfaceContainerHighest,
                  child: Center(
                    child: Text(
                      'Release notes',
                      style: CnTheme.textThemeOf(context).titleSmall,
                    ),
                  ),
                ),
                Container(
                  color: scheme.primaryContainer,
                  child: Center(
                    child: Text(
                      'Team updates',
                      style: CnTheme.textThemeOf(context).titleSmall,
                    ),
                  ),
                ),
                Container(
                  color: scheme.secondaryContainer,
                  child: Center(
                    child: Text(
                      'Product tour',
                      style: CnTheme.textThemeOf(context).titleSmall,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        code: '''CnCarousel(
  height: 180,
  showIndicators: false,
  showArrows: true,
  autoPlay: false,
  items: [
    Container(child: Center(child: Text('Release notes'))),
    Container(child: Center(child: Text('Team updates'))),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Accordion',
    description: 'Stacked disclosure panels for dense content.',
    examples: [
      ComponentExample(
        title: 'Multiple',
        description: 'Allow multiple panels to stay open.',
        preview: (context) => const _AccordionPreview(),
        code: '''CnAccordion(
  allowMultiple: true,
  items: [
    CnAccordionItem(
      title: Text('Product'),
      content: Text('Manage pricing, inventory, and channels.'),
    ),
    CnAccordionItem(
      title: Text('Marketing'),
      content: Text('Plan campaigns and social launches.'),
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Single',
        description: 'Only one panel open at a time.',
        preview: (context) => const _AccordionSinglePreview(),
        code: '''CnAccordion(
  allowMultiple: false,
  items: [
    CnAccordionItem(title: Text('Overview'), content: Text('...')),
    CnAccordionItem(title: Text('Details'), content: Text('...')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Collapsible',
    description: 'Reveal or hide supporting content.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Toggle open and closed content.',
        preview: (context) => const _CollapsiblePreview(),
        code: '''CnCollapsible(
  title: Text('Team notes'),
  subtitle: Text('Shipping weekly on Wednesdays.'),
  child: Text('Capture decisions and align on priorities.'),
)''',
      ),
      ComponentExample(
        title: 'With leading and trailing',
        description: 'Add context with icons and badges.',
        preview: (context) => const _CollapsibleIconPreview(),
        code: '''CnCollapsible(
  title: Text('Weekly report'),
  leading: Icon(Icons.description_outlined),
  trailing: CnBadge(variant: .outline, child: Text('Draft')),
  child: Text('Share updates with the team.'),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Aspect Ratio',
    description: 'Keeps media aligned to a consistent ratio.',
    examples: [
      ComponentExample(
        title: 'Widescreen',
        description: 'Maintain a 16:9 layout.',
        preview: (context) => const _AspectRatioPreview(),
        code: '''CnAspectRatio(
  ratio: 16 / 9,
  child: Container(color: Colors.black12),
)''',
      ),
      ComponentExample(
        title: 'Square',
        description: 'Square thumbnails and covers.',
        preview: (context) {
          final scheme = CnTheme.colorSchemeOf(context);
          return SizedBox(
            width: 200,
            child: CnAspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: .circular(CnTheme.of(context).radius - 6),
                ),
                child: Center(
                  child: Text(
                    '1:1',
                    style: CnTheme.textThemeOf(context).titleSmall,
                  ),
                ),
              ),
            ),
          );
        },
        code: '''CnAspectRatio(
  ratio: 1,
  child: Container(child: Center(child: Text('1:1'))),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Scroll Area',
    description: 'Scrollable region with a visible scrollbar.',
    examples: [
      ComponentExample(
        title: 'Vertical list',
        description: 'Standard vertical scrolling content.',
        preview: (context) => const _ScrollAreaPreview(),
        code: '''CnScrollArea(
  height: 180,
  child: Column(
    children: [
      Text('Item 1'),
      Text('Item 2'),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'Horizontal',
        description: 'Scrollable chips and cards.',
        preview: (context) => const _ScrollAreaHorizontalPreview(),
        code: '''CnScrollArea(
  direction: .horizontal,
  height: 160,
  child: Row(children: [Text('Card 1'), Text('Card 2')]),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Resizable',
    description: 'Split panels with a draggable handle.',
    examples: [
      ComponentExample(
        title: 'Horizontal split',
        description: 'Adjust side-by-side panels.',
        preview: (context) => const _ResizablePreview(),
        code: '''CnResizable(
  primary: Container(color: Colors.black12),
  secondary: Container(color: Colors.black26),
  onChanged: (ratio) {},
)''',
      ),
      ComponentExample(
        title: 'Vertical split',
        description: 'Resize stacked panels.',
        preview: (context) => const _ResizableVerticalPreview(),
        code: '''CnResizable(
  direction: .vertical,
  primary: Container(color: Colors.black12),
  secondary: Container(color: Colors.black26),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Input',
    description: 'Single-line text input with consistent styling.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Use prefix icons to clarify context.',
        preview: (context) => const SizedBox(
          width: 320,
          child: CnInput(
            placeholder: 'Email address',
            prefixIcon: Icon(Icons.mail_outline),
          ),
        ),
        code: '''CnInput(
  placeholder: 'Email address',
  prefixIcon: Icon(Icons.mail_outline),
)''',
      ),
      ComponentExample(
        title: 'With actions',
        description: 'Add trailing icons for filters or shortcuts.',
        preview: (context) => const SizedBox(
          width: 320,
          child: CnInput(
            placeholder: 'Search projects',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.tune),
          ),
        ),
        code: '''CnInput(
  placeholder: 'Search projects',
  prefixIcon: Icon(Icons.search),
  suffixIcon: Icon(Icons.tune),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Input Group',
    description: 'Combine inputs with addons and buttons.',
    examples: [
      ComponentExample(
        title: 'URL builder',
        description: 'Prefix and action buttons in one row.',
        preview: (context) => const _InputGroupPreview(),
        code: '''CnInputGroup(
  children: [
    CnInputGroupText(text: 'https://'),
    CnInputGroupInput(placeholder: 'studio.io'),
    CnInputGroupButton(
      child: CnButton(
        variant: .ghost,
        borderRadius: BorderRadius.zero,
        onPressed: () {},
        child: Text('Go'),
      ),
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'With addons',
        description: 'Use icons or suffix labels.',
        preview: (context) => const _InputGroupAddonPreview(),
        code: '''CnInputGroup(
  children: [
    CnInputGroupAddon(child: Icon(Icons.search)),
    CnInputGroupInput(placeholder: 'Search'),
    CnInputGroupText(text: 'USD'),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Label',
    description: 'Accessible label for form controls.',
    examples: [
      ComponentExample(
        title: 'Inline',
        description: 'Required and optional labels.',
        preview: (context) => const _LabelPreview(),
        code: '''CnLabel(
  required: true,
  child: Text('Email'),
)''',
      ),
      ComponentExample(
        title: 'With field',
        description: 'Pair labels with inputs.',
        preview: (context) => const _LabelWithFieldPreview(),
        code: '''Column(
  crossAxisAlignment: .start,
  spacing: 8,
  children: [
    CnLabel(required: true, child: Text('Email')),
    CnInput(placeholder: 'name@company.com'),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Form',
    description: 'Form layout with labels and messages.',
    examples: [
      ComponentExample(
        title: 'Validated',
        description: 'Show validation and helper text.',
        preview: (context) => const _FormPreview(),
        code: '''CnForm(
  formKey: formKey,
  child: Column(
    children: [
      CnFormField(
        labelText: 'Name',
        required: true,
        child: TextFormField(decoration: InputDecoration(hintText: 'Ada Lovelace')),
      ),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'Inline actions',
        description: 'Compact form with actions aligned to the end.',
        preview: (context) => const _FormInlinePreview(),
        code: '''CnForm(
  child: Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [
      CnFormField(labelText: 'Workspace', child: CnInput()),
      Row(
        mainAxisAlignment: .end,
        spacing: 8,
        children: [
          CnButton(variant: .outline, onPressed: () {}, child: Text('Cancel')),
          CnButton(onPressed: () {}, child: Text('Create')),
        ],
      ),
    ],
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Field',
    description: 'Field layout with flexible label positioning.',
    examples: [
      ComponentExample(
        title: 'Field set',
        description: 'Group related fields with a legend.',
        preview: (context) => const _FieldSetPreview(),
        code: '''CnFieldSet(
  child: Column(
    crossAxisAlignment: .start,
    spacing: 16,
    children: [
      CnFieldLegend(child: Text('Contact details')),
      CnFieldGroup(
        children: [
          CnField(labelText: 'Name', child: CnInput()),
          CnField(labelText: 'Email', child: CnInput()),
        ],
      ),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'Horizontal layout',
        description: 'Align labels and content side by side.',
        preview: (context) => const _FieldHorizontalPreview(),
        code: '''CnField(
  layout: .horizontal,
  labelText: 'Workspace',
  descriptionText: 'Shown on your public profile.',
  child: CnInput(),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Combobox',
    description: 'Searchable dropdown for large lists.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Search and select from a list.',
        preview: (context) => const _ComboboxPreview(),
        code: '''CnCombobox(
  placeholder: 'Select a role',
  items: [
    CnComboboxItem(value: 'design', label: 'Design'),
    CnComboboxItem(value: 'engineering', label: 'Engineering'),
  ],
  onChanged: (value) => setState(() => role = value),
)''',
      ),
      ComponentExample(
        title: 'With icons',
        description: 'Include leading icons for quick scanning.',
        preview: (context) => const _ComboboxIconPreview(),
        code: '''CnCombobox(
  placeholder: 'Choose a channel',
  items: [
    CnComboboxItem(
      value: 'slack',
      label: 'Slack',
      leading: Icon(Icons.chat_bubble_outline),
    ),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Date Picker',
    description: 'Calendar picker with formatted value.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Pick a date from a modal calendar.',
        preview: (context) => const _DatePickerPreview(),
        code: '''CnDatePickerField(
  placeholder: 'Pick a date',
  value: selectedDate,
  onChanged: (value) => setState(() => selectedDate = value),
)''',
      ),
      ComponentExample(
        title: 'Preset',
        description: 'Prefill a date and disable clearing.',
        preview: (context) => const _DatePickerPresetPreview(),
        code: '''CnDatePickerField(
  value: DateTime(2024, 2, 10),
  allowClear: false,
  onChanged: (value) {},
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Input OTP',
    description: 'One-time password input with grouped slots.',
    examples: [
      ComponentExample(
        title: 'Grouped',
        description: 'Split inputs into groups for readability.',
        preview: (context) => const _InputOtpPreview(),
        code: '''CnInputOtp(
  length: 6,
  groupSize: 3,
  onChanged: (value) => setState(() => otp = value),
)''',
      ),
      ComponentExample(
        title: 'Obscured',
        description: 'Mask sensitive codes as they are typed.',
        preview: (context) => const CnInputOtp(
          length: 4,
          groupSize: 2,
          obscureText: true,
          numericOnly: false,
          separator: Text('-'),
        ),
        code: '''CnInputOtp(
  length: 4,
  groupSize: 2,
  obscureText: true,
  numericOnly: false,
  separator: Text('-'),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Textarea',
    description: 'Multi-line input for longer messages.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Expand to a comfortable reading width.',
        preview: (context) => const SizedBox(
          width: 420,
          child: CnTextarea(
            placeholder: 'Tell us about your project...',
            minLines: 4,
          ),
        ),
        code: '''CnTextarea(
  placeholder: 'Tell us about your project...',
  minLines: 4,
)''',
      ),
      ComponentExample(
        title: 'Compact',
        description: 'Shorter text areas for quick notes.',
        preview: (context) => const SizedBox(
          width: 360,
          child: CnTextarea(
            placeholder: 'Quick note',
            minLines: 2,
            maxLines: 4,
          ),
        ),
        code: '''CnTextarea(
  placeholder: 'Quick note',
  minLines: 2,
  maxLines: 4,
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Checkbox',
    description: 'Binary selection control for lists and forms.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Standard checkbox with label.',
        preview: (context) => const _CheckboxPreview(),
        code: '''CnCheckbox(
  value: agreed,
  onChanged: (value) => setState(() => agreed = value ?? false),
  label: Text('Accept terms and conditions'),
)''',
      ),
      ComponentExample(
        title: 'Disabled states',
        description: 'Show checked and unchecked disabled items.',
        preview: (context) => const Row(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            CnCheckbox(value: true, onChanged: null, label: Text('Subscribed')),
            CnCheckbox(value: false, onChanged: null, label: Text('Archived')),
          ],
        ),
        code: '''CnCheckbox(
  value: true,
  onChanged: null,
  label: Text('Subscribed'),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Switch',
    description: 'Toggle control for settings.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Use switches for on/off settings.',
        preview: (context) => const _SwitchPreview(),
        code: '''CnSwitch(
  value: notificationsOn,
  onChanged: (value) => setState(() => notificationsOn = value),
  label: Text('Email notifications'),
)''',
      ),
      ComponentExample(
        title: 'Disabled',
        description: 'Show unavailable states.',
        preview: (context) => const Row(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            CnSwitch(value: true, onChanged: null, label: Text('Sync enabled')),
            CnSwitch(
              value: false,
              onChanged: null,
              label: Text('Sync disabled'),
            ),
          ],
        ),
        code: '''CnSwitch(
  value: true,
  onChanged: null,
  label: Text('Sync enabled'),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Toggle',
    description: 'Pressed state button for toggling preferences.',
    examples: [
      ComponentExample(
        title: 'Variants',
        description: 'Outline and ghost toggles.',
        preview: (context) => const _TogglePreview(),
        code: '''CnToggle(
  value: starred,
  onChanged: (value) => setState(() => starred = value),
  child: Icon(Icons.star_border),
)''',
      ),
      ComponentExample(
        title: 'Sizes',
        description: 'Small, medium, and large toggles.',
        preview: (context) => const _ToggleSizePreview(),
        code:
            '''CnToggle(size: .sm, value: selected, onChanged: (v) {}, child: Text('Sm'))
CnToggle(size: .md, value: selected, onChanged: (v) {}, child: Text('Md'))
CnToggle(size: .lg, value: selected, onChanged: (v) {}, child: Text('Lg'))''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Toggle Group',
    description: 'Group toggles with single or multiple selection.',
    examples: [
      ComponentExample(
        title: 'Joined',
        description: 'Single and multiple selection in a joined row.',
        preview: (context) => const _ToggleGroupPreview(),
        code: '''CnToggleGroup(
  joined: true,
  allowMultiple: false,
  selectedValues: {'left'},
  onChanged: (value) => setState(() => selected = value),
  items: [
    CnToggleGroupItem(value: 'left', child: Icon(Icons.format_align_left)),
    CnToggleGroupItem(value: 'center', child: Icon(Icons.format_align_center)),
    CnToggleGroupItem(value: 'right', child: Icon(Icons.format_align_right)),
  ],
)''',
      ),
      ComponentExample(
        title: 'Separated',
        description: 'Standalone toggles with multiple selection.',
        preview: (context) => const _ToggleGroupSeparatedPreview(),
        code: '''CnToggleGroup(
  allowMultiple: true,
  selectedValues: {'bold'},
  onChanged: (value) => setState(() => selected = value),
  items: [
    CnToggleGroupItem(value: 'bold', child: Icon(Icons.format_bold)),
    CnToggleGroupItem(value: 'italic', child: Icon(Icons.format_italic)),
    CnToggleGroupItem(value: 'code', child: Icon(Icons.code)),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Radio Group',
    description: 'Exclusive option selection.',
    examples: [
      ComponentExample(
        title: 'Stacked',
        description: 'Vertical layout for longer labels.',
        preview: (context) => const _RadioPreview(),
        code: '''CnRadioGroup<String>(
  groupValue: plan,
  onChanged: (value) => setState(() => plan = value ?? plan),
  child: Column(
    children: [
      CnRadio<String>(value: 'starter', label: Text('Starter')),
      CnRadio<String>(value: 'growth', label: Text('Growth')),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'Inline',
        description: 'Horizontal layout for compact choices.',
        preview: (context) => const _RadioInlinePreview(),
        code: '''CnRadioGroup<String>(
  groupValue: plan,
  onChanged: (value) => setState(() => plan = value ?? plan),
  child: Row(
    spacing: 16,
    children: [
      CnRadio<String>(value: 'monthly', label: Text('Monthly')),
      CnRadio<String>(value: 'yearly', label: Text('Yearly')),
    ],
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Select',
    description: 'Dropdown menu for selecting one option.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Standard select with full width.',
        preview: (context) => const _SelectPreview(),
        code: '''CnSelect<String>(
  value: team,
  placeholder: 'Pick a team',
  items: [
    DropdownMenuItem(value: 'design', child: Text('Design')),
    DropdownMenuItem(value: 'product', child: Text('Product')),
    DropdownMenuItem(value: 'engineering', child: Text('Engineering')),
  ],
  onChanged: (value) => setState(() => team = value),
)''',
      ),
      ComponentExample(
        title: 'Compact',
        description: 'Shrink the select for inline layouts.',
        preview: (context) => const _SelectCompactPreview(),
        code: '''CnSelect<String>(
  isExpanded: false,
  value: plan,
  items: [
    DropdownMenuItem(value: 'starter', child: Text('Starter')),
    DropdownMenuItem(value: 'pro', child: Text('Pro')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Native Select',
    description: 'System-native select menus with groups.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Simple native dropdown.',
        preview: (context) => const _NativeSelectPreview(),
        code: '''CnNativeSelect<String?>(
  value: team,
  placeholder: 'Select team',
  entries: [
    CnNativeSelectOption(value: 'design', label: 'Design'),
    CnNativeSelectOption(value: 'product', label: 'Product'),
    CnNativeSelectOption(value: 'engineering', label: 'Engineering'),
  ],
  onChanged: (value) => setState(() => team = value),
)''',
      ),
      ComponentExample(
        title: 'Grouped',
        description: 'Organize options with optgroups.',
        preview: (context) => const _NativeSelectGroupPreview(),
        code: '''CnNativeSelect<String?>(
  placeholder: 'Choose a plan',
  entries: [
    CnNativeSelectOptGroup(
      label: 'Personal',
      options: [
        CnNativeSelectOption(value: 'starter', label: 'Starter'),
        CnNativeSelectOption(value: 'plus', label: 'Plus'),
      ],
    ),
    CnNativeSelectOptGroup(
      label: 'Business',
      options: [
        CnNativeSelectOption(value: 'pro', label: 'Pro'),
        CnNativeSelectOption(value: 'enterprise', label: 'Enterprise'),
      ],
    ),
  ],
  onChanged: (value) => setState(() => plan = value),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Tabs',
    description: 'Segmented content with animated indicator.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Two-tab layout with fixed width.',
        preview: (context) => const _TabsPreview(),
        code: '''CnTabs(
  contentHeight: 120,
  tabs: [
    CnTab(label: 'Overview', child: Text('Overview content')),
    CnTab(label: 'Details', child: Text('Detail content')),
  ],
)''',
      ),
      ComponentExample(
        title: 'Scrollable',
        description: 'Use scrollable tabs for larger sets.',
        preview: (context) => const _TabsScrollablePreview(),
        code: '''CnTabs(
  isScrollable: true,
  tabs: [
    CnTab(label: 'Overview', child: Text('...')),
    CnTab(label: 'Analytics', child: Text('...')),
    CnTab(label: 'Billing', child: Text('...')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Breadcrumb',
    description: 'Hierarchy navigation with separators.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Show the current page in the hierarchy.',
        preview: (context) => const _BreadcrumbPreview(),
        code: '''CnBreadcrumb(
  items: [
    CnBreadcrumbItem(label: Text('Home'), onTap: () {}),
    CnBreadcrumbItem(label: Text('Library'), onTap: () {}),
    CnBreadcrumbItem(label: Text('Data'), isCurrent: true),
  ],
)''',
      ),
      ComponentExample(
        title: 'With icons',
        description: 'Use icons to reinforce navigation.',
        preview: (context) => const _BreadcrumbIconPreview(),
        code: '''CnBreadcrumb(
  items: [
    CnBreadcrumbItem(label: Row(children: [Icon(Icons.home), Text('Home')])),
    CnBreadcrumbItem(label: Text('Billing'), isCurrent: true),
  ],
)''',
      ),
      ComponentExample(
        title: 'Collapsed',
        description: 'Collapse longer trails into a menu.',
        preview: (context) => const _BreadcrumbCollapsedPreview(),
        code: '''CnBreadcrumb(
  collapse: true,
  items: [
    for (var i = 1; i <= 7; i++) CnBreadcrumbItem(label: Text('Item \$i')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Menubar',
    description: 'Top-level menus with nested actions.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'File and edit actions with submenus.',
        preview: (context) => const _MenubarPreview(),
        code: '''CnMenubar(
  menus: [
    CnMenu(
      label: 'File',
      entries: [
        CnMenuAction(label: 'New tab', onSelected: () {}),
        CnMenuAction(label: 'New window', onSelected: () {}),
      ],
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'With icons',
        description: 'Add icons and destructive actions.',
        preview: (context) => const _MenubarIconPreview(),
        code: '''CnMenuAction(
  label: 'Delete',
  role: .destructive,
  leading: Icon(Icons.delete_outline),
  onSelected: () {},
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Navigation Menu',
    description: 'Top navigation with expandable panels.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Expandable menu with links.',
        preview: (context) => const _NavigationMenuPreview(),
        code: '''CnNavigationMenu(
  items: [
    CnNavigationMenuItem(
      label: 'Solutions',
      links: [
        CnNavigationMenuLink(
          title: 'Analytics',
          description: 'Real-time insights for your team.',
          onTap: () {},
        ),
      ],
    ),
    CnNavigationMenuItem(label: 'Pricing', onTap: () {}),
  ],
)''',
      ),
      ComponentExample(
        title: 'With icons',
        description: 'Add leading icons to items and links.',
        preview: (context) => const _NavigationMenuIconPreview(),
        code: '''CnNavigationMenuItem(
  label: 'Resources',
  leading: Icon(Icons.book_outlined),
  links: [
    CnNavigationMenuLink(
      title: 'Docs',
      leading: Icon(Icons.description_outlined),
    ),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Pagination',
    description: 'Navigate across large data sets.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Pagination with previous and next.',
        preview: (context) => const _PaginationPreview(),
        code: '''CnPagination(
  currentPage: page,
  totalPages: 12,
  onPageChanged: (value) => setState(() => page = value),
)''',
      ),
      ComponentExample(
        title: 'Compact',
        description: 'Smaller pagination without prev/next.',
        preview: (context) => const _PaginationCompactPreview(),
        code: '''CnPagination(
  currentPage: page,
  totalPages: 12,
  showPrevNext: false,
  maxButtons: 7,
  onPageChanged: (value) => setState(() => page = value),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Sidebar',
    description: 'Collapsible navigation rail with grouped items.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Header, groups, and footer content.',
        preview: (context) => const _SidebarPreview(),
        code: '''final controller = CnSidebarController();

CnSidebarProvider(
  controller: controller,
  child: CnSidebar(
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        CnSidebarHeader(
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('Workspace'),
              CnSidebarTrigger(),
            ],
          ),
        ),
        CnSidebarContent(
          children: [
            CnSidebarGroup(
              title: 'Projects',
              children: [
                CnSidebarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  label: Text('Overview'),
                  selected: true,
                ),
                CnSidebarItem(
                  icon: Icon(Icons.people_outline),
                  label: Text('Team'),
                ),
              ],
            ),
          ],
        ),
        CnSidebarFooter(child: Text('v2.3.1')),
      ],
    ),
  ),
)''',
      ),
      ComponentExample(
        title: 'Collapsed',
        description: 'Icon-only sidebar for tight layouts.',
        preview: (context) => const _SidebarCollapsedPreview(),
        code: '''final controller = CnSidebarController(collapsed: true);

CnSidebarProvider(
  controller: controller,
  child: CnSidebar(
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        CnSidebarHeader(child: CnSidebarTrigger()),
        CnSidebarContent(
          children: [
            CnSidebarItem(icon: Icon(Icons.inbox_outlined), label: Text('Inbox')),
            CnSidebarItem(icon: Icon(Icons.settings_outlined), label: Text('Settings')),
          ],
        ),
      ],
    ),
  ),
)''',
      ),
      ComponentExample(
        title: 'Search and sections',
        description: 'Nested items and a sidebar search bar.',
        preview: (context) => const _SidebarDetailPreview(),
        code: '''CnSidebar(
  child: Column(
    crossAxisAlignment: .stretch,
    spacing: 12,
    children: [
      CnSidebarHeader(
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('Library'),
            CnSidebarTrigger(),
          ],
        ),
      ),
      CnSidebarSearch(placeholder: 'Search'),
      CnSidebarSeparator(),
      CnSidebarContent(
        children: [
          CnSidebarGroup(
            title: 'Collections',
            children: [
              CnSidebarItem(
                icon: Icon(Icons.folder_open_outlined),
                label: Text('Design'),
                selected: true,
              ),
              CnSidebarSubItem(label: Text('Briefs')),
              CnSidebarSubItem(label: Text('Assets')),
            ],
          ),
        ],
      ),
    ],
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Tooltip',
    description: 'Contextual helper text on hover or long press.',
    examples: [
      ComponentExample(
        title: 'Icon',
        description: 'Minimal tooltip for icon buttons.',
        preview: (context) => const CnTooltip(
          message: 'Invite collaborators',
          child: Icon(Icons.person_add_alt_1),
        ),
        code: '''CnTooltip(
  message: 'Invite collaborators',
  child: Icon(Icons.person_add_alt_1),
)''',
      ),
      ComponentExample(
        title: 'Button',
        description: 'Pair tooltips with actions.',
        preview: (context) => CnTooltip(
          message: 'Save changes',
          child: CnButton(
            variant: .outline,
            onPressed: () {},
            child: const Text('Hover me'),
          ),
        ),
        code: '''CnTooltip(
  message: 'Save changes',
  child: CnButton(
    variant: .outline,
    onPressed: () {},
    child: Text('Hover me'),
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Alert',
    description: 'Highlight important messages with emphasis.',
    examples: [
      ComponentExample(
        title: 'Variants',
        description: 'Info and destructive styles.',
        preview: (context) => const _AlertPreview(),
        code: '''CnAlert(
  variant: .info,
  title: Text('Heads up'),
  description: Text('You can now edit this project.'),
)''',
      ),
      ComponentExample(
        title: 'With action',
        description: 'Include a trailing action button.',
        preview: (context) => CnAlert(
          variant: .warning,
          title: const Text('Plan expiring soon'),
          description: const Text(
            'Upgrade to keep access to premium features.',
          ),
          trailing: CnButton(
            size: .sm,
            onPressed: () {},
            child: const Text('Upgrade'),
          ),
        ),
        code: '''CnAlert(
  variant: .warning,
  title: Text('Plan expiring soon'),
  description: Text('Upgrade to keep access.'),
  trailing: CnButton(size: .sm, onPressed: () {}, child: Text('Upgrade')),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Command',
    description: 'Command palette with search and grouped actions.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Grouped commands with shortcuts.',
        preview: (context) => const _CommandPreview(),
        code: '''CnCommand(
  groups: [
    CnCommandGroup(
      label: 'Suggestions',
      items: [
        CnCommandItem(
          label: 'New project',
          description: 'Create a new workspace',
          onSelected: () {},
        ),
      ],
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Empty state',
        description: 'Show a friendly empty state for no matches.',
        preview: (context) => const _CommandEmptyPreview(),
        code: '''CnCommand(
  emptyText: 'No results found.',
  groups: [CnCommandGroup(label: 'Suggestions', items: [])],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Context Menu',
    description: 'Right click or long press to reveal actions.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Simple action list.',
        preview: (context) => const _ContextMenuPreview(),
        code: '''CnContextMenu(
  entries: [
    CnDropdownMenuAction(label: 'Rename', onSelected: () {}),
    CnDropdownMenuAction(label: 'Duplicate', onSelected: () {}),
  ],
  child: Container(child: Text('Right click here')),
)''',
      ),
      ComponentExample(
        title: 'Selections',
        description: 'Checkboxes and radio selections.',
        preview: (context) => const _ContextMenuSelectionPreview(),
        code: '''CnContextMenu(
  entries: [
    CnDropdownMenuCheckboxItem(label: 'Pin to top', checked: true),
    CnDropdownMenuRadioItem(
      label: 'Compact',
      value: 'compact',
      groupValue: 'compact',
    ),
  ],
  child: Container(child: Text('Right click for options')),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Drawer',
    description: 'Mobile-friendly drawer overlay.',
    examples: [
      ComponentExample(
        title: 'Left drawer',
        description: 'Slide in a contextual panel.',
        preview: (context) => const _DrawerPreview(),
        code: '''showCnDrawer(
  context: context,
  side: .left,
  builder: (_) => CnDrawer(title: Text('Share access')),
)''',
      ),
      ComponentExample(
        title: 'Right drawer',
        description: 'Use the right side for secondary tasks.',
        preview: (context) => const _DrawerRightPreview(),
        code: '''showCnDrawer(
  context: context,
  side: .right,
  builder: (_) => CnDrawer(side: .right, title: Text('Filters')),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Hover Card',
    description: 'Display rich info on hover.',
    examples: [
      ComponentExample(
        title: 'Profile card',
        description: 'Show detailed info on hover.',
        preview: (context) => const _HoverCardPreview(),
        code: '''CnHoverCard(
  content: Text('Project owner and activity'),
  child: CnAvatar(initials: 'CN'),
)''',
      ),
      ComponentExample(
        title: 'Compact',
        description: 'Smaller hover cards for hints.',
        preview: (context) => const _HoverCardCompactPreview(),
        code: '''CnHoverCard(
  width: 220,
  content: Text('Last updated 2 hours ago.'),
  child: CnBadge(child: Text('Updates')),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Sheet',
    description: 'Slide-in panel for contextual tasks.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Bottom sheet with actions.',
        preview: (context) => const _SheetPreview(),
        code: '''showCnSheet(
  context: context,
  builder: (_) => CnSheet(
    title: Text('Project settings'),
    content: Text('Manage access and billing.'),
  ),
)''',
      ),
      ComponentExample(
        title: 'Compact',
        description: 'Shorter sheet for quick actions.',
        preview: (context) => const _SheetCompactPreview(),
        code: '''CnSheet(
  heightFactor: 0.4,
  showHandle: false,
  showCloseButton: false,
  title: Text('Quick add'),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Dialog',
    description: 'Custom modal dialog for richer layouts.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Dialog with content and actions.',
        preview: (context) => const _DialogPreview(),
        code: '''showDialog(
  context: context,
  builder: (_) => CnDialog(
    title: Text('Invite team'),
    content: CnInput(placeholder: 'email@company.com'),
  ),
)''',
      ),
      ComponentExample(
        title: 'Confirmation',
        description: 'Compact confirmation dialog.',
        preview: (context) => const _DialogConfirmPreview(),
        code: '''CnDialog(
  title: Text('Delete project?'),
  showCloseButton: false,
  actions: [
    CnButton(variant: .outline, onPressed: () {}, child: Text('Cancel')),
    CnButton(variant: .destructive, onPressed: () {}, child: Text('Delete')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Dropdown Menu',
    description: 'Contextual menu with actions and toggles.',
    examples: [
      ComponentExample(
        title: 'Selections',
        description: 'Checkbox and radio menu items.',
        preview: (context) => const _DropdownMenuPreview(),
        code: '''CnDropdownMenu(
  triggerBuilder: (context, controller) => CnButton(
    variant: .outline,
    onPressed: () {
      if (controller.isOpen) {
        controller.close();
      } else {
        controller.open();
      }
    },
    child: Text('Open menu'),
  ),
  entries: [
    CnDropdownMenuCheckboxItem(
      label: 'Pin to top',
      checked: true,
      onChanged: (value) {},
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Submenu',
        description: 'Nested options within a dropdown.',
        preview: (context) => const _DropdownMenuSubmenuPreview(),
        code: '''CnDropdownMenuSubmenu(
  label: 'Export',
  entries: [
    CnDropdownMenuAction(label: 'PDF', onSelected: () {}),
    CnDropdownMenuAction(label: 'CSV', onSelected: () {}),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Popover',
    description: 'Lightweight overlay with custom content.',
    examples: [
      ComponentExample(
        title: 'Quick actions',
        description: 'Popover with contextual actions.',
        preview: (context) => const _PopoverPreview(),
        code: '''CnPopover(
  triggerBuilder: (context, controller) => CnButton(
    variant: .outline,
    onPressed: () {
      if (controller.isOpen) {
        controller.close();
      } else {
        controller.open();
      }
    },
    child: Text('Open popover'),
  ),
  content: Column(
    crossAxisAlignment: .start,
    spacing: 8,
    children: [
      Text('Quick actions'),
      Text('Add a teammate or create a new project.'),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'Form',
        description: 'Inline forms in a popover.',
        preview: (context) => const _PopoverFormPreview(),
        code: '''CnPopover(
  triggerBuilder: (context, controller) => CnButton(
    variant: .outline,
    onPressed: () {
      if (controller.isOpen) {
        controller.close();
      } else {
        controller.open();
      }
    },
    child: Text('Edit status'),
  ),
  content: Column(children: [CnInput(), CnButton(child: Text('Save'))]),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Alert Dialog',
    description: 'Interruptive confirmation dialog.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Confirm a destructive action.',
        preview: (context) => const _AlertDialogPreview(),
        code: '''showCnDialog(
  context: context,
  builder: (dialog) => CnAlertDialog(
    title: Text('Are you absolutely sure?'),
    content: Text('This action cannot be undone.'),
    actions: [
      CnButton(variant: .outline, onPressed: dialog.cancel, child: Text('Cancel')),
      CnButton(onPressed: dialog.result, child: Text('Continue')),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'Destructive',
        description: 'Emphasize destructive actions.',
        preview: (context) => const _AlertDialogDestructivePreview(),
        code: '''CnAlertDialog(
  title: Text('Delete project?'),
  content: Text('This action cannot be undone.'),
  actions: [
    CnButton(variant: .outline, onPressed: () {}, child: Text('Cancel')),
    CnButton(variant: .destructive, onPressed: () {}, child: Text('Delete')),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Avatar',
    description: 'Profile image with fallback initials.',
    examples: [
      ComponentExample(
        title: 'Sizes',
        description: 'Use different sizes for density.',
        preview: (context) => const Row(
          mainAxisSize: .min,
          spacing: 12,
          children: [
            CnAvatar(initials: 'AM'),
            CnAvatar(initials: 'CR', size: 48),
          ],
        ),
        code: '''CnAvatar(initials: 'AM')

CnAvatar(initials: 'CR', size: 48)''',
      ),
      ComponentExample(
        title: 'Custom colors',
        description: 'Match avatar colors to roles.',
        preview: (context) {
          final scheme = CnTheme.colorSchemeOf(context);
          return Wrap(
            spacing: 12,
            children: [
              CnAvatar(
                initials: 'PM',
                backgroundColor: scheme.secondaryContainer,
                foregroundColor: scheme.onSecondaryContainer,
              ),
              CnAvatar(
                initials: 'ENG',
                backgroundColor: scheme.tertiaryContainer,
                foregroundColor: scheme.onTertiaryContainer,
              ),
            ],
          );
        },
        code: '''CnAvatar(
  initials: 'PM',
  backgroundColor: scheme.secondaryContainer,
  foregroundColor: scheme.onSecondaryContainer,
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Avatar Group',
    description: 'Overlapping avatars for stacked participants.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Overlap a list of avatars.',
        preview: (context) => const _AvatarGroupPreview(),
        code: '''CnAvatarGroup(
  children: [
    CnAvatar(initials: 'CN'),
    CnAvatar(initials: 'MD'),
    CnAvatar(initials: 'TL'),
  ],
)''',
      ),
      ComponentExample(
        title: 'Vertical',
        description: 'Stack avatars vertically.',
        preview: (context) => const _AvatarGroupVerticalPreview(),
        code: '''CnAvatarGroup(
  direction: .vertical,
  children: [
    CnAvatar(initials: 'CN'),
    CnAvatar(initials: 'MD'),
    CnAvatar(initials: 'TL'),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Calendar',
    description: 'Month view with presets, ranges, and multiple selection.',
    examples: [
      ComponentExample(
        title: 'With presets',
        description: 'Quickly jump to common dates.',
        preview: (context) => const _CalendarPresetsPreview(),
        code: '''CnCalendar(
  selectionMode: .single,
  selectedDate: selected,
  onDateSelected: (value) => setState(() => selected = value),
)

Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    CnButton(variant: .outline, onPressed: () => selectPreset(0), child: Text('Today')),
    CnButton(variant: .outline, onPressed: () => selectPreset(1), child: Text('Tomorrow')),
  ],
)''',
      ),
      ComponentExample(
        title: 'With time',
        description: 'Attach start and end times.',
        preview: (context) => const _CalendarWithTimePreview(),
        code: '''CnCalendar(
  selectionMode: .single,
  selectedDate: selected,
  onDateSelected: (value) => setState(() => selected = value),
)

CnSelect<TimeOfDay>(
  value: startTime,
  items: [
    DropdownMenuItem(
      value: TimeOfDay(hour: 10, minute: 30),
      child: Text('10:30'),
    ),
  ],
  onChanged: (value) => setState(() => startTime = value!),
)''',
      ),
      ComponentExample(
        title: 'Range',
        description: 'Show consecutive months for longer ranges.',
        preview: (context) => const _CalendarRangeMultiMonthPreview(),
        code: '''CnCalendar(
  selectionMode: .range,
  monthsToDisplay: 2,
  selectedRange: range,
  onRangeSelected: (value) => setState(() => range = value),
)''',
      ),
      ComponentExample(
        title: 'Booked dates',
        description: 'Disable and decorate unavailable days.',
        preview: (context) => const _CalendarBookedPreview(),
        code: '''CnCalendar(
  selectionMode: .single,
  selectedDate: selected,
  isDateSelectable: (date) => !unavailable(date),
  dayBuilder: (context, date, state) => Text(
    date.day.toString(),
    style: state.textStyle?.copyWith(
      decoration: unavailable(date) ? TextDecoration.lineThrough : null,
    ),
  ),
)''',
      ),
      ComponentExample(
        title: 'Multiple',
        description: 'Select multiple dates.',
        preview: (context) => const _CalendarMultiplePreview(),
        code: '''CnCalendar(
  selectionMode: .multiple,
  selectedDates: selectedDates,
  onDatesSelected: (value) => setState(() => selectedDates = value),
)''',
      ),
      ComponentExample(
        title: 'Single with dropdowns',
        description: 'Pick month and year from dropdowns.',
        preview: (context) => const _CalendarDropdownPreview(),
        code: '''CnCalendar(
  selectionMode: .single,
  headerVariant: CnCalendarHeaderVariant.dropdowns,
  selectedDate: selected,
  onDateSelected: (value) => setState(() => selected = value),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Chart',
    description: 'Data visualization for trends and comparisons.',
    examples: [
      ComponentExample(
        title: 'Bar chart',
        description: 'Compare values across categories.',
        preview: (context) => const _ChartBarPreview(),
        code: '''CnChart(
  series: [
    CnChartSeries(
      name: 'Revenue',
      type: .bar,
      data: [
        CnChartPoint('Jan', 24),
        CnChartPoint('Feb', 32),
        CnChartPoint('Mar', 28),
        CnChartPoint('Apr', 40),
      ],
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Line chart',
        description: 'Show multiple trends over time.',
        preview: (context) => const _ChartLinePreview(),
        code: '''CnChart(
  series: [
    CnChartSeries(
      name: 'Visitors',
      type: .line,
      data: [
        CnChartPoint('Mon', 18),
        CnChartPoint('Tue', 26),
        CnChartPoint('Wed', 22),
        CnChartPoint('Thu', 30),
        CnChartPoint('Fri', 34),
      ],
    ),
    CnChartSeries(
      name: 'Signups',
      type: .line,
      data: [
        CnChartPoint('Mon', 6),
        CnChartPoint('Tue', 10),
        CnChartPoint('Wed', 8),
        CnChartPoint('Thu', 12),
        CnChartPoint('Fri', 14),
      ],
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Area chart',
        description: 'Highlight volume with a filled trend.',
        preview: (context) => const _ChartAreaPreview(),
        code: '''CnChart(
  series: [
    CnChartSeries(
      name: 'Active users',
      type: .area,
      data: [
        CnChartPoint('Mon', 42),
        CnChartPoint('Tue', 58),
        CnChartPoint('Wed', 52),
        CnChartPoint('Thu', 64),
        CnChartPoint('Fri', 72),
      ],
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Combo',
        description: 'Mix bars and lines for targets.',
        preview: (context) => const _ChartComboPreview(),
        code: '''CnChart(
  series: [
    CnChartSeries(
      name: 'Orders',
      type: .bar,
      data: [
        CnChartPoint('Jan', 24),
        CnChartPoint('Feb', 28),
        CnChartPoint('Mar', 26),
        CnChartPoint('Apr', 32),
      ],
    ),
    CnChartSeries(
      name: 'Target',
      type: .line,
      showPoints: false,
      data: [
        CnChartPoint('Jan', 30),
        CnChartPoint('Feb', 30),
        CnChartPoint('Mar', 30),
        CnChartPoint('Apr', 30),
      ],
    ),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Empty',
    description: 'Empty state layouts for blank content.',
    examples: [
      ComponentExample(
        title: 'No results',
        description: 'Guide users with empty state actions.',
        preview: (context) => const _EmptyPreview(),
        code: '''CnEmpty(
  media: CnEmptyMedia(child: Icon(Icons.search_off)),
  title: CnEmptyTitle(child: Text('No results found')),
  description: CnEmptyDescription(
    child: Text('Try adjusting your filters or search query.'),
  ),
  actions: Row(
    mainAxisSize: .min,
    spacing: 8,
    children: [
      CnButton(variant: .outline, onPressed: () {}, child: Text('Clear')),
      CnButton(onPressed: () {}, child: Text('New search')),
    ],
  ),
)''',
      ),
      ComponentExample(
        title: 'With media',
        description: 'Highlight illustrations or iconography.',
        preview: (context) => const _EmptyMediaPreview(),
        code: '''final scheme = CnTheme.colorSchemeOf(context);

CnEmpty(
  media: CnEmptyMedia(
    variant: .image,
    child: Container(color: scheme.surfaceContainerHighest),
  ),
  title: CnEmptyTitle(child: Text('No projects yet')),
  description: CnEmptyDescription(
    child: Text('Create your first workspace to get started.'),
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Item',
    description: 'List items for files, messages, and settings.',
    examples: [
      ComponentExample(
        title: 'File list',
        description: 'Media, title, and description layouts.',
        preview: (context) => const _ItemListPreview(),
        code: '''CnItemGroup(
  children: [
    CnItem(
      media: CnItemMedia(variant: .icon, child: Icon(Icons.description_outlined)),
      title: CnItemTitle(child: Text('Briefing.pdf')),
      description: CnItemDescription(child: Text('Updated 2h ago')),
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'With actions',
        description: 'Add trailing buttons or badges.',
        preview: (context) => const _ItemActionPreview(),
        code: '''CnItem(
  media: CnItemMedia(child: Icon(Icons.people_outline)),
  title: CnItemTitle(child: Text('Design team')),
  description: CnItemDescription(child: Text('8 members')),
  actions: CnButton(variant: .outline, onPressed: () {}, child: Text('View')),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Kbd',
    description: 'Keyboard hints for shortcuts.',
    examples: [
      ComponentExample(
        title: 'Shortcut',
        description: 'Compose keyboard sequences.',
        preview: (context) => const _KbdPreview(),
        code: '''CnKbdGroup(
  children: [
    CnKbd(child: Text('Cmd')),
    Text('+'),
    CnKbd(child: Text('K')),
  ],
)''',
      ),
      ComponentExample(
        title: 'Inline',
        description: 'Use inline keyboard hints in text.',
        preview: (context) => const _KbdInlinePreview(),
        code: '''Row(
  mainAxisSize: .min,
  spacing: 6,
  children: [
    Text('Press'),
    CnKbd(child: Text('Shift')),
    Text('to preview'),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Progress',
    description: 'Linear indicator for ongoing tasks.',
    examples: [
      ComponentExample(
        title: 'Determinate',
        description: 'Show progress with a known value.',
        preview: (context) =>
            const SizedBox(width: 320, child: CnProgress(value: 0.62)),
        code: '''CnProgress(value: 0.62)''',
      ),
      ComponentExample(
        title: 'Indeterminate',
        description: 'Show progress when duration is unknown.',
        preview: (context) => const SizedBox(width: 320, child: CnProgress()),
        code: '''CnProgress()''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Skeleton',
    description: 'Loading placeholders with shimmer variants.',
    examples: [
      ComponentExample(
        title: 'Card',
        description: 'Skeletons for cards and hero content.',
        preview: (context) => const _SkeletonPreview(),
        code: '''CnSkeletonAvatar(size: 48)

CnSkeletonLine(width: 220)

CnSkeleton(height: 140)''',
      ),
      ComponentExample(
        title: 'List',
        description: 'Stacked rows for list loading states.',
        preview: (context) => const _SkeletonListPreview(),
        code: '''Column(
  children: [
    CnSkeletonLine(width: 240),
    CnSkeletonLine(width: 200),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Table',
    description: 'Structured layout for tabular content.',
    examples: [
      ComponentExample(
        title: 'Default',
        description: 'Basic table layout with header.',
        preview: (context) => const _TablePreview(),
        code: '''CnTable(
  columns: [
    CnTableColumn(label: Text('Invoice')),
    CnTableColumn(label: Text('Status')),
    CnTableColumn(label: Text('Email')),
    CnTableColumn(
      label: Text('Amount'),
      alignment: Alignment.centerRight,
    ),
  ],
  rows: [
    CnTableRow(
      cells: [
        Text('INV-1001'),
        Text('Paid'),
        Text('olivia@example.com'),
        Text('\$2,500.00'),
      ],
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Striped',
        description: 'Striped rows with column dividers.',
        preview: (context) => const _TableStripedPreview(),
        code: '''CnTable(
  striped: true,
  showColumnDividers: true,
  columns: [...],
  rows: [...],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Data Table',
    description: 'Sortable, searchable data grid with selection and columns.',
    examples: [
      ComponentExample(
        title: 'Feature rich',
        description: 'Search, selection, actions, and column visibility.',
        preview: (context) => const _DataTablePreview(),
        code: '''CnDataTable<Invoice>(
  rows: invoices,
  rowId: (row) => row.id,
  searchable: true,
  rowsPerPage: 4,
  enableSelection: true,
  enableColumnVisibility: true,
  columns: [
    CnDataTableColumn<Invoice>(
      id: 'invoice',
      label: Text('Invoice'),
      toggleLabel: 'Invoice',
      sortable: true,
      sortValue: (row) => row.invoice,
      cellBuilder: (_, row) => Text(row.invoice),
    ),
  ],
)''',
      ),
      ComponentExample(
        title: 'Compact',
        description: 'Simplified table for dashboards.',
        preview: (context) => const _DataTableCompactPreview(),
        code: '''CnDataTable<Invoice>(
  rows: invoices,
  rowsPerPage: 3,
  columns: [
    CnDataTableColumn<Invoice>(
      id: 'invoice',
      label: Text('Invoice'),
      cellBuilder: (_, row) => Text(row.invoice),
    ),
  ],
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Slider',
    description: 'Continuous range control.',
    examples: [
      ComponentExample(
        title: 'Discrete',
        description: 'Slider with labeled steps.',
        preview: (context) => const _SliderPreview(),
        code: '''CnSlider(
  value: volume,
  divisions: 5,
  onChanged: (value) => setState(() => volume = value),
)''',
      ),
      ComponentExample(
        title: 'Continuous',
        description: 'Smooth slider without step divisions.',
        preview: (context) => const _SliderContinuousPreview(),
        code: '''CnSlider(
  value: value,
  min: 0,
  max: 100,
  onChanged: (value) => setState(() => sliderValue = value),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Separator',
    description: 'Visual divider between regions.',
    examples: [
      ComponentExample(
        title: 'Horizontal',
        description: 'Divide content vertically.',
        preview: (context) => const SizedBox(width: 320, child: CnSeparator()),
        code: '''CnSeparator()''',
      ),
      ComponentExample(
        title: 'Vertical',
        description: 'Divide inline content.',
        preview: (context) => const Row(
          mainAxisSize: .min,
          spacing: 12,
          children: [
            Text('First'),
            CnSeparator(direction: .vertical, length: 24),
            Text('Second'),
          ],
        ),
        code: '''CnSeparator(direction: .vertical, length: 24)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Typography',
    description: 'Text styles for hierarchy and content flow.',
    examples: [
      ComponentExample(
        title: 'Type scale',
        description: 'Headings and body text styles.',
        preview: (context) => const _TypographyPreview(),
        code: '''CnText(
  variant: .h1,
  text: 'Typography',
)

CnText(
  variant: .lead,
  text: 'Build readable, expressive interfaces.',
)''',
      ),
      ComponentExample(
        title: 'Rich content',
        description: 'Inline code, lists, and blockquotes.',
        preview: (context) => const _TypographyRichPreview(),
        code: '''CnText(
  variant: .p,
  child: Wrap(
    spacing: 6,
    children: [
      Text('Install with'),
      CnInlineCode(code: 'flutter pub add cn_ui'),
    ],
  ),
)

CnBlockquote(child: Text('Good typography is invisible.'))''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Spinner',
    description: 'Circular progress indicator for loading states.',
    examples: [
      ComponentExample(
        title: 'Sizes',
        description: 'Use different sizes for emphasis.',
        preview: (context) => const Row(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            CnSpinner(size: 16),
            CnSpinner(size: 24),
            CnSpinner(size: 32),
          ],
        ),
        code: '''Row(
  spacing: 16,
  children: [
    CnSpinner(size: 16),
    CnSpinner(size: 24),
    CnSpinner(size: 32),
  ],
)''',
      ),
      ComponentExample(
        title: 'Button loading',
        description: 'Combine spinners with labels.',
        preview: (context) => CnButton(
          variant: .outline,
          onPressed: () {},
          child: const Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [CnSpinner(size: 16, strokeWidth: 2), Text('Loading')],
          ),
        ),
        code: '''CnButton(
  variant: .outline,
  onPressed: () {},
  child: Row(
    mainAxisSize: .min,
    spacing: 8,
    children: [
      CnSpinner(size: 16, strokeWidth: 2),
      Text('Loading'),
    ],
  ),
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Sonner',
    description: 'Stacked toast notifications with variants.',
    examples: [
      ComponentExample(
        title: 'Success',
        description: 'Call out completed actions.',
        preview: (context) => const _SonnerSuccessPreview(),
        code: '''CnSonner.success(
  context,
  title: 'Invite sent',
  description: 'An email went out to design@studio.com',
)''',
      ),
      ComponentExample(
        title: 'Loading',
        description: 'Show background work with progress.',
        preview: (context) => const _SonnerLoadingPreview(),
        code: '''CnSonner.loading(
  context,
  title: 'Syncing workspace',
  description: 'This can take a minute.',
)''',
      ),
    ],
  ),
  ComponentEntry(
    name: 'Toast',
    description: 'Transient feedback message.',
    examples: [
      ComponentExample(
        title: 'With action',
        description: 'Give users a quick undo option.',
        preview: (context) => const _ToastPreview(),
        code: '''CnToast.show(
  context,
  message: 'Invitation sent to design@studio.com',
  actionLabel: 'Undo',
  onAction: () {},
)''',
      ),
      ComponentExample(
        title: 'Simple',
        description: 'Quick confirmation messages.',
        preview: (context) => const _ToastSimplePreview(),
        code: '''CnToast.show(
  context,
  message: 'Saved successfully',
)''',
      ),
    ],
  ),
];

class _CheckboxPreview extends StatefulWidget {
  const _CheckboxPreview();

  @override
  State<_CheckboxPreview> createState() => _CheckboxPreviewState();
}

class _CheckboxPreviewState extends State<_CheckboxPreview> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return CnCheckbox(
      value: checked,
      onChanged: (value) => setState(() => checked = value ?? false),
      label: const Text('Accept terms and conditions'),
    );
  }
}

class _InputOtpPreview extends StatefulWidget {
  const _InputOtpPreview();

  @override
  State<_InputOtpPreview> createState() => _InputOtpPreviewState();
}

class _InputOtpPreviewState extends State<_InputOtpPreview> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        CnInputOtp(
          length: 6,
          groupSize: 3,
          onChanged: (value) => setState(() => otp = value),
        ),
        Text('Value: $otp', style: CnTheme.textThemeOf(context).bodySmall),
      ],
    );
  }
}

class _LabelPreview extends StatelessWidget {
  const _LabelPreview();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 16,
      children: const [
        CnLabel(required: true, child: Text('Email')),
        CnLabel(child: Text('Optional note')),
      ],
    );
  }
}

class _FormPreview extends StatefulWidget {
  const _FormPreview();

  @override
  State<_FormPreview> createState() => _FormPreviewState();
}

class _FormPreviewState extends State<_FormPreview> {
  final formKey = GlobalKey<FormState>();
  bool marketing = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnForm(
        formKey: formKey,
        child: Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                CnFormField(
                  labelText: 'Name',
                  required: true,
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Ada Lovelace'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Name is required'
                        : null,
                  ),
                ),
                CnFormField(
                  labelText: 'Email',
                  descriptionText: 'We will only use this for updates.',
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'name@company.com',
                    ),
                    validator: (value) => (value ?? '').contains('@')
                        ? null
                        : 'Enter a valid email',
                  ),
                ),
                CnFormField(
                  labelText: 'Marketing',
                  child: CnSwitch(
                    value: marketing,
                    onChanged: (value) => setState(() => marketing = value),
                    label: const Text('Receive weekly highlights'),
                  ),
                ),
              ],
            ),
            CnButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Saved')));
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComboboxPreview extends StatefulWidget {
  const _ComboboxPreview();

  @override
  State<_ComboboxPreview> createState() => _ComboboxPreviewState();
}

class _ComboboxPreviewState extends State<_ComboboxPreview> {
  String? role;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CnCombobox<String>(
        placeholder: 'Select a role',
        value: role,
        onChanged: (value) => setState(() => role = value),
        items: const [
          CnComboboxItem(value: 'design', label: 'Design'),
          CnComboboxItem(value: 'product', label: 'Product'),
          CnComboboxItem(value: 'engineering', label: 'Engineering'),
          CnComboboxItem(value: 'marketing', label: 'Marketing'),
        ],
      ),
    );
  }
}

class _DatePickerPreview extends StatefulWidget {
  const _DatePickerPreview();

  @override
  State<_DatePickerPreview> createState() => _DatePickerPreviewState();
}

class _DatePickerPreviewState extends State<_DatePickerPreview> {
  DateTime? selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CnDatePickerField(
        placeholder: 'Pick a date',
        value: selected,
        onChanged: (value) => setState(() => selected = value),
      ),
    );
  }
}

class _SwitchPreview extends StatefulWidget {
  const _SwitchPreview();

  @override
  State<_SwitchPreview> createState() => _SwitchPreviewState();
}

class _SwitchPreviewState extends State<_SwitchPreview> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return CnSwitch(
      value: enabled,
      onChanged: (value) => setState(() => enabled = value),
      label: const Text('Email notifications'),
    );
  }
}

class _TogglePreview extends StatefulWidget {
  const _TogglePreview();

  @override
  State<_TogglePreview> createState() => _TogglePreviewState();
}

class _TogglePreviewState extends State<_TogglePreview> {
  bool starred = false;
  bool muted = true;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        CnToggle(
          value: starred,
          onChanged: (value) => setState(() => starred = value),
          child: Icon(starred ? Icons.star : Icons.star_border),
        ),
        CnToggle(
          value: muted,
          onChanged: (value) => setState(() => muted = value),
          variant: .ghost,
          child: Icon(muted ? Icons.volume_off : Icons.volume_up),
        ),
      ],
    );
  }
}

class _ToggleGroupPreview extends StatefulWidget {
  const _ToggleGroupPreview();

  @override
  State<_ToggleGroupPreview> createState() => _ToggleGroupPreviewState();
}

class _ToggleGroupPreviewState extends State<_ToggleGroupPreview> {
  Set<Object?> selected = {'bold'};
  Set<Object?> alignment = {'left'};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              Text('Single', style: CnTheme.textThemeOf(context).labelMedium),
              CnToggleGroup(
                joined: true,
                allowMultiple: false,
                selectedValues: alignment,
                onChanged: (value) => setState(() => alignment = value),
                items: const [
                  CnToggleGroupItem(
                    value: 'left',
                    child: Icon(Icons.format_align_left),
                  ),
                  CnToggleGroupItem(
                    value: 'center',
                    child: Icon(Icons.format_align_center),
                  ),
                  CnToggleGroupItem(
                    value: 'right',
                    child: Icon(Icons.format_align_right),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              Text('Multiple', style: CnTheme.textThemeOf(context).labelMedium),
              CnToggleGroup(
                allowMultiple: true,
                selectedValues: selected,
                onChanged: (value) => setState(() => selected = value),
                items: const [
                  CnToggleGroupItem(
                    value: 'bold',
                    child: Icon(Icons.format_bold),
                  ),
                  CnToggleGroupItem(
                    value: 'italic',
                    child: Icon(Icons.format_italic),
                  ),
                  CnToggleGroupItem(value: 'code', child: Icon(Icons.code)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadioPreview extends StatefulWidget {
  const _RadioPreview();

  @override
  State<_RadioPreview> createState() => _RadioPreviewState();
}

class _RadioPreviewState extends State<_RadioPreview> {
  String plan = 'starter';

  @override
  Widget build(BuildContext context) {
    return CnRadioGroup<String>(
      groupValue: plan,
      onChanged: (value) => setState(() => plan = value ?? plan),
      child: Column(
        crossAxisAlignment: .start,
        children: const [
          CnRadio<String>(value: 'starter', label: Text('Starter')),
          CnRadio<String>(value: 'growth', label: Text('Growth')),
        ],
      ),
    );
  }
}

class _SelectPreview extends StatefulWidget {
  const _SelectPreview();

  @override
  State<_SelectPreview> createState() => _SelectPreviewState();
}

class _SelectPreviewState extends State<_SelectPreview> {
  String? team;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: CnSelect<String>(
        value: team,
        placeholder: 'Pick a team',
        items: const [
          DropdownMenuItem(value: 'design', child: Text('Design')),
          DropdownMenuItem(value: 'product', child: Text('Product')),
          DropdownMenuItem(value: 'engineering', child: Text('Engineering')),
        ],
        onChanged: (value) => setState(() => team = value),
      ),
    );
  }
}

class _TabsPreview extends StatelessWidget {
  const _TabsPreview();

  @override
  Widget build(BuildContext context) {
    return CnTabs(
      contentHeight: 120,
      tabs: [
        CnTab(
          label: 'Overview',
          child: Padding(
            padding: const .only(top: 8),
            child: Text(
              'Track KPIs, generate reports, and spot trends.',
              style: CnTheme.textThemeOf(context).bodyMedium,
            ),
          ),
        ),
        CnTab(
          label: 'Details',
          child: Padding(
            padding: const .only(top: 8),
            child: Text(
              'Dive into weekly breakdowns and export data.',
              style: CnTheme.textThemeOf(context).bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class _BreadcrumbPreview extends StatelessWidget {
  const _BreadcrumbPreview();

  @override
  Widget build(BuildContext context) {
    return CnBreadcrumb(
      items: [
        CnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
        CnBreadcrumbItem(label: const Text('Library'), onTap: () {}),
        const CnBreadcrumbItem(label: Text('Data')),
      ],
    );
  }
}

class _BreadcrumbCollapsedPreview extends StatelessWidget {
  const _BreadcrumbCollapsedPreview();

  @override
  Widget build(BuildContext context) {
    return CnBreadcrumb(
      collapse: true,
      items: [
        for (var i = 1; i <= 7; i++)
          CnBreadcrumbItem(label: Text('Item $i'), onTap: () {}),
      ],
    );
  }
}

class _MenubarPreview extends StatelessWidget {
  const _MenubarPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnMenubar(
        menus: [
          CnMenu(
            label: 'File',
            entries: [
              CnMenuAction(label: 'New tab', onSelected: () {}),
              CnMenuAction(label: 'New window', onSelected: () {}),
              const CnMenuSeparator(),
              CnMenuSubmenu(
                label: 'Export',
                entries: [
                  CnMenuAction(label: 'PDF', onSelected: () {}),
                  CnMenuAction(label: 'CSV', onSelected: () {}),
                ],
              ),
            ],
          ),
          CnMenu(
            label: 'Edit',
            entries: [
              CnMenuAction(label: 'Undo', onSelected: () {}),
              CnMenuAction(label: 'Redo', onSelected: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavigationMenuPreview extends StatelessWidget {
  const _NavigationMenuPreview();

  @override
  Widget build(BuildContext context) {
    return CnNavigationMenu(
      items: [
        CnNavigationMenuItem(label: 'Overview', onTap: () {}),
        CnNavigationMenuItem(
          label: 'Solutions',
          links: [
            CnNavigationMenuLink(
              title: 'Analytics',
              description: 'Real-time insights for your team.',
              onTap: () {},
            ),
            CnNavigationMenuLink(
              title: 'Automation',
              description: 'Trigger workflows and reduce toil.',
              onTap: () {},
            ),
          ],
        ),
        CnNavigationMenuItem(label: 'Pricing', onTap: () {}),
      ],
    );
  }
}

class _PaginationPreview extends StatefulWidget {
  const _PaginationPreview();

  @override
  State<_PaginationPreview> createState() => _PaginationPreviewState();
}

class _PaginationPreviewState extends State<_PaginationPreview> {
  int page = 3;

  @override
  Widget build(BuildContext context) {
    return CnPagination(
      currentPage: page,
      totalPages: 12,
      onPageChanged: (value) => setState(() => page = value),
    );
  }
}

class _SliderPreview extends StatefulWidget {
  const _SliderPreview();

  @override
  State<_SliderPreview> createState() => _SliderPreviewState();
}

class _SliderPreviewState extends State<_SliderPreview> {
  double value = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: CnSlider(
        value: value,
        divisions: 5,
        onChanged: (next) => setState(() => value = next),
      ),
    );
  }
}

final List<_InvoiceRow> _invoiceRows = [
  _InvoiceRow(
    id: '1',
    invoice: 'INV-1001',
    status: 'Paid',
    email: 'olivia@example.com',
    amount: 2500.00,
    date: DateTime(2024, 1, 15),
  ),
  _InvoiceRow(
    id: '2',
    invoice: 'INV-1002',
    status: 'Pending',
    email: 'liam@example.com',
    amount: 980.25,
    date: DateTime(2024, 1, 18),
  ),
  _InvoiceRow(
    id: '3',
    invoice: 'INV-1003',
    status: 'Paid',
    email: 'emma@example.com',
    amount: 1235.50,
    date: DateTime(2024, 1, 22),
  ),
  _InvoiceRow(
    id: '4',
    invoice: 'INV-1004',
    status: 'Overdue',
    email: 'noah@example.com',
    amount: 420.00,
    date: DateTime(2024, 1, 27),
  ),
  _InvoiceRow(
    id: '5',
    invoice: 'INV-1005',
    status: 'Paid',
    email: 'ava@example.com',
    amount: 3100.00,
    date: DateTime(2024, 2, 1),
  ),
  _InvoiceRow(
    id: '6',
    invoice: 'INV-1006',
    status: 'Pending',
    email: 'mason@example.com',
    amount: 640.75,
    date: DateTime(2024, 2, 3),
  ),
  _InvoiceRow(
    id: '7',
    invoice: 'INV-1007',
    status: 'Paid',
    email: 'sophia@example.com',
    amount: 1875.00,
    date: DateTime(2024, 2, 7),
  ),
];

class _InvoiceRow {
  final String id;
  final String invoice;
  final String status;
  final String email;
  final double amount;
  final DateTime date;

  _InvoiceRow({
    required this.id,
    required this.invoice,
    required this.status,
    required this.email,
    required this.amount,
    required this.date,
  });
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final month = _twoDigits(date.month);
  final day = _twoDigits(date.day);
  return '${date.year}-$month-$day';
}

String _twoDigits(int value) => value.toString().padLeft(2, '0');

class _TablePreview extends StatelessWidget {
  const _TablePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: CnTable(
        columns: const [
          CnTableColumn(label: Text('Invoice')),
          CnTableColumn(label: Text('Status')),
          CnTableColumn(label: Text('Email')),
          CnTableColumn(
            label: Text('Amount'),
            alignment: Alignment.centerRight,
          ),
        ],
        rows: _invoiceRows.take(4).map((row) {
          return CnTableRow(
            cells: [
              Text(row.invoice),
              Text(row.status),
              Text(row.email),
              Text(_formatCurrency(row.amount)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _DataTablePreview extends StatefulWidget {
  const _DataTablePreview();

  @override
  State<_DataTablePreview> createState() => _DataTablePreviewState();
}

class _DataTablePreviewState extends State<_DataTablePreview> {
  final TextEditingController _searchController = TextEditingController();
  Set<String> selected = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 720,
      child: CnDataTable<_InvoiceRow>(
        rows: _invoiceRows,
        rowId: (row) => row.id,
        title: const Text('Recent invoices'),
        actions: CnButton(
          variant: .outline,
          size: .sm,
          onPressed: () {},
          child: const Text('Export'),
        ),
        searchable: true,
        searchController: _searchController,
        searchPlaceholder: 'Filter invoices...',
        searchValue: (row) => '${row.invoice} ${row.status} ${row.email}',
        enableSelection: true,
        enableColumnVisibility: true,
        selectedRowIds: selected,
        onSelectionChanged: (value) => setState(() => selected = value),
        rowsPerPage: 4,
        minTableWidth: 720,
        striped: true,
        columns: [
          CnDataTableColumn<_InvoiceRow>(
            id: 'invoice',
            label: const Text('Invoice'),
            toggleLabel: 'Invoice',
            sortable: true,
            sortValue: (row) => row.invoice,
            cellBuilder: (_, row) => Text(row.invoice),
          ),
          CnDataTableColumn<_InvoiceRow>(
            id: 'status',
            label: const Text('Status'),
            toggleLabel: 'Status',
            sortable: true,
            sortValue: (row) => row.status,
            cellBuilder: (_, row) => Text(row.status),
          ),
          CnDataTableColumn<_InvoiceRow>(
            id: 'email',
            label: const Text('Email'),
            toggleLabel: 'Email',
            sortable: true,
            sortValue: (row) => row.email,
            cellBuilder: (_, row) => Text(row.email),
          ),
          CnDataTableColumn<_InvoiceRow>(
            id: 'amount',
            label: const Text('Amount'),
            toggleLabel: 'Amount',
            numeric: true,
            sortable: true,
            sortValue: (row) => row.amount,
            cellBuilder: (_, row) => Text(_formatCurrency(row.amount)),
          ),
          CnDataTableColumn<_InvoiceRow>(
            id: 'date',
            label: const Text('Date'),
            toggleLabel: 'Date',
            sortable: true,
            sortValue: (row) => row.date,
            cellBuilder: (_, row) => Text(_formatDate(row.date)),
          ),
        ],
        rowActionsBuilder: (_, row) => CnButton(
          variant: .ghost,
          size: .icon,
          onPressed: () {},
          child: const Icon(Icons.more_horiz, size: 18),
        ),
      ),
    );
  }
}

class _SkeletonPreview extends StatelessWidget {
  const _SkeletonPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          Row(
            spacing: 12,
            children: [
              const CnSkeletonAvatar(size: 52),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: const [
                    CnSkeletonLine(width: 180),
                    CnSkeletonLine(width: 120),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: CnSkeleton(height: 140),
          ),
          Row(
            spacing: 12,
            children: const [
              CnSkeletonLine(width: 100, height: 10),
              CnSkeletonLine(width: 80, height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class _CarouselPreview extends StatelessWidget {
  const _CarouselPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return SizedBox(
      width: 640,
      child: CnCarousel(
        height: 220,
        showIndicators: true,
        showArrows: true,
        loop: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        items: [
          _CarouselSlide(
            icon: Icons.layers_outlined,
            title: 'Design systems',
            description: 'Ship a consistent UI faster.',
            background: scheme.primaryContainer,
            foreground: scheme.onPrimaryContainer,
          ),
          _CarouselSlide(
            icon: Icons.auto_awesome_outlined,
            title: 'Feature highlights',
            description: 'Spotlight the updates that matter.',
            background: scheme.secondaryContainer,
            foreground: scheme.onSecondaryContainer,
          ),
          _CarouselSlide(
            icon: Icons.insights_outlined,
            title: 'Analytics snapshots',
            description: 'Share real-time performance insights.',
            background: scheme.tertiaryContainer,
            foreground: scheme.onTertiaryContainer,
          ),
        ],
      ),
    );
  }
}

class _CarouselSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color background;
  final Color foreground;

  const _CarouselSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = CnTheme.textThemeOf(context);

    return Container(
      decoration: BoxDecoration(color: background),
      padding: const .all(24),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              padding: const .all(8),
              decoration: BoxDecoration(
                color: foreground.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: foreground),
            ),
          ),
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              color: foreground,
              fontWeight: .w600,
            ),
          ),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: foreground.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypographyPreview extends StatelessWidget {
  const _TypographyPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          const CnText(variant: .h1, text: 'Typography'),
          const CnText(
            variant: .lead,
            text: 'Build readable, expressive interfaces with consistent type.',
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: CnText(
              variant: .p,
              text:
                  'Use typography tokens to create rhythm, hierarchy, and '
                  'emphasis across your layouts.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: CnText(
              variant: .p,
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Text('Install with'),
                  CnInlineCode(code: 'flutter pub add cn_ui'),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: CnBlockquote(
              child: Text(
                'Good typography is invisible \u2014 it keeps the focus on the '
                'content.',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: CnText(variant: .large, text: 'Principles'),
          ),
          const CnList(
            items: [
              Text('Short, focused sentences.'),
              Text('Consistent rhythm and spacing.'),
              Text('Scale with your theme.'),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: CnText(
              variant: .muted,
              text: 'Muted text works well for captions or helper copy.',
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertDialogPreview extends StatelessWidget {
  const _AlertDialogPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showCnDialog(
          context: context,
          builder: (dialog) => CnAlertDialog(
            title: const Text('Are you absolutely sure?'),
            content: const Text(
              'This action cannot be undone. This will permanently delete '
              'your account and remove your data from our servers.',
            ),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: dialog.cancel,
                child: const Text('Cancel'),
              ),
              CnButton(onPressed: dialog.result, child: const Text('Continue')),
            ],
          ),
        );
      },
      child: const Text('Show dialog'),
    );
  }
}

class _ToastPreview extends StatelessWidget {
  const _ToastPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        CnToast.show(
          context,
          message: 'Invitation sent to design@studio.com',
          actionLabel: 'Undo',
          onAction: () {},
        );
      },
      child: const Text('Show toast'),
    );
  }
}

class _AccordionPreview extends StatelessWidget {
  const _AccordionPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnAccordion(
        allowMultiple: true,
        initialOpenIndices: const {0},
        items: const [
          CnAccordionItem(
            title: Text('Product'),
            content: Text('Manage pricing, inventory, and channels.'),
          ),
          CnAccordionItem(
            title: Text('Marketing'),
            content: Text('Plan campaigns and social launches.'),
          ),
          CnAccordionItem(
            title: Text('Support'),
            content: Text('Handle tickets, SLAs, and knowledge base.'),
          ),
        ],
      ),
    );
  }
}

class _CollapsiblePreview extends StatelessWidget {
  const _CollapsiblePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnCollapsible(
        title: const Text('Team notes'),
        subtitle: const Text('Shipping weekly on Wednesdays.'),
        child: Text(
          'Shipping weekly on Wednesdays. Stay aligned on priorities and '
          'capture decisions in the doc hub.',
          style: CnTheme.textThemeOf(context).bodyMedium,
        ),
      ),
    );
  }
}

class _AspectRatioPreview extends StatelessWidget {
  const _AspectRatioPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: 360,
      child: CnAspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [scheme.primaryContainer, scheme.secondaryContainer],
            ),
          ),
          child: Center(
            child: Text(
              '16:9',
              style: CnTheme.textThemeOf(
                context,
              ).titleMedium?.copyWith(color: scheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollAreaPreview extends StatelessWidget {
  const _ScrollAreaPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: 320,
      child: CnScrollArea(
        height: 180,
        thumbVisibility: true,
        child: Column(
          children: [
            for (var index = 0; index < 12; index++)
              Container(
                padding: const .symmetric(horizontal: 12, vertical: 10),
                margin: const .only(bottom: 8),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: .circular(CnTheme.of(context).radius - 6),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: scheme.primaryContainer,
                      child: Text(
                        '${index + 1}',
                        style: CnTheme.textThemeOf(context).labelSmall,
                      ),
                    ),
                    Text('Update #${index + 1}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResizablePreview extends StatelessWidget {
  const _ResizablePreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: 520,
      height: 200,
      child: CnResizable(
        initialRatio: 0.55,
        primary: _ResizablePanel(
          title: 'Details',
          color: scheme.surfaceContainer,
        ),
        secondary: _ResizablePanel(
          title: 'Notes',
          color: scheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}

class _ResizablePanel extends StatelessWidget {
  final String title;
  final Color color;

  const _ResizablePanel({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(16),
      color: color,
      child: Text(title, style: CnTheme.textThemeOf(context).titleSmall),
    );
  }
}

class _AlertPreview extends StatelessWidget {
  const _AlertPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: const [
        CnAlert(
          variant: .info,
          title: Text('Heads up'),
          description: Text('You can now edit this project.'),
        ),
        CnAlert(
          variant: .destructive,
          title: Text('Something went wrong'),
          description: Text('We could not save your changes.'),
        ),
      ],
    );
  }
}

class _CommandPreview extends StatelessWidget {
  const _CommandPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnCommand(
        groups: [
          CnCommandGroup(
            label: 'Suggestions',
            items: [
              CnCommandItem(
                label: 'New project',
                description: 'Create a new workspace',
                onSelected: () {},
                leading: const Icon(Icons.add_circle_outline),
                trailing: const Text('Ctrl+N'),
              ),
              CnCommandItem(
                label: 'Search docs',
                description: 'Find docs and guides',
                onSelected: () {},
                leading: const Icon(Icons.search),
              ),
            ],
          ),
          CnCommandGroup(
            label: 'Settings',
            items: [
              CnCommandItem(
                label: 'Account',
                description: 'Manage billing and plan',
                onSelected: () {},
                leading: const Icon(Icons.settings_outlined),
              ),
              CnCommandItem(
                label: 'Notifications',
                description: 'Email and in-app alerts',
                onSelected: () {},
                leading: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContextMenuPreview extends StatelessWidget {
  const _ContextMenuPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: 320,
      child: CnContextMenu(
        entries: [
          CnDropdownMenuAction(label: 'Rename', onSelected: () {}),
          CnDropdownMenuAction(label: 'Duplicate', onSelected: () {}),
          const CnDropdownMenuSeparator(),
          CnDropdownMenuAction(
            label: 'Delete',
            role: .destructive,
            onSelected: () {},
          ),
        ],
        child: Container(
          padding: const .all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: .circular(CnTheme.of(context).radius),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: const Text('Right click or long press for actions'),
        ),
      ),
    );
  }
}

class _DrawerPreview extends StatelessWidget {
  const _DrawerPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showCnDrawer(
          context: context,
          side: .left,
          builder: (_) => CnDrawer(
            side: .left,
            title: const Text('Share access'),
            description: const Text('Invite teammates to collaborate.'),
            content: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: const [
                CnInput(placeholder: 'email@company.com'),
                CnSwitch(
                  value: true,
                  onChanged: null,
                  label: Text('Notify by email'),
                ),
              ],
            ),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Cancel'),
              ),
              CnButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Send invite'),
              ),
            ],
          ),
        );
      },
      child: const Text('Open drawer'),
    );
  }
}

class _HoverCardPreview extends StatelessWidget {
  const _HoverCardPreview();

  @override
  Widget build(BuildContext context) {
    return CnHoverCard(
      content: Column(
        crossAxisAlignment: .start,
        spacing: 4,
        children: [
          Text('Nova Patel', style: CnTheme.textThemeOf(context).titleSmall),
          Text(
            'Product design lead',
            style: CnTheme.textThemeOf(context).bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              spacing: 8,
              children: [
                CnBadge(variant: .outline, child: Text('Active')),
                Text('San Francisco'),
              ],
            ),
          ),
        ],
      ),
      child: const CnAvatar(initials: 'NP'),
    );
  }
}

class _SheetPreview extends StatelessWidget {
  const _SheetPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showCnSheet(
          context: context,
          builder: (_) => CnSheet(
            title: const Text('Project settings'),
            description: const Text(
              'Manage access, billing, and integrations.',
            ),
            content: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: const [
                CnInput(placeholder: 'Workspace name'),
                CnSelect<String>(
                  items: [
                    DropdownMenuItem(value: 'starter', child: Text('Starter')),
                    DropdownMenuItem(value: 'pro', child: Text('Pro')),
                  ],
                  placeholder: 'Plan',
                ),
              ],
            ),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Close'),
              ),
              CnButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
      child: const Text('Open sheet'),
    );
  }
}

class _DialogPreview extends StatelessWidget {
  const _DialogPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => CnDialog(
            title: const Text('Invite team'),
            description: const Text('Share access with collaborators.'),
            content: const CnInput(placeholder: 'email@company.com'),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Cancel'),
              ),
              CnButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Send invite'),
              ),
            ],
          ),
        );
      },
      child: const Text('Open dialog'),
    );
  }
}

class _DropdownMenuPreview extends StatefulWidget {
  const _DropdownMenuPreview();

  @override
  State<_DropdownMenuPreview> createState() => _DropdownMenuPreviewState();
}

class _DropdownMenuPreviewState extends State<_DropdownMenuPreview> {
  bool pinned = true;
  String mode = 'compact';

  @override
  Widget build(BuildContext context) {
    return CnDropdownMenu(
      triggerBuilder: (context, controller) => CnButton(
        variant: .outline,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: const Text('Open menu'),
      ),
      entries: [
        CnDropdownMenuAction(label: 'New tab', onSelected: () {}),
        CnDropdownMenuAction(label: 'Duplicate', onSelected: () {}),
        const CnDropdownMenuSeparator(),
        CnDropdownMenuCheckboxItem(
          label: 'Pin to top',
          checked: pinned,
          onChanged: (value) => setState(() => pinned = value),
        ),
        const CnDropdownMenuSeparator(),
        CnDropdownMenuRadioItem(
          label: 'Compact',
          value: 'compact',
          groupValue: mode,
          onSelected: (value) => setState(() => mode = value as String),
        ),
        CnDropdownMenuRadioItem(
          label: 'Comfortable',
          value: 'comfortable',
          groupValue: mode,
          onSelected: (value) => setState(() => mode = value as String),
        ),
      ],
    );
  }
}

class _PopoverPreview extends StatelessWidget {
  const _PopoverPreview();

  @override
  Widget build(BuildContext context) {
    return CnPopover(
      triggerBuilder: (context, controller) => CnButton(
        variant: .outline,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: const Text('Open popover'),
      ),
      content: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text('Quick actions', style: CnTheme.textThemeOf(context).titleSmall),
          Text(
            'Add a teammate or create a new project.',
            style: CnTheme.textThemeOf(context).bodyMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              spacing: 8,
              children: [
                CnButton(
                  size: .sm,
                  onPressed: () {},
                  child: const Text('Invite'),
                ),
                CnButton(
                  variant: .outline,
                  size: .sm,
                  onPressed: () {},
                  child: const Text('New'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccordionSinglePreview extends StatelessWidget {
  const _AccordionSinglePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnAccordion(
        allowMultiple: false,
        initialOpenIndices: const {1},
        items: const [
          CnAccordionItem(
            title: Text('Overview'),
            content: Text('Plan milestones, owners, and timelines.'),
          ),
          CnAccordionItem(
            title: Text('Risks'),
            content: Text('Identify blockers and mitigation plans.'),
          ),
          CnAccordionItem(
            title: Text('Next steps'),
            content: Text('Assign tasks to each workstream.'),
          ),
        ],
      ),
    );
  }
}

class _CollapsibleIconPreview extends StatelessWidget {
  const _CollapsibleIconPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnCollapsible(
        title: const Text('Weekly report'),
        subtitle: const Text('Last updated 2 hours ago'),
        leading: const Icon(Icons.description_outlined),
        trailing: const CnBadge(variant: .outline, child: Text('Draft')),
        child: Text(
          'Share updates with the team and keep everyone aligned.',
          style: CnTheme.textThemeOf(context).bodyMedium,
        ),
      ),
    );
  }
}

class _ScrollAreaHorizontalPreview extends StatelessWidget {
  const _ScrollAreaHorizontalPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    final radius = CnTheme.of(context).radius;
    return SizedBox(
      width: 420,
      child: CnScrollArea(
        direction: .horizontal,
        height: 160,
        thumbVisibility: true,
        child: Row(
          spacing: 12,
          children: [
            for (var index = 0; index < 6; index++)
              Container(
                width: 140,
                padding: const .all(12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: .circular(radius - 6),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Text(
                      'Card ${index + 1}',
                      style: CnTheme.textThemeOf(context).titleSmall,
                    ),
                    Text(
                      'Summary',
                      style: CnTheme.textThemeOf(context).bodySmall,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResizableVerticalPreview extends StatelessWidget {
  const _ResizableVerticalPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: 420,
      height: 240,
      child: CnResizable(
        direction: .vertical,
        initialRatio: 0.6,
        primary: _ResizablePanel(
          title: 'Summary',
          color: scheme.surfaceContainer,
        ),
        secondary: _ResizablePanel(
          title: 'Timeline',
          color: scheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}

class _LabelWithFieldPreview extends StatelessWidget {
  const _LabelWithFieldPreview();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          CnLabel(required: true, child: Text('Email')),
          CnInput(placeholder: 'name@company.com'),
        ],
      ),
    );
  }
}

class _FormInlinePreview extends StatelessWidget {
  const _FormInlinePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnForm(
        child: Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            const CnFormField(
              labelText: 'Workspace',
              descriptionText: 'Shown on invoices and receipts.',
              child: CnInput(placeholder: 'Acme Studio'),
            ),
            CnFormField(
              labelText: 'Plan',
              required: true,
              errorText: 'Required',
              child: CnSelect<String>(
                placeholder: 'Select plan',
                items: const [
                  DropdownMenuItem(value: 'starter', child: Text('Starter')),
                  DropdownMenuItem(value: 'pro', child: Text('Pro')),
                ],
                onChanged: (_) {},
              ),
            ),
            Row(
              mainAxisAlignment: .end,
              spacing: 8,
              children: [
                CnButton(
                  variant: .outline,
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                CnButton(onPressed: () {}, child: const Text('Create')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ComboboxIconPreview extends StatefulWidget {
  const _ComboboxIconPreview();

  @override
  State<_ComboboxIconPreview> createState() => _ComboboxIconPreviewState();
}

class _ComboboxIconPreviewState extends State<_ComboboxIconPreview> {
  String? channel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CnCombobox<String>(
        placeholder: 'Choose a channel',
        value: channel,
        onChanged: (value) => setState(() => channel = value),
        items: const [
          CnComboboxItem(
            value: 'slack',
            label: 'Slack',
            leading: Icon(Icons.chat_bubble_outline),
          ),
          CnComboboxItem(
            value: 'email',
            label: 'Email',
            leading: Icon(Icons.mail_outline),
          ),
          CnComboboxItem(
            value: 'notion',
            label: 'Notion',
            leading: Icon(Icons.note_alt_outlined),
          ),
        ],
      ),
    );
  }
}

class _DatePickerPresetPreview extends StatefulWidget {
  const _DatePickerPresetPreview();

  @override
  State<_DatePickerPresetPreview> createState() =>
      _DatePickerPresetPreviewState();
}

class _DatePickerPresetPreviewState extends State<_DatePickerPresetPreview> {
  DateTime? selected = DateTime(2024, 2, 10);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CnDatePickerField(
        placeholder: 'Delivery date',
        value: selected,
        allowClear: false,
        onChanged: (value) => setState(() => selected = value),
        initialDate: selected,
      ),
    );
  }
}

class _ToggleSizePreview extends StatefulWidget {
  const _ToggleSizePreview();

  @override
  State<_ToggleSizePreview> createState() => _ToggleSizePreviewState();
}

class _ToggleSizePreviewState extends State<_ToggleSizePreview> {
  bool small = false;
  bool medium = true;
  bool large = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        CnToggle(
          size: .sm,
          value: small,
          onChanged: (value) => setState(() => small = value),
          child: const Text('Sm'),
        ),
        CnToggle(
          value: medium,
          onChanged: (value) => setState(() => medium = value),
          child: const Text('Md'),
        ),
        CnToggle(
          size: .lg,
          value: large,
          onChanged: (value) => setState(() => large = value),
          child: const Text('Lg'),
        ),
      ],
    );
  }
}

class _ToggleGroupSeparatedPreview extends StatefulWidget {
  const _ToggleGroupSeparatedPreview();

  @override
  State<_ToggleGroupSeparatedPreview> createState() =>
      _ToggleGroupSeparatedPreviewState();
}

class _ToggleGroupSeparatedPreviewState
    extends State<_ToggleGroupSeparatedPreview> {
  Set<Object?> selected = {'bold', 'italic'};

  @override
  Widget build(BuildContext context) {
    return CnToggleGroup(
      allowMultiple: true,
      selectedValues: selected,
      onChanged: (value) => setState(() => selected = value),
      variant: .ghost,
      size: .sm,
      items: const [
        CnToggleGroupItem(value: 'bold', child: Icon(Icons.format_bold)),
        CnToggleGroupItem(value: 'italic', child: Icon(Icons.format_italic)),
        CnToggleGroupItem(value: 'code', child: Icon(Icons.code)),
        CnToggleGroupItem(value: 'strike', child: Icon(Icons.strikethrough_s)),
      ],
    );
  }
}

class _RadioInlinePreview extends StatefulWidget {
  const _RadioInlinePreview();

  @override
  State<_RadioInlinePreview> createState() => _RadioInlinePreviewState();
}

class _RadioInlinePreviewState extends State<_RadioInlinePreview> {
  String billing = 'monthly';

  @override
  Widget build(BuildContext context) {
    return CnRadioGroup<String>(
      groupValue: billing,
      onChanged: (value) => setState(() => billing = value ?? billing),
      child: Row(
        spacing: 16,
        children: const [
          CnRadio<String>(value: 'monthly', label: Text('Monthly')),
          CnRadio<String>(value: 'yearly', label: Text('Yearly')),
        ],
      ),
    );
  }
}

class _SelectCompactPreview extends StatefulWidget {
  const _SelectCompactPreview();

  @override
  State<_SelectCompactPreview> createState() => _SelectCompactPreviewState();
}

class _SelectCompactPreviewState extends State<_SelectCompactPreview> {
  String? plan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: CnSelect<String>(
        value: plan,
        placeholder: 'Plan',
        isExpanded: false,
        items: const [
          DropdownMenuItem(value: 'starter', child: Text('Starter')),
          DropdownMenuItem(value: 'pro', child: Text('Pro')),
        ],
        onChanged: (value) => setState(() => plan = value),
      ),
    );
  }
}

class _TabsScrollablePreview extends StatelessWidget {
  const _TabsScrollablePreview();

  @override
  Widget build(BuildContext context) {
    return CnTabs(
      isScrollable: true,
      contentHeight: 120,
      tabs: [
        CnTab(
          label: 'Overview',
          child: Padding(
            padding: const .only(top: 8),
            child: Text(
              'Track KPIs and team updates.',
              style: CnTheme.textThemeOf(context).bodyMedium,
            ),
          ),
        ),
        CnTab(
          label: 'Analytics',
          child: Padding(
            padding: const .only(top: 8),
            child: Text(
              'Monitor adoption and funnel metrics.',
              style: CnTheme.textThemeOf(context).bodyMedium,
            ),
          ),
        ),
        CnTab(
          label: 'Billing',
          child: Padding(
            padding: const .only(top: 8),
            child: Text(
              'Manage invoices and payment methods.',
              style: CnTheme.textThemeOf(context).bodyMedium,
            ),
          ),
        ),
        CnTab(
          label: 'Settings',
          child: Padding(
            padding: const .only(top: 8),
            child: Text(
              'Configure notifications and access.',
              style: CnTheme.textThemeOf(context).bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class _BreadcrumbIconPreview extends StatelessWidget {
  const _BreadcrumbIconPreview();

  @override
  Widget build(BuildContext context) {
    return CnBreadcrumb(
      items: [
        CnBreadcrumbItem(
          label: Row(
            mainAxisSize: .min,
            spacing: 6,
            children: const [Icon(Icons.home_outlined, size: 16), Text('Home')],
          ),
          onTap: () {},
        ),
        CnBreadcrumbItem(
          label: Row(
            mainAxisSize: .min,
            spacing: 6,
            children: const [
              Icon(Icons.receipt_long, size: 16),
              Text('Billing'),
            ],
          ),
          onTap: () {},
        ),
        const CnBreadcrumbItem(label: Text('Invoices')),
      ],
    );
  }
}

class _MenubarIconPreview extends StatelessWidget {
  const _MenubarIconPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnMenubar(
        menus: [
          CnMenu(
            label: 'Project',
            entries: [
              CnMenuAction(
                label: 'New',
                leading: const Icon(Icons.add),
                onSelected: () {},
              ),
              CnMenuAction(
                label: 'Duplicate',
                leading: const Icon(Icons.copy),
                onSelected: () {},
              ),
              const CnMenuSeparator(),
              CnMenuAction(
                label: 'Delete',
                role: .destructive,
                leading: const Icon(Icons.delete_outline),
                onSelected: () {},
              ),
            ],
          ),
          CnMenu(
            label: 'View',
            entries: [
              CnMenuAction(
                label: 'Zoom in',
                leading: const Icon(Icons.zoom_in),
                onSelected: () {},
              ),
              CnMenuAction(
                label: 'Zoom out',
                leading: const Icon(Icons.zoom_out),
                onSelected: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavigationMenuIconPreview extends StatelessWidget {
  const _NavigationMenuIconPreview();

  @override
  Widget build(BuildContext context) {
    return CnNavigationMenu(
      items: [
        CnNavigationMenuItem(
          label: 'Resources',
          leading: const Icon(Icons.book_outlined),
          links: [
            CnNavigationMenuLink(
              title: 'Docs',
              description: 'API reference and guides.',
              leading: const Icon(Icons.description_outlined),
              onTap: () {},
            ),
            CnNavigationMenuLink(
              title: 'Tutorials',
              description: 'Step-by-step walkthroughs.',
              leading: const Icon(Icons.school_outlined),
              onTap: () {},
            ),
          ],
        ),
        CnNavigationMenuItem(
          label: 'Community',
          leading: const Icon(Icons.forum_outlined),
          onTap: () {},
        ),
      ],
    );
  }
}

class _PaginationCompactPreview extends StatefulWidget {
  const _PaginationCompactPreview();

  @override
  State<_PaginationCompactPreview> createState() =>
      _PaginationCompactPreviewState();
}

class _PaginationCompactPreviewState extends State<_PaginationCompactPreview> {
  int page = 5;

  @override
  Widget build(BuildContext context) {
    return CnPagination(
      currentPage: page,
      totalPages: 18,
      showPrevNext: false,
      maxButtons: 7,
      onPageChanged: (value) => setState(() => page = value),
    );
  }
}

class _CommandEmptyPreview extends StatefulWidget {
  const _CommandEmptyPreview();

  @override
  State<_CommandEmptyPreview> createState() => _CommandEmptyPreviewState();
}

class _CommandEmptyPreviewState extends State<_CommandEmptyPreview> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'zzz');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnCommand(
        controller: _controller,
        emptyText: 'No results found.',
        groups: [
          CnCommandGroup(
            label: 'Suggestions',
            items: [
              CnCommandItem(
                label: 'New project',
                description: 'Create a new workspace',
                onSelected: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContextMenuSelectionPreview extends StatefulWidget {
  const _ContextMenuSelectionPreview();

  @override
  State<_ContextMenuSelectionPreview> createState() =>
      _ContextMenuSelectionPreviewState();
}

class _ContextMenuSelectionPreviewState
    extends State<_ContextMenuSelectionPreview> {
  bool pinned = true;
  String mode = 'compact';

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);
    return SizedBox(
      width: 320,
      child: CnContextMenu(
        entries: [
          CnDropdownMenuCheckboxItem(
            label: 'Pin to top',
            checked: pinned,
            onChanged: (value) => setState(() => pinned = value),
          ),
          const CnDropdownMenuSeparator(),
          CnDropdownMenuRadioItem(
            label: 'Compact',
            value: 'compact',
            groupValue: mode,
            onSelected: (value) => setState(() => mode = value as String),
          ),
          CnDropdownMenuRadioItem(
            label: 'Comfortable',
            value: 'comfortable',
            groupValue: mode,
            onSelected: (value) => setState(() => mode = value as String),
          ),
        ],
        child: Container(
          padding: const .all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: .circular(CnTheme.of(context).radius),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: const Text('Right click for view options'),
        ),
      ),
    );
  }
}

class _DrawerRightPreview extends StatelessWidget {
  const _DrawerRightPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showCnDrawer(
          context: context,
          side: .right,
          builder: (_) => CnDrawer(
            side: .right,
            title: const Text('Filters'),
            description: const Text('Refine results across this view.'),
            content: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: const [
                CnCheckbox(value: true, onChanged: null, label: Text('Active')),
                CnCheckbox(
                  value: false,
                  onChanged: null,
                  label: Text('Archived'),
                ),
                CnSwitch(
                  value: true,
                  onChanged: null,
                  label: Text('Only assigned to me'),
                ),
              ],
            ),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Reset'),
              ),
              CnButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Apply'),
              ),
            ],
          ),
        );
      },
      child: const Text('Open drawer'),
    );
  }
}

class _HoverCardCompactPreview extends StatelessWidget {
  const _HoverCardCompactPreview();

  @override
  Widget build(BuildContext context) {
    return CnHoverCard(
      width: 220,
      content: Column(
        crossAxisAlignment: .start,
        spacing: 6,
        children: [
          Text('Latest update', style: CnTheme.textThemeOf(context).titleSmall),
          Text(
            'Uploaded 2 hours ago.',
            style: CnTheme.textThemeOf(context).bodySmall,
          ),
        ],
      ),
      child: const CnBadge(child: Text('Updates')),
    );
  }
}

class _SheetCompactPreview extends StatelessWidget {
  const _SheetCompactPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showCnSheet(
          context: context,
          builder: (_) => CnSheet(
            title: const Text('Quick add'),
            description: const Text('Create a new task in seconds.'),
            heightFactor: 0.4,
            showHandle: false,
            showCloseButton: false,
            content: const CnInput(placeholder: 'Task name'),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Cancel'),
              ),
              CnButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
      child: const Text('Open sheet'),
    );
  }
}

class _DialogConfirmPreview extends StatelessWidget {
  const _DialogConfirmPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => CnDialog(
            title: const Text('Delete project?'),
            description: const Text(
              'This action cannot be undone. All data will be removed.',
            ),
            showCloseButton: false,
            actions: [
              CnButton(
                variant: .outline,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Cancel'),
              ),
              CnButton(
                variant: .destructive,
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      child: const Text('Open dialog'),
    );
  }
}

class _DropdownMenuSubmenuPreview extends StatelessWidget {
  const _DropdownMenuSubmenuPreview();

  @override
  Widget build(BuildContext context) {
    return CnDropdownMenu(
      triggerBuilder: (context, controller) => CnButton(
        variant: .outline,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: const Text('Open menu'),
      ),
      entries: [
        CnDropdownMenuAction(label: 'New tab', onSelected: () {}),
        const CnDropdownMenuSeparator(),
        CnDropdownMenuSubmenu(
          label: 'Export',
          entries: [
            CnDropdownMenuAction(label: 'PDF', onSelected: () {}),
            CnDropdownMenuAction(label: 'CSV', onSelected: () {}),
            CnDropdownMenuAction(label: 'PNG', onSelected: () {}),
          ],
        ),
        const CnDropdownMenuSeparator(),
        CnDropdownMenuAction(
          label: 'Delete',
          role: .destructive,
          onSelected: () {},
        ),
      ],
    );
  }
}

class _PopoverFormPreview extends StatelessWidget {
  const _PopoverFormPreview();

  @override
  Widget build(BuildContext context) {
    return CnPopover(
      triggerBuilder: (context, controller) => CnButton(
        variant: .outline,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: const Text('Edit status'),
      ),
      content: SizedBox(
        width: 240,
        child: Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            Text('Status', style: CnTheme.textThemeOf(context).titleSmall),
            const CnInput(placeholder: 'In review'),
            Row(
              spacing: 8,
              children: [
                CnButton(
                  size: .sm,
                  onPressed: () {},
                  child: const Text('Save'),
                ),
                CnButton(
                  size: .sm,
                  variant: .outline,
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertDialogDestructivePreview extends StatelessWidget {
  const _AlertDialogDestructivePreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        showCnDialog(
          context: context,
          builder: (dialog) => CnAlertDialog(
            title: const Text('Delete project?'),
            content: const Text(
              'This action cannot be undone. All data will be removed.',
            ),
            actions: [
              CnButton(
                variant: .outline,
                onPressed: dialog.cancel,
                child: const Text('Cancel'),
              ),
              CnButton(
                variant: .destructive,
                onPressed: dialog.result,
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      child: const Text('Delete'),
    );
  }
}

class _CalendarSinglePreview extends StatefulWidget {
  const _CalendarSinglePreview();

  @override
  State<_CalendarSinglePreview> createState() => _CalendarSinglePreviewState();
}

class _CalendarSinglePreviewState extends State<_CalendarSinglePreview> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CnCalendar(
        selectionMode: .single,
        selectedDate: selectedDate,
        onDateSelected: (value) => setState(() => selectedDate = value),
      ),
    );
  }
}

class _CalendarRangePreview extends StatefulWidget {
  const _CalendarRangePreview();

  @override
  State<_CalendarRangePreview> createState() => _CalendarRangePreviewState();
}

class _CalendarRangePreviewState extends State<_CalendarRangePreview> {
  DateTimeRange? selectedRange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnCalendar(
        selectionMode: .range,
        selectedRange: selectedRange,
        onRangeSelected: (value) => setState(() => selectedRange = value),
      ),
    );
  }
}

class _CalendarPresetsPreview extends StatefulWidget {
  const _CalendarPresetsPreview();

  @override
  State<_CalendarPresetsPreview> createState() =>
      _CalendarPresetsPreviewState();
}

class _CalendarPresetsPreviewState extends State<_CalendarPresetsPreview> {
  late DateTime _focusedMonth;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _focusedMonth = DateTime(selectedDate!.year, selectedDate!.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          CnCalendar(
            selectionMode: .single,
            selectedDate: selectedDate,
            focusedMonth: _focusedMonth,
            onMonthChanged: (value) => setState(() => _focusedMonth = value),
            onDateSelected: (value) => setState(() => selectedDate = value),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PresetButton(
                label: 'Today',
                onPressed: () => _selectPreset(Duration.zero),
              ),
              _PresetButton(
                label: 'Tomorrow',
                onPressed: () => _selectPreset(const Duration(days: 1)),
              ),
              _PresetButton(
                label: 'In 3 days',
                onPressed: () => _selectPreset(const Duration(days: 3)),
              ),
              _PresetButton(
                label: 'In a week',
                onPressed: () => _selectPreset(const Duration(days: 7)),
              ),
              _PresetButton(
                label: 'In 2 weeks',
                onPressed: () => _selectPreset(const Duration(days: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectPreset(Duration offset) {
    final date = DateTime.now().add(offset);
    setState(() {
      selectedDate = date;
      _focusedMonth = DateTime(date.year, date.month, 1);
    });
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PresetButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      size: .sm,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _CalendarWithTimePreview extends StatefulWidget {
  const _CalendarWithTimePreview();

  @override
  State<_CalendarWithTimePreview> createState() =>
      _CalendarWithTimePreviewState();
}

class _CalendarWithTimePreviewState extends State<_CalendarWithTimePreview> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 12, minute: 30);

  @override
  Widget build(BuildContext context) {
    final timeOptions = _timeOptions();

    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          CnCalendar(
            selectionMode: .single,
            selectedDate: selectedDate,
            onDateSelected: (value) => setState(() => selectedDate = value),
          ),
          const CnSeparator(),
          CnFieldGroup(
            spacing: 12,
            children: [
              CnField(
                labelText: 'Start Time',
                child: CnSelect<TimeOfDay>(
                  value: startTime,
                  items: [
                    for (final time in timeOptions)
                      DropdownMenuItem(
                        value: time,
                        child: Text(_formatTime(context, time)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() => startTime = value);
                  },
                ),
              ),
              CnField(
                labelText: 'End Time',
                child: CnSelect<TimeOfDay>(
                  value: endTime,
                  items: [
                    for (final time in timeOptions)
                      DropdownMenuItem(
                        value: time,
                        child: Text(_formatTime(context, time)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() => endTime = value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }

  List<TimeOfDay> _timeOptions() {
    return const [
      TimeOfDay(hour: 8, minute: 0),
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 10, minute: 30),
      TimeOfDay(hour: 12, minute: 30),
      TimeOfDay(hour: 14, minute: 0),
      TimeOfDay(hour: 16, minute: 0),
    ];
  }
}

class _CalendarRangeMultiMonthPreview extends StatefulWidget {
  const _CalendarRangeMultiMonthPreview();

  @override
  State<_CalendarRangeMultiMonthPreview> createState() =>
      _CalendarRangeMultiMonthPreviewState();
}

class _CalendarRangeMultiMonthPreviewState
    extends State<_CalendarRangeMultiMonthPreview> {
  DateTimeRange? selectedRange = DateTimeRange(
    start: DateTime(2025, 1, 12),
    end: DateTime(2025, 2, 11),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: CnCalendar(
        selectionMode: .range,
        focusedMonth: DateTime(2025, 1, 1),
        monthsToDisplay: 2,
        daySize: 36,
        selectedRange: selectedRange,
        onRangeSelected: (value) => setState(() => selectedRange = value),
      ),
    );
  }
}

class _CalendarBookedPreview extends StatefulWidget {
  const _CalendarBookedPreview();

  @override
  State<_CalendarBookedPreview> createState() => _CalendarBookedPreviewState();
}

class _CalendarBookedPreviewState extends State<_CalendarBookedPreview> {
  DateTime? selectedDate = DateTime(2025, 2, 3);
  final DateTime focusedMonth = DateTime(2025, 2, 1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CnCalendar(
        selectionMode: .single,
        focusedMonth: focusedMonth,
        selectedDate: selectedDate,
        onDateSelected: (value) => setState(() => selectedDate = value),
        isDateSelectable: (date) => !_isUnavailable(date),
        dayBuilder: (context, date, state) {
          final unavailable = _isUnavailable(date);
          final style = state.textStyle?.copyWith(
            decoration: unavailable ? TextDecoration.lineThrough : null,
            color: unavailable
                ? CnTheme.colorSchemeOf(
                    context,
                  ).onSurfaceVariant.withValues(alpha: 0.5)
                : state.textStyle?.color,
          );
          return Text('${date.day}', style: style);
        },
      ),
    );
  }

  bool _isUnavailable(DateTime date) {
    return date.year == focusedMonth.year &&
        date.month == focusedMonth.month &&
        date.day >= 12 &&
        date.day <= 21;
  }
}

class _CalendarMultiplePreview extends StatefulWidget {
  const _CalendarMultiplePreview();

  @override
  State<_CalendarMultiplePreview> createState() =>
      _CalendarMultiplePreviewState();
}

class _CalendarMultiplePreviewState extends State<_CalendarMultiplePreview> {
  Set<DateTime> selectedDates = {
    DateTime(2025, 12, 9),
    DateTime(2025, 12, 12),
    DateTime(2025, 12, 17),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CnCalendar(
        selectionMode: .multiple,
        focusedMonth: DateTime(2025, 12, 1),
        selectedDates: selectedDates,
        onDatesSelected: (value) => setState(() => selectedDates = value),
      ),
    );
  }
}

class _CalendarDropdownPreview extends StatefulWidget {
  const _CalendarDropdownPreview();

  @override
  State<_CalendarDropdownPreview> createState() =>
      _CalendarDropdownPreviewState();
}

class _CalendarDropdownPreviewState extends State<_CalendarDropdownPreview> {
  DateTime? selectedDate = DateTime(2025, 12, 12);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnCalendar(
        selectionMode: .single,
        focusedMonth: DateTime(2025, 12, 1),
        selectedDate: selectedDate,
        headerVariant: CnCalendarHeaderVariant.dropdowns,
        firstYear: 2020,
        lastYear: 2030,
        onDateSelected: (value) => setState(() => selectedDate = value),
      ),
    );
  }
}

class _SkeletonListPreview extends StatelessWidget {
  const _SkeletonListPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          for (var index = 0; index < 3; index++)
            Row(
              spacing: 12,
              children: [
                const CnSkeletonAvatar(size: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 6,
                    children: const [
                      CnSkeletonLine(width: 200),
                      CnSkeletonLine(width: 140),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _TableStripedPreview extends StatelessWidget {
  const _TableStripedPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: CnTable(
        striped: true,
        showColumnDividers: true,
        columns: const [
          CnTableColumn(label: Text('Invoice')),
          CnTableColumn(label: Text('Status')),
          CnTableColumn(label: Text('Email')),
          CnTableColumn(
            label: Text('Amount'),
            alignment: Alignment.centerRight,
          ),
        ],
        rows: List.generate(4, (index) {
          final row = _invoiceRows[index];
          return CnTableRow(
            selected: index == 1,
            cells: [
              Text(row.invoice),
              Text(row.status),
              Text(row.email),
              Text(_formatCurrency(row.amount)),
            ],
          );
        }),
      ),
    );
  }
}

class _DataTableCompactPreview extends StatelessWidget {
  const _DataTableCompactPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: CnDataTable<_InvoiceRow>(
        rows: _invoiceRows.take(4).toList(),
        rowsPerPage: 3,
        searchable: false,
        enableSelection: false,
        enableColumnVisibility: false,
        columns: [
          CnDataTableColumn<_InvoiceRow>(
            id: 'invoice',
            label: const Text('Invoice'),
            cellBuilder: (_, row) => Text(row.invoice),
          ),
          CnDataTableColumn<_InvoiceRow>(
            id: 'status',
            label: const Text('Status'),
            cellBuilder: (_, row) => Text(row.status),
          ),
          CnDataTableColumn<_InvoiceRow>(
            id: 'amount',
            label: const Text('Amount'),
            numeric: true,
            cellBuilder: (_, row) => Text(_formatCurrency(row.amount)),
          ),
        ],
      ),
    );
  }
}

class _SliderContinuousPreview extends StatefulWidget {
  const _SliderContinuousPreview();

  @override
  State<_SliderContinuousPreview> createState() =>
      _SliderContinuousPreviewState();
}

class _SliderContinuousPreviewState extends State<_SliderContinuousPreview> {
  double value = 32;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: CnSlider(
        value: value,
        min: 0,
        max: 100,
        onChanged: (next) => setState(() => value = next),
      ),
    );
  }
}

class _TypographyRichPreview extends StatelessWidget {
  const _TypographyRichPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          CnText(
            variant: .p,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                Text('Install with'),
                CnInlineCode(code: 'flutter pub add cn_ui'),
              ],
            ),
          ),
          const CnBlockquote(child: Text('Good typography is invisible.')),
          const CnList(
            items: [
              Text('Short, focused sentences.'),
              Text('Consistent rhythm and spacing.'),
              Text('Use muted text for captions.'),
            ],
          ),
          const CnText(
            variant: .muted,
            text: 'Muted text works well for captions or helper copy.',
          ),
        ],
      ),
    );
  }
}

class _ButtonGroupJoinedPreview extends StatelessWidget {
  const _ButtonGroupJoinedPreview();

  @override
  Widget build(BuildContext context) {
    final radius = CnTheme.of(context).radius - 4;
    final padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    return CnButtonGroup(
      children: [
        CnButton(
          variant: .ghost,
          padding: padding,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(radius)),
          onPressed: () {},
          child: Row(
            mainAxisSize: .min,
            spacing: 6,
            children: const [Icon(Icons.chevron_left, size: 18), Text('Back')],
          ),
        ),
        const CnButtonGroupSeparator(),
        CnButton(
          variant: .ghost,
          padding: padding,
          borderRadius: BorderRadius.zero,
          onPressed: () {},
          child: const Text('Details'),
        ),
        const CnButtonGroupSeparator(),
        CnButton(
          variant: .ghost,
          padding: padding,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(radius)),
          onPressed: () {},
          child: Row(
            mainAxisSize: .min,
            spacing: 6,
            children: const [Text('Next'), Icon(Icons.chevron_right, size: 18)],
          ),
        ),
      ],
    );
  }
}

class _ButtonGroupStackedPreview extends StatelessWidget {
  const _ButtonGroupStackedPreview();

  @override
  Widget build(BuildContext context) {
    return CnButtonGroup(
      orientation: .vertical,
      children: [
        CnButton(
          variant: .ghost,
          onPressed: () {},
          child: const Text('Personal'),
        ),
        const CnButtonGroupSeparator(),
        const CnButtonGroupText(child: Text('or')),
        const CnButtonGroupSeparator(),
        CnButton(variant: .ghost, onPressed: () {}, child: const Text('Team')),
      ],
    );
  }
}

class _InputGroupPreview extends StatelessWidget {
  const _InputGroupPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnInputGroup(
        children: [
          const CnInputGroupText(text: 'https://'),
          const CnInputGroupInput(placeholder: 'studio.io'),
          CnInputGroupButton(
            child: CnButton(
              variant: .ghost,
              borderRadius: BorderRadius.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onPressed: () {},
              child: const Text('Go'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputGroupAddonPreview extends StatelessWidget {
  const _InputGroupAddonPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnInputGroup(
        children: const [
          CnInputGroupAddon(child: Icon(Icons.search)),
          CnInputGroupInput(placeholder: 'Search'),
          CnInputGroupText(text: 'USD'),
        ],
      ),
    );
  }
}

class _FieldSetPreview extends StatelessWidget {
  const _FieldSetPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: CnFieldSet(
        child: Column(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            const CnFieldLegend(child: Text('Contact details')),
            CnFieldGroup(
              children: const [
                CnField(
                  labelText: 'Name',
                  child: CnInput(placeholder: 'Ada Lovelace'),
                ),
                CnField(
                  labelText: 'Email',
                  child: CnInput(placeholder: 'ada@studio.com'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldHorizontalPreview extends StatelessWidget {
  const _FieldHorizontalPreview();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 420,
      child: CnField(
        layout: .horizontal,
        labelText: 'Workspace',
        descriptionText: 'Shown on your public profile.',
        child: CnInput(placeholder: 'Studio HQ'),
      ),
    );
  }
}

class _NativeSelectPreview extends StatefulWidget {
  const _NativeSelectPreview();

  @override
  State<_NativeSelectPreview> createState() => _NativeSelectPreviewState();
}

class _NativeSelectPreviewState extends State<_NativeSelectPreview> {
  String? team;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CnNativeSelect<String?>(
        value: team,
        placeholder: 'Select team',
        entries: const [
          CnNativeSelectOption(value: 'design', label: 'Design'),
          CnNativeSelectOption(value: 'product', label: 'Product'),
          CnNativeSelectOption(value: 'engineering', label: 'Engineering'),
        ],
        onChanged: (value) => setState(() => team = value),
      ),
    );
  }
}

class _NativeSelectGroupPreview extends StatefulWidget {
  const _NativeSelectGroupPreview();

  @override
  State<_NativeSelectGroupPreview> createState() =>
      _NativeSelectGroupPreviewState();
}

class _NativeSelectGroupPreviewState extends State<_NativeSelectGroupPreview> {
  String? plan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: CnNativeSelect<String?>(
        placeholder: 'Choose a plan',
        entries: const [
          CnNativeSelectOptGroup(
            label: 'Personal',
            options: [
              CnNativeSelectOption(value: 'starter', label: 'Starter'),
              CnNativeSelectOption(value: 'plus', label: 'Plus'),
            ],
          ),
          CnNativeSelectOptGroup(
            label: 'Business',
            options: [
              CnNativeSelectOption(value: 'pro', label: 'Pro'),
              CnNativeSelectOption(value: 'enterprise', label: 'Enterprise'),
            ],
          ),
        ],
        value: plan,
        onChanged: (value) => setState(() => plan = value),
      ),
    );
  }
}

class _SidebarPreview extends StatefulWidget {
  const _SidebarPreview();

  @override
  State<_SidebarPreview> createState() => _SidebarPreviewState();
}

class _SidebarPreviewState extends State<_SidebarPreview> {
  late final CnSidebarController controller = CnSidebarController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return SizedBox(
      height: 320,
      child: CnSidebarProvider(
        controller: controller,
        child: Row(
          spacing: 16,
          children: [
            CnSidebar(
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: 12,
                children: [
                  CnSidebarHeader(
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: const [Text('Workspace'), CnSidebarTrigger()],
                    ),
                  ),
                  CnSidebarContent(
                    children: [
                      CnSidebarGroup(
                        title: 'Projects',
                        children: [
                          const CnSidebarItem(
                            icon: Icon(Icons.dashboard_outlined),
                            label: Text('Overview'),
                            selected: true,
                          ),
                          const CnSidebarItem(
                            icon: Icon(Icons.people_outline),
                            label: Text('Team'),
                          ),
                          CnSidebarItem(
                            icon: const Icon(Icons.calendar_today_outlined),
                            label: const Text('Schedule'),
                            trailing: CnBadge(
                              variant: .secondary,
                              child: const Text('4'),
                            ),
                          ),
                        ],
                      ),
                      CnSidebarGroup(
                        title: 'Settings',
                        children: const [
                          CnSidebarItem(
                            icon: Icon(Icons.settings_outlined),
                            label: Text('Preferences'),
                          ),
                          CnSidebarItem(
                            icon: Icon(Icons.logout),
                            label: Text('Sign out'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const CnSidebarFooter(child: Text('v2.3.1')),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(
                    CnTheme.of(context).radius,
                  ),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Text(
                      'Content area',
                      style: CnTheme.textThemeOf(context).titleSmall,
                    ),
                    Text(
                      'Select a project in the sidebar to load its details.',
                      style: CnTheme.textThemeOf(
                        context,
                      ).bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarCollapsedPreview extends StatefulWidget {
  const _SidebarCollapsedPreview();

  @override
  State<_SidebarCollapsedPreview> createState() =>
      _SidebarCollapsedPreviewState();
}

class _SidebarCollapsedPreviewState extends State<_SidebarCollapsedPreview> {
  late final CnSidebarController controller = CnSidebarController(
    collapsed: true,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: CnSidebarProvider(
        controller: controller,
        child: CnSidebar(
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 12,
            children: [
              const CnSidebarHeader(child: CnSidebarTrigger()),
              CnSidebarContent(
                children: const [
                  CnSidebarItem(
                    icon: Icon(Icons.inbox_outlined),
                    label: Text('Inbox'),
                    selected: true,
                  ),
                  CnSidebarItem(
                    icon: Icon(Icons.star_border),
                    label: Text('Starred'),
                  ),
                  CnSidebarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarDetailPreview extends StatefulWidget {
  const _SidebarDetailPreview();

  @override
  State<_SidebarDetailPreview> createState() => _SidebarDetailPreviewState();
}

class _SidebarDetailPreviewState extends State<_SidebarDetailPreview> {
  late final CnSidebarController controller = CnSidebarController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: CnSidebarProvider(
        controller: controller,
        child: CnSidebar(
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 12,
            children: [
              CnSidebarHeader(
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: const [Text('Library'), CnSidebarTrigger()],
                ),
              ),
              CnSidebarSearch(
                controller: searchController,
                placeholder: 'Search',
              ),
              const CnSidebarSeparator(),
              CnSidebarContent(
                children: [
                  CnSidebarGroup(
                    title: 'Collections',
                    children: [
                      const CnSidebarItem(
                        icon: Icon(Icons.folder_open_outlined),
                        label: Text('Design'),
                        selected: true,
                      ),
                      const CnSidebarSubItem(label: Text('Briefs')),
                      const CnSidebarSubItem(label: Text('Assets')),
                      const CnSidebarSubItem(label: Text('Research')),
                    ],
                  ),
                  const CnSidebarSeparator(),
                  CnSidebarGroup(
                    title: 'Teams',
                    children: [
                      CnSidebarItem(
                        icon: const Icon(Icons.people_outline),
                        label: const Text('Core team'),
                        trailing: const CnBadge(
                          variant: .secondary,
                          child: Text('5'),
                        ),
                      ),
                      const CnSidebarItem(
                        icon: Icon(Icons.people_outline),
                        label: Text('Contractors'),
                      ),
                    ],
                  ),
                ],
              ),
              const CnSidebarFooter(
                child: Text('Signed in as studio@team.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartBarPreview extends StatelessWidget {
  const _ChartBarPreview();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 420,
      child: CnChart(
        showLegend: false,
        series: [
          CnChartSeries(
            name: 'Revenue',
            type: .bar,
            data: [
              CnChartPoint('Jan', 24),
              CnChartPoint('Feb', 32),
              CnChartPoint('Mar', 28),
              CnChartPoint('Apr', 40),
              CnChartPoint('May', 36),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartLinePreview extends StatelessWidget {
  const _ChartLinePreview();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 420,
      child: CnChart(
        series: [
          CnChartSeries(
            name: 'Visitors',
            type: .line,
            data: [
              CnChartPoint('Mon', 18),
              CnChartPoint('Tue', 26),
              CnChartPoint('Wed', 22),
              CnChartPoint('Thu', 30),
              CnChartPoint('Fri', 34),
            ],
          ),
          CnChartSeries(
            name: 'Signups',
            type: .line,
            data: [
              CnChartPoint('Mon', 6),
              CnChartPoint('Tue', 10),
              CnChartPoint('Wed', 8),
              CnChartPoint('Thu', 12),
              CnChartPoint('Fri', 14),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartAreaPreview extends StatelessWidget {
  const _ChartAreaPreview();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 420,
      child: CnChart(
        series: [
          CnChartSeries(
            name: 'Active users',
            type: .area,
            data: [
              CnChartPoint('Mon', 42),
              CnChartPoint('Tue', 58),
              CnChartPoint('Wed', 52),
              CnChartPoint('Thu', 64),
              CnChartPoint('Fri', 72),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartComboPreview extends StatelessWidget {
  const _ChartComboPreview();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 420,
      child: CnChart(
        series: [
          CnChartSeries(
            name: 'Orders',
            type: .bar,
            data: [
              CnChartPoint('Jan', 24),
              CnChartPoint('Feb', 28),
              CnChartPoint('Mar', 26),
              CnChartPoint('Apr', 32),
            ],
          ),
          CnChartSeries(
            name: 'Target',
            type: .line,
            showPoints: false,
            data: [
              CnChartPoint('Jan', 30),
              CnChartPoint('Feb', 30),
              CnChartPoint('Mar', 30),
              CnChartPoint('Apr', 30),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  const _EmptyPreview();

  @override
  Widget build(BuildContext context) {
    return CnEmpty(
      media: const CnEmptyMedia(child: Icon(Icons.search_off)),
      title: const CnEmptyTitle(child: Text('No results found')),
      description: const CnEmptyDescription(
        child: Text('Try adjusting your filters or search query.'),
      ),
      actions: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          CnButton(
            variant: .outline,
            onPressed: () {},
            child: const Text('Clear'),
          ),
          CnButton(onPressed: () {}, child: const Text('New search')),
        ],
      ),
    );
  }
}

class _EmptyMediaPreview extends StatelessWidget {
  const _EmptyMediaPreview();

  @override
  Widget build(BuildContext context) {
    final scheme = CnTheme.colorSchemeOf(context);

    return CnEmpty(
      media: CnEmptyMedia(
        variant: .image,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [scheme.primaryContainer, scheme.secondaryContainer],
            ),
          ),
        ),
      ),
      title: const CnEmptyTitle(child: Text('No projects yet')),
      description: const CnEmptyDescription(
        child: Text('Create your first workspace to get started.'),
      ),
    );
  }
}

class _ItemListPreview extends StatelessWidget {
  const _ItemListPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnItemGroup(
        children: const [
          CnItem(
            media: CnItemMedia(
              variant: .icon,
              child: Icon(Icons.description_outlined),
            ),
            title: CnItemTitle(child: Text('Briefing.pdf')),
            description: CnItemDescription(child: Text('Updated 2h ago')),
          ),
          CnItem(
            media: CnItemMedia(
              variant: .icon,
              child: Icon(Icons.folder_open_outlined),
            ),
            title: CnItemTitle(child: Text('Launch assets')),
            description: CnItemDescription(child: Text('12 files • Shared')),
          ),
          CnItem(
            media: CnItemMedia(variant: .icon, child: Icon(Icons.show_chart)),
            title: CnItemTitle(child: Text('Q3 metrics')),
            description: CnItemDescription(child: Text('Updated yesterday')),
          ),
        ],
      ),
    );
  }
}

class _ItemActionPreview extends StatelessWidget {
  const _ItemActionPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: CnItem(
        media: const CnItemMedia(child: Icon(Icons.people_outline)),
        title: const CnItemTitle(child: Text('Design team')),
        description: const CnItemDescription(child: Text('8 members')),
        actions: CnButton(
          variant: .outline,
          onPressed: () {},
          child: const Text('View'),
        ),
      ),
    );
  }
}

class _KbdPreview extends StatelessWidget {
  const _KbdPreview();

  @override
  Widget build(BuildContext context) {
    return const CnKbdGroup(
      children: [
        CnKbd(child: Text('Cmd')),
        Text('+'),
        CnKbd(child: Text('K')),
      ],
    );
  }
}

class _KbdInlinePreview extends StatelessWidget {
  const _KbdInlinePreview();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        Text('Press'),
        CnKbd(child: Text('Shift')),
        Text('to preview'),
      ],
    );
  }
}

class _SonnerSuccessPreview extends StatelessWidget {
  const _SonnerSuccessPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      onPressed: () {
        CnSonner.success(
          context,
          title: 'Invite sent',
          description: 'An email went out to design@studio.com',
        );
      },
      child: const Text('Show success'),
    );
  }
}

class _SonnerLoadingPreview extends StatelessWidget {
  const _SonnerLoadingPreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        CnSonner.loading(
          context,
          title: 'Syncing workspace',
          description: 'This can take a minute.',
        );
      },
      child: const Text('Show loading'),
    );
  }
}

class _ToastSimplePreview extends StatelessWidget {
  const _ToastSimplePreview();

  @override
  Widget build(BuildContext context) {
    return CnButton(
      variant: .outline,
      onPressed: () {
        CnToast.show(context, message: 'Saved successfully');
      },
      child: const Text('Show toast'),
    );
  }
}

class _AvatarGroupPreview extends StatelessWidget {
  const _AvatarGroupPreview();

  @override
  Widget build(BuildContext context) {
    return const CnAvatarGroup(
      children: [
        CnAvatar(initials: 'CN'),
        CnAvatar(initials: 'MD'),
        CnAvatar(initials: 'TL'),
      ],
    );
  }
}

class _AvatarGroupVerticalPreview extends StatelessWidget {
  const _AvatarGroupVerticalPreview();

  @override
  Widget build(BuildContext context) {
    return const CnAvatarGroup(
      direction: .vertical,
      children: [
        CnAvatar(initials: 'CN'),
        CnAvatar(initials: 'MD'),
        CnAvatar(initials: 'TL'),
      ],
    );
  }
}
