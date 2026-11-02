import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';
import 'cn_dropdown_menu.dart';
import 'cn_input.dart';
import 'cn_menu_entry.dart';
import 'cn_select.dart';

/// A column definition for [CnTable].
class CnTableColumn {
  const CnTableColumn({
    required this.label,
    this.alignment = AlignmentDirectional.centerStart,
    this.width,
  });
  final Widget label;
  final AlignmentGeometry alignment;
  final TableColumnWidth? width;
}

/// A row definition for [CnTable].
class CnTableRow {
  const CnTableRow({required this.cells, this.selected = false});
  final List<Widget> cells;
  final bool selected;
}

/// A simple table component for displaying tabular data.
///
/// Provides a basic table with customizable styling, headers, and cell content.
///
/// See also:
///
///  * [CnDataTable], for a feature-rich data table with sorting, filtering, and pagination.
class CnTable extends StatelessWidget {
  const CnTable({
    super.key,
    required this.columns,
    required this.rows,
    this.showHeader = true,
    this.striped = false,
    this.showRowDividers = true,
    this.showColumnDividers = false,
    this.mutedHeader = false,
    this.defaultColumnWidth,
  }) : assert(columns.length > 0, 'CnTable requires at least one column.');
  final List<CnTableColumn> columns;
  final List<CnTableRow> rows;
  final bool showHeader;
  final bool striped;
  final bool showRowDividers;
  final bool showColumnDividers;
  final bool mutedHeader;

  /// How wide columns without a width are. By default, they take the width of
  /// their content and share the remaining space in proportion to it.
  final TableColumnWidth? defaultColumnWidth;

  @override
  Widget build(BuildContext context) {
    assert(
      rows.every((row) => row.cells.length == columns.length),
      'Each row must provide a cell for every column.',
    );
    final colors = CnTheme.of(context).colors;
    final cnTheme = CnTheme.of(context);
    final headerTextStyle = cnTheme.text.sm.medium.copyWith(
      color: colors.foreground,
    );
    final cellTextStyle = cnTheme.text.sm.copyWith(color: colors.foreground);
    final borderColor = colors.border;
    final tableBorder = TableBorder(
      horizontalInside: showRowDividers
          ? BorderSide(color: borderColor)
          : .none,
      verticalInside: showColumnDividers
          ? BorderSide(color: borderColor)
          : .none,
    );

    final tableRows = <TableRow>[
      if (showHeader)
        TableRow(
          decoration: mutedHeader ? BoxDecoration(color: colors.muted) : null,
          children: [
            for (final column in columns)
              _buildCell(
                context,
                child: column.label,
                alignment: column.alignment,
                style: headerTextStyle,
              ),
          ],
        ),
      for (var i = 0; i < rows.length; i++)
        TableRow(
          decoration: _rowDecoration(rows[i], colors, striped, i),
          children: [
            for (var j = 0; j < rows[i].cells.length; j++)
              _buildCell(
                context,
                child: rows[i].cells[j],
                alignment: columns[j].alignment,
                style: cellTextStyle,
              ),
          ],
        ),
    ];

    return ClipRRect(
      borderRadius: .circular(cnTheme.radius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: .circular(cnTheme.radius),
          border: Border.all(color: borderColor),
        ),
        child: Table(
          defaultColumnWidth: defaultColumnWidth ?? const _ContentColumnWidth(),
          columnWidths: {
            for (var i = 0; i < columns.length; i++)
              if (columns[i].width != null) i: columns[i].width!,
          },
          border: tableBorder,
          defaultVerticalAlignment: .middle,
          children: tableRows,
        ),
      ),
    );
  }

  Widget _buildCell(
    BuildContext context, {
    required Widget child,
    required AlignmentGeometry alignment,
    required TextStyle style,
  }) {
    return Padding(
      padding: const .symmetric(horizontal: 8, vertical: 10),
      child: Align(
        alignment: alignment,
        child: DefaultTextStyle.merge(style: style, child: child),
      ),
    );
  }

  Decoration? _rowDecoration(
    CnTableRow row,
    CnColors colors,
    bool striped,
    int index,
  ) {
    if (row.selected) {
      return BoxDecoration(color: colors.muted);
    }
    if (striped && index.isOdd) {
      return BoxDecoration(color: colors.muted.withValues(alpha: 0.5));
    }
    return null;
  }
}

/// Shares the width of a table in proportion to the content of its columns,
/// like the automatic layout of an HTML table.
class _ContentColumnWidth extends TableColumnWidth {
  const _ContentColumnWidth();

  @override
  double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    return cells.fold(0, (width, cell) {
      return math.max(width, cell.getMinIntrinsicWidth(.infinity));
    });
  }

  @override
  double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    return cells.fold(0, (width, cell) {
      return math.max(width, cell.getMaxIntrinsicWidth(.infinity));
    });
  }

  @override
  double flex(Iterable<RenderBox> cells) {
    return maxIntrinsicWidth(cells, .infinity);
  }
}

/// A column definition for [CnDataTable].
class CnDataTableColumn<T> {
  const CnDataTableColumn({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.toggleLabel,
    this.sortable = false,
    this.sortComparator,
    this.sortValue,
    this.numeric = false,
    this.alignment,
    this.width,
  });
  final String id;
  final Widget label;
  final String? toggleLabel;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final bool sortable;
  final int Function(T a, T b)? sortComparator;
  final Comparable Function(T row)? sortValue;
  final bool numeric;
  final AlignmentGeometry? alignment;
  final TableColumnWidth? width;

  AlignmentGeometry get resolvedAlignment {
    return alignment ??
        (numeric
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart);
  }

  bool get canSort => sortable && (sortComparator != null || sortValue != null);
}

/// A feature-rich data table component with sorting, filtering, pagination, and selection.
///
/// Provides advanced table functionality including search, column visibility toggling, row selection, and customizable pagination.
///
/// See also:
///
///  * [CnTable], for a simpler table component.
///  * [CnPagination], for standalone pagination controls.
class CnDataTable<T> extends StatefulWidget {
  const CnDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.rowId,
    this.title,
    this.actions,
    this.searchable = false,
    this.searchController,
    this.searchPlaceholder = 'Search...',
    this.searchValue,
    this.selection,
    this.onSelectionChanged,
    this.rowsPerPage,
    this.rowsPerPageOptions,
    this.onRowsPerPageChanged,
    this.rowsPerPageLabel = 'Rows per page',
    this.showPageInfo = true,
    this.page = 1,
    this.onPageChanged,
    this.rowActionsBuilder,
    this.actionsColumnWidth,
    this.hiddenColumns,
    this.onHiddenColumnsChanged,
    this.columnVisibilityLabel = 'Columns',
    this.columnVisibilityTrigger,
    this.striped = false,
    this.showRowDividers = true,
    this.showColumnDividers = false,
    this.mutedHeader = false,
    this.enableHorizontalScroll = true,
    this.minTableWidth,
    this.emptyState,
  }) : assert(columns.length > 0, 'CnDataTable requires at least one column.'),
       assert(
         selection == null || rowId != null,
         'Provide rowId when selection is enabled.',
       );
  final List<CnDataTableColumn<T>> columns;
  final List<T> rows;
  final String Function(T row)? rowId;
  final Widget? title;
  final Widget? actions;
  final bool searchable;
  final TextEditingController? searchController;
  final String searchPlaceholder;
  final String Function(T row)? searchValue;

  /// The ids of the selected rows. Without it, the table has no checkboxes.
  final Set<String>? selection;
  final ValueChanged<Set<String>>? onSelectionChanged;
  final int? rowsPerPage;
  final List<int>? rowsPerPageOptions;
  final ValueChanged<int>? onRowsPerPageChanged;
  final String rowsPerPageLabel;
  final bool showPageInfo;
  final int page;
  final ValueChanged<int>? onPageChanged;
  final Widget Function(BuildContext context, T row)? rowActionsBuilder;
  final TableColumnWidth? actionsColumnWidth;

  /// The ids of the hidden columns. With [onHiddenColumnsChanged], the table
  /// also shows a menu for them. Without it, the menu can live somewhere else.
  final Set<String>? hiddenColumns;
  final ValueChanged<Set<String>>? onHiddenColumnsChanged;
  final String columnVisibilityLabel;
  final Widget? columnVisibilityTrigger;
  final bool striped;
  final bool showRowDividers;
  final bool showColumnDividers;
  final bool mutedHeader;
  final bool enableHorizontalScroll;
  final double? minTableWidth;
  final Widget? emptyState;

  @override
  State<CnDataTable<T>> createState() => _CnDataTableState<T>();
}

class _CnDataTableState<T> extends State<CnDataTable<T>> {
  late TextEditingController _searchController;
  bool _ownsSearchController = false;
  String? _sortColumnId;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
    _ownsSearchController = widget.searchController == null;
    _searchController.addListener(_handleSearchChanged);
  }

  @override
  void didUpdateWidget(covariant CnDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchController != widget.searchController) {
      if (_ownsSearchController) {
        _searchController.removeListener(_handleSearchChanged);
        _searchController.dispose();
      }
      _searchController = widget.searchController ?? TextEditingController();
      _ownsSearchController = widget.searchController == null;
      _searchController.addListener(_handleSearchChanged);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchChanged);
    if (_ownsSearchController) {
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRows = _applySearch(widget.rows);
    final sortedRows = _applySort(filteredRows);
    final pagedRows = _applyPagination(sortedRows);
    final pageCount = _pageCount(filteredRows.length);
    final effectivePage = widget.page.clamp(1, pageCount);
    final selectionEnabled = widget.selection != null;
    final selected = widget.selection ?? const <String>{};
    final totalSelected = filteredRows
        .where((row) => selected.contains(widget.rowId?.call(row)))
        .length;
    final visibleColumns = _visibleColumns();
    final rowsPerPage = widget.rowsPerPage;
    final rowsPerPageOptions = _resolveRowsPerPageOptions();
    final showRowsPerPage =
        rowsPerPage != null && rowsPerPageOptions.isNotEmpty;
    final showPageInfo = widget.showPageInfo && rowsPerPage != null;
    final showPager = rowsPerPage != null;
    final showFooter =
        selectionEnabled || rowsPerPage != null || showRowsPerPage;

    final tableColumns = <CnTableColumn>[
      if (selectionEnabled)
        CnTableColumn(
          label: _buildSelectAllCheckbox(pagedRows, selected),
          alignment: AlignmentDirectional.center,
          width: const FixedColumnWidth(48),
        ),
      for (final column in visibleColumns)
        CnTableColumn(
          label: _buildHeaderCell(column),
          alignment: column.resolvedAlignment,
          width: column.width,
        ),
      if (widget.rowActionsBuilder != null)
        CnTableColumn(
          label: const SizedBox.shrink(),
          alignment: AlignmentDirectional.center,
          width: widget.actionsColumnWidth ?? const FixedColumnWidth(56),
        ),
    ];

    final tableRows = _buildTableRows(
      context,
      pagedRows,
      visibleColumns,
      selected,
      selectionEnabled,
      tableColumns.length,
    );

    Widget table = CnTable(
      columns: tableColumns,
      rows: tableRows,
      striped: widget.striped,
      showRowDividers: widget.showRowDividers,
      showColumnDividers: widget.showColumnDividers,
      mutedHeader: widget.mutedHeader,
    );

    if (widget.enableHorizontalScroll) {
      // Fills the available width and only scrolls if the content needs more.
      final content = table;
      table = LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          scrollDirection: .horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: math.max(
                constraints.maxWidth,
                widget.minTableWidth ?? 0,
              ),
            ),
            child: IntrinsicWidth(child: content),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        if (widget.title != null)
          Padding(
            padding: const .only(bottom: 12),
            child: DefaultTextStyle.merge(
              style: CnTheme.of(context).text.base.semibold,
              child: widget.title!,
            ),
          ),
        if (widget.searchable || widget.actions != null || _showsColumnMenu)
          Padding(padding: const .only(bottom: 12), child: _buildToolbar()),
        table,
        if (showFooter)
          Padding(
            padding: const .only(top: 12),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Text(
                    selectionEnabled
                        ? '$totalSelected of ${filteredRows.length} row(s) selected'
                        : '${filteredRows.length} row(s)',
                    style: CnTheme.of(context).text.xs,
                  ),
                ),
                Row(
                  mainAxisSize: .min,
                  spacing: 16,
                  children: [
                    if (rowsPerPage != null && rowsPerPageOptions.isNotEmpty)
                      _buildRowsPerPageControl(rowsPerPageOptions, rowsPerPage),
                    if (showPageInfo)
                      Text(
                        'Page $effectivePage of $pageCount',
                        style: CnTheme.of(context).text.xs,
                      ),
                    if (showPager) _buildPager(effectivePage, pageCount),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  bool get _showsColumnMenu {
    return widget.hiddenColumns != null &&
        widget.onHiddenColumnsChanged != null;
  }

  Widget _buildToolbar() {
    final trailingItems = <Widget>[];
    if (_showsColumnMenu) {
      trailingItems.add(_buildColumnVisibilityMenu());
    }
    if (widget.actions != null) {
      trailingItems.add(widget.actions!);
    }

    return Row(
      spacing: 8,
      children: [
        if (widget.searchable) SizedBox(width: 280, child: _buildSearchField()),
        if (widget.searchable) const Spacer(),
        if (!widget.searchable && trailingItems.isNotEmpty) const Spacer(),
        ...trailingItems,
      ],
    );
  }

  Widget _buildColumnVisibilityMenu() {
    final hidden = widget.hiddenColumns!;
    final isLastVisible = hidden.length >= widget.columns.length - 1;
    final entries = [
      for (final column in widget.columns)
        CnMenuCheckboxItem(
          label: Text(column.toggleLabel ?? column.id),
          value: !hidden.contains(column.id),
          onChanged: hidden.contains(column.id) || !isLastVisible
              ? (value) => _toggleColumnVisibility(column.id, value)
              : null,
        ),
    ];

    if (widget.columnVisibilityTrigger != null) {
      return CnDropdownMenu(
        entries: entries,
        trigger: widget.columnVisibilityTrigger!,
      );
    }

    return CnDropdownMenu.builder(
      entries: entries,
      builder: (context, toggle) => CnButton(
        variant: .outline,
        size: .sm,
        leading: const Icon(Icons.view_column_outlined),
        onPressed: toggle,
        child: Text(widget.columnVisibilityLabel),
      ),
    );
  }

  Widget _buildSearchField() {
    final query = _searchController.text;
    return CnInput(
      controller: _searchController,
      placeholder: widget.searchPlaceholder,
      leading: const Icon(Icons.search, size: 16),
      trailing: query.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.close, size: 16),
              onPressed: () {
                _searchController.clear();
              },
            ),
    );
  }

  Widget _buildRowsPerPageControl(List<int> options, int rowsPerPage) {
    return Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Text(widget.rowsPerPageLabel, style: CnTheme.of(context).text.xs),
        SizedBox(
          width: 92,
          child: CnSelect<int>(
            value: rowsPerPage,
            items: [
              for (final option in options)
                CnSelectItem<int>(
                  value: option,
                  child: Text(option.toString()),
                ),
            ],
            onChanged: widget.onRowsPerPageChanged == null
                ? null
                : (value) {
                    if (value != null) {
                      widget.onRowsPerPageChanged!(value);
                    }
                  },
          ),
        ),
      ],
    );
  }

  Widget _buildPager(int page, int pageCount) {
    final canGoBack = page > 1;
    final canGoForward = page < pageCount;
    return Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        _buildPagerButton(
          icon: Icons.first_page,
          enabled: canGoBack,
          onPressed: () => widget.onPageChanged?.call(1),
        ),
        _buildPagerButton(
          icon: Icons.chevron_left,
          enabled: canGoBack,
          onPressed: () => widget.onPageChanged?.call(page - 1),
        ),
        _buildPagerButton(
          icon: Icons.chevron_right,
          enabled: canGoForward,
          onPressed: () => widget.onPageChanged?.call(page + 1),
        ),
        _buildPagerButton(
          icon: Icons.last_page,
          enabled: canGoForward,
          onPressed: () => widget.onPageChanged?.call(pageCount),
        ),
      ],
    );
  }

  Widget _buildPagerButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    return CnButton.icon(
      variant: .outline,
      size: .sm,
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon),
    );
  }

  List<int> _resolveRowsPerPageOptions() {
    final options = widget.rowsPerPageOptions ?? const [];
    final rowsPerPage = widget.rowsPerPage;
    if (rowsPerPage == null) {
      return options;
    }
    if (options.contains(rowsPerPage)) {
      return options;
    }
    final next = [...options, rowsPerPage]..sort();
    return next;
  }

  void _toggleColumnVisibility(String id, bool visible) {
    final next = {...?widget.hiddenColumns};
    if (visible) {
      next.remove(id);
    } else {
      next.add(id);
      if (_sortColumnId == id) {
        setState(() => _sortColumnId = null);
      }
    }
    widget.onHiddenColumnsChanged?.call(next);
  }

  List<CnDataTableColumn<T>> _visibleColumns() {
    final hidden = widget.hiddenColumns ?? const <String>{};
    return [
      for (final column in widget.columns)
        if (!hidden.contains(column.id)) column,
    ];
  }

  Widget _buildHeaderCell(CnDataTableColumn<T> column) {
    final colors = CnTheme.of(context).colors;
    if (!column.canSort) {
      return column.label;
    }
    final isSorted = _sortColumnId == column.id;
    final icon = isSorted
        ? (_sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
        : Icons.unfold_more;
    final iconColor = isSorted ? colors.mutedForeground : colors.input;

    return InkWell(
      onTap: () => _toggleSort(column),
      child: SizedBox(
        width: .infinity,
        child: Row(
          mainAxisSize: .max,
          mainAxisAlignment: column.numeric ? .end : .start,
          spacing: 6,
          children: [
            Flexible(child: column.label),
            Icon(icon, size: 16, color: iconColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectAllCheckbox(List<T> rows, Set<String> selected) {
    final rowId = widget.rowId!;
    final rowIds = rows.map(rowId).toList();
    final allSelected =
        rowIds.isNotEmpty && rowIds.every((id) => selected.contains(id));
    final anySelected = rowIds.any((id) => selected.contains(id));

    return Checkbox(
      value: allSelected ? true : (anySelected ? null : false),
      tristate: true,
      onChanged: (value) {
        final next = Set<String>.from(selected);
        if (value == true) {
          next.addAll(rowIds);
        } else {
          next.removeAll(rowIds);
        }
        _updateSelection(next);
      },
    );
  }

  List<CnTableRow> _buildTableRows(
    BuildContext context,
    List<T> rows,
    List<CnDataTableColumn<T>> visibleColumns,
    Set<String> selected,
    bool selectionEnabled,
    int columnCount,
  ) {
    final rowId = widget.rowId;
    if (rows.isEmpty) {
      final messageIndex = selectionEnabled ? 1 : 0;
      return [
        CnTableRow(
          cells: [
            for (var i = 0; i < columnCount; i++)
              if (i == messageIndex)
                Padding(
                  padding: const .symmetric(vertical: 8),
                  child:
                      widget.emptyState ??
                      Text('No results.', style: CnTheme.of(context).text.sm),
                )
              else
                const SizedBox.shrink(),
          ],
        ),
      ];
    }

    return rows.map((row) {
      final cells = <Widget>[
        if (selectionEnabled)
          Checkbox(
            value: selected.contains(rowId!(row)),
            onChanged: (value) {
              final next = Set<String>.from(selected);
              if (value == true) {
                next.add(rowId(row));
              } else {
                next.remove(rowId(row));
              }
              _updateSelection(next);
            },
          ),
        for (final column in visibleColumns) column.cellBuilder(context, row),
        if (widget.rowActionsBuilder != null)
          widget.rowActionsBuilder!(context, row),
      ];

      return CnTableRow(
        cells: cells,
        selected: selected.contains(rowId?.call(row)),
      );
    }).toList();
  }

  void _toggleSort(CnDataTableColumn<T> column) {
    if (!column.canSort) {
      return;
    }
    setState(() {
      if (_sortColumnId == column.id) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnId = column.id;
        _sortAscending = true;
      }
    });
  }

  List<T> _applySearch(List<T> rows) {
    if (!widget.searchable) {
      return rows;
    }
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return rows;
    }
    final valueBuilder = widget.searchValue;
    return rows.where((row) {
      final value = valueBuilder?.call(row) ?? row.toString();
      return value.toLowerCase().contains(query);
    }).toList();
  }

  List<T> _applySort(List<T> rows) {
    if (_sortColumnId == null) {
      return rows;
    }
    final column = widget.columns.firstWhere(
      (col) => col.id == _sortColumnId,
      orElse: () => widget.columns.first,
    );
    if (!column.canSort) {
      return rows;
    }
    final sorted = List<T>.from(rows);
    sorted.sort((a, b) {
      if (column.sortComparator != null) {
        return column.sortComparator!(a, b);
      }
      final valueBuilder = column.sortValue;
      final valueA = valueBuilder?.call(a);
      final valueB = valueBuilder?.call(b);
      return _compareNullable(valueA, valueB);
    });
    if (!_sortAscending) {
      return sorted.reversed.toList();
    }
    return sorted;
  }

  List<T> _applyPagination(List<T> rows) {
    final rowsPerPage = widget.rowsPerPage;
    if (rowsPerPage == null || rowsPerPage <= 0) {
      return rows;
    }
    final pageCount = _pageCount(rows.length);
    final effectivePage = widget.page.clamp(1, pageCount);
    final start = (effectivePage - 1) * rowsPerPage;
    var end = start + rowsPerPage;
    if (end > rows.length) {
      end = rows.length;
    }
    if (start >= rows.length || start < 0) {
      return rows;
    }
    return rows.sublist(start, end);
  }

  int _pageCount(int totalRows) {
    final rowsPerPage = widget.rowsPerPage;
    if (rowsPerPage == null || rowsPerPage <= 0) {
      return 1;
    }
    if (totalRows == 0) {
      return 1;
    }
    return (totalRows / rowsPerPage).ceil();
  }

  int _compareNullable(Comparable? a, Comparable? b) {
    if (a == null && b == null) {
      return 0;
    }
    if (a == null) {
      return 1;
    }
    if (b == null) {
      return -1;
    }
    return a.compareTo(b);
  }

  void _updateSelection(Set<String> next) {
    widget.onSelectionChanged?.call(next);
  }

  void _handleSearchChanged() {
    setState(() {});
    if (widget.page != 1) {
      widget.onPageChanged?.call(1);
    }
  }
}
