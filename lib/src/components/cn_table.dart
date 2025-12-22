import 'package:flutter/material.dart';

import '../theme/cn_theme.dart';
import 'cn_button.dart';
import 'cn_dropdown_menu.dart';
import 'cn_input.dart';
import 'cn_select.dart';

/// A column definition for [CnTable].
class CnTableColumn {
  final Widget label;
  final Alignment alignment;
  final TableColumnWidth? width;

  const CnTableColumn({
    required this.label,
    this.alignment = Alignment.centerLeft,
    this.width,
  });
}

/// A row definition for [CnTable].
class CnTableRow {
  final List<Widget> cells;
  final bool selected;
  final Decoration? decoration;

  const CnTableRow({
    required this.cells,
    this.selected = false,
    this.decoration,
  });
}

/// A simple table component for displaying tabular data.
///
/// Provides a basic table with customizable styling, headers, and cell content.
///
/// See also:
///
///  * [CnDataTable], for a feature-rich data table with sorting, filtering, and pagination.
class CnTable extends StatelessWidget {
  final List<CnTableColumn> columns;
  final List<CnTableRow> rows;
  final bool showHeader;
  final bool striped;
  final bool showRowDividers;
  final bool showColumnDividers;
  final EdgeInsets cellPadding;
  final TableColumnWidth? defaultColumnWidth;
  final Color? headerColor;
  final TextStyle? headerTextStyle;
  final TextStyle? cellTextStyle;

  const CnTable({
    super.key,
    required this.columns,
    required this.rows,
    this.showHeader = true,
    this.striped = false,
    this.showRowDividers = true,
    this.showColumnDividers = false,
    this.cellPadding = const .symmetric(horizontal: 16, vertical: 12),
    this.defaultColumnWidth,
    this.headerColor,
    this.headerTextStyle,
    this.cellTextStyle,
  }) : assert(columns.length > 0, 'CnTable requires at least one column.');

  @override
  Widget build(BuildContext context) {
    assert(
      rows.every((row) => row.cells.length == columns.length),
      'Each row must provide a cell for every column.',
    );
    final scheme = CnTheme.colorSchemeOf(context);
    final cnTheme = CnTheme.of(context);
    final resolvedHeaderColor = headerColor ?? scheme.surfaceContainerHighest;
    final resolvedHeaderTextStyle =
        headerTextStyle ??
        CnTheme.textThemeOf(context).labelLarge?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: .w600,
        );
    final resolvedCellTextStyle =
        cellTextStyle ??
        CnTheme.textThemeOf(
          context,
        ).bodyMedium?.copyWith(color: scheme.onSurface);
    final borderColor = scheme.outlineVariant;
    final tableBorder = TableBorder(
      horizontalInside: showRowDividers
          ? BorderSide(color: borderColor)
          : BorderSide.none,
      verticalInside: showColumnDividers
          ? BorderSide(color: borderColor)
          : BorderSide.none,
    );

    final tableRows = <TableRow>[
      if (showHeader)
        TableRow(
          decoration: BoxDecoration(color: resolvedHeaderColor),
          children: [
            for (final column in columns)
              _buildCell(
                context,
                child: column.label,
                alignment: column.alignment,
                style: resolvedHeaderTextStyle,
              ),
          ],
        ),
      for (var i = 0; i < rows.length; i++)
        TableRow(
          decoration: _rowDecoration(rows[i], scheme, striped, i),
          children: [
            for (var j = 0; j < rows[i].cells.length; j++)
              _buildCell(
                context,
                child: rows[i].cells[j],
                alignment: columns[j].alignment,
                style: resolvedCellTextStyle,
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
          defaultColumnWidth:
              defaultColumnWidth ?? const IntrinsicColumnWidth(),
          columnWidths: {
            for (var i = 0; i < columns.length; i++)
              if (columns[i].width != null) i: columns[i].width!,
          },
          border: tableBorder,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: tableRows,
        ),
      ),
    );
  }

  Widget _buildCell(
    BuildContext context, {
    required Widget child,
    required Alignment alignment,
    TextStyle? style,
  }) {
    return Padding(
      padding: cellPadding,
      child: Align(
        alignment: alignment,
        child: DefaultTextStyle(
          style: style ?? DefaultTextStyle.of(context).style,
          child: child,
        ),
      ),
    );
  }

  Decoration? _rowDecoration(
    CnTableRow row,
    ColorScheme scheme,
    bool striped,
    int index,
  ) {
    if (row.decoration != null) {
      return row.decoration;
    }
    if (row.selected) {
      return BoxDecoration(color: scheme.primary.withValues(alpha: 0.08));
    }
    if (striped && index.isOdd) {
      return BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      );
    }
    return null;
  }
}

/// A column definition for [CnDataTable].
class CnDataTableColumn<T> {
  final String id;
  final Widget label;
  final String? toggleLabel;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final bool sortable;
  final int Function(T a, T b)? sortComparator;
  final Comparable Function(T row)? sortValue;
  final bool numeric;
  final Alignment? alignment;
  final TableColumnWidth? width;

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

  Alignment get resolvedAlignment {
    return alignment ??
        (numeric ? Alignment.centerRight : Alignment.centerLeft);
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
  final List<CnDataTableColumn<T>> columns;
  final List<T> rows;
  final String Function(T row)? rowId;
  final Widget? title;
  final Widget? actions;
  final bool searchable;
  final TextEditingController? searchController;
  final String searchPlaceholder;
  final String Function(T row)? searchValue;
  final bool enableSelection;
  final Set<String>? selectedRowIds;
  final ValueChanged<Set<String>>? onSelectionChanged;
  final int? rowsPerPage;
  final List<int>? rowsPerPageOptions;
  final ValueChanged<int>? onRowsPerPageChanged;
  final String rowsPerPageLabel;
  final bool showPageInfo;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;
  final Widget Function(BuildContext context, T row)? rowActionsBuilder;
  final TableColumnWidth? actionsColumnWidth;
  final bool enableColumnVisibility;
  final Map<String, bool>? columnVisibility;
  final ValueChanged<Map<String, bool>>? onColumnVisibilityChanged;
  final String columnVisibilityLabel;
  final Widget? columnVisibilityTrigger;
  final bool striped;
  final bool showRowDividers;
  final bool showColumnDividers;
  final bool enableHorizontalScroll;
  final double? minTableWidth;
  final Widget? emptyState;

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
    this.enableSelection = false,
    this.selectedRowIds,
    this.onSelectionChanged,
    this.rowsPerPage,
    this.rowsPerPageOptions,
    this.onRowsPerPageChanged,
    this.rowsPerPageLabel = 'Rows per page',
    this.showPageInfo = true,
    this.initialPage = 1,
    this.onPageChanged,
    this.rowActionsBuilder,
    this.actionsColumnWidth,
    this.enableColumnVisibility = false,
    this.columnVisibility,
    this.onColumnVisibilityChanged,
    this.columnVisibilityLabel = 'Columns',
    this.columnVisibilityTrigger,
    this.striped = false,
    this.showRowDividers = true,
    this.showColumnDividers = false,
    this.enableHorizontalScroll = true,
    this.minTableWidth,
    this.emptyState,
  }) : assert(columns.length > 0, 'CnDataTable requires at least one column.'),
       assert(
         !enableSelection || rowId != null,
         'Provide rowId when selection is enabled.',
       );

  @override
  State<CnDataTable<T>> createState() => _CnDataTableState<T>();
}

class _CnDataTableState<T> extends State<CnDataTable<T>> {
  late TextEditingController _searchController;
  bool _ownsSearchController = false;
  late Set<String> _selectedRowIds;
  late Map<String, bool> _columnVisibility;
  String? _sortColumnId;
  bool _sortAscending = true;
  late int _page;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
    _ownsSearchController = widget.searchController == null;
    _searchController.addListener(_handleSearchChanged);
    _selectedRowIds = widget.selectedRowIds ?? <String>{};
    _columnVisibility = _resolveVisibility(widget.columnVisibility);
    _page = widget.initialPage;
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
    if (widget.selectedRowIds != null &&
        widget.selectedRowIds != oldWidget.selectedRowIds) {
      _selectedRowIds = widget.selectedRowIds ?? <String>{};
    }
    if (widget.columnVisibility != oldWidget.columnVisibility) {
      _columnVisibility = _resolveVisibility(widget.columnVisibility);
    } else if (widget.columns != oldWidget.columns) {
      _columnVisibility = _resolveVisibility(_columnVisibility);
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
    final effectivePage = _page.clamp(1, pageCount);
    final selectionEnabled = widget.enableSelection;
    final selected = widget.selectedRowIds ?? _selectedRowIds;
    final totalSelected = filteredRows
        .where((row) => selected.contains(widget.rowId?.call(row)))
        .length;
    final visibility = _normalizedVisibility(_currentVisibility);
    final visibleColumns = _visibleColumns(visibility);
    final rowsPerPage = widget.rowsPerPage;
    final rowsPerPageOptions = _resolveRowsPerPageOptions();
    final showRowsPerPage =
        rowsPerPage != null && rowsPerPageOptions.isNotEmpty;
    final showPageInfo = widget.showPageInfo && rowsPerPage != null;
    final showPager = rowsPerPage != null;
    final showFooter =
        widget.enableSelection || rowsPerPage != null || showRowsPerPage;

    final tableColumns = <CnTableColumn>[
      if (selectionEnabled)
        CnTableColumn(
          label: _buildSelectAllCheckbox(pagedRows, selected),
          alignment: Alignment.center,
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
          alignment: Alignment.center,
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
    );

    if (widget.enableHorizontalScroll) {
      table = SingleChildScrollView(
        scrollDirection: .horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: widget.minTableWidth ?? 0),
          child: table,
        ),
      );
    }

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const .only(bottom: 12),
            child: DefaultTextStyle(
              style:
                  CnTheme.textThemeOf(context).titleMedium ??
                  const TextStyle(fontSize: 16),
              child: widget.title!,
            ),
          ),
        if (widget.searchable ||
            widget.actions != null ||
            widget.enableColumnVisibility)
          Padding(
            padding: const .only(bottom: 12),
            child: _buildToolbar(visibility),
          ),
        table,
        if (showFooter)
          Padding(
            padding: const .only(top: 12),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Text(
                    widget.enableSelection
                        ? '$totalSelected of ${filteredRows.length} row(s) selected'
                        : '${filteredRows.length} row(s)',
                    style: CnTheme.textThemeOf(context).bodySmall,
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
                        style: CnTheme.textThemeOf(context).bodySmall,
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

  Widget _buildToolbar(Map<String, bool> visibility) {
    final trailingItems = <Widget>[];
    if (widget.enableColumnVisibility) {
      trailingItems.add(_buildColumnVisibilityMenu(visibility));
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

  Widget _buildColumnVisibilityMenu(Map<String, bool> visibility) {
    final visibleCount = visibility.values.where((value) => value).length;
    final entries = [
      for (final column in widget.columns)
        CnDropdownMenuCheckboxItem(
          label: _columnToggleLabel(column),
          checked: visibility[column.id] ?? true,
          onChanged: _canToggleColumn(visibility, column.id, visibleCount)
              ? (value) => _toggleColumnVisibility(column.id, value)
              : null,
        ),
    ];

    if (widget.columnVisibilityTrigger != null) {
      return CnDropdownMenu(
        entries: entries,
        trigger: widget.columnVisibilityTrigger,
      );
    }

    return CnDropdownMenu(
      entries: entries,
      triggerBuilder: (context, controller) => CnButton(
        variant: .outline,
        size: .sm,
        leading: const Icon(Icons.view_column_outlined, size: 18),
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: Text(widget.columnVisibilityLabel),
      ),
    );
  }

  Widget _buildSearchField() {
    final query = _searchController.text;
    return CnInput(
      controller: _searchController,
      placeholder: widget.searchPlaceholder,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: query.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.close),
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
        Text(
          widget.rowsPerPageLabel,
          style: CnTheme.textThemeOf(context).bodySmall,
        ),
        SizedBox(
          width: 92,
          child: CnSelect<int>(
            value: rowsPerPage,
            items: [
              for (final option in options)
                DropdownMenuItem<int>(
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
          onPressed: () => _handlePageChanged(1),
        ),
        _buildPagerButton(
          icon: Icons.chevron_left,
          enabled: canGoBack,
          onPressed: () => _handlePageChanged(page - 1),
        ),
        _buildPagerButton(
          icon: Icons.chevron_right,
          enabled: canGoForward,
          onPressed: () => _handlePageChanged(page + 1),
        ),
        _buildPagerButton(
          icon: Icons.last_page,
          enabled: canGoForward,
          onPressed: () => _handlePageChanged(pageCount),
        ),
      ],
    );
  }

  Widget _buildPagerButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    return CnButton(
      variant: .outline,
      size: .sm,
      padding: const EdgeInsets.all(8),
      onPressed: enabled ? onPressed : null,
      child: Icon(icon, size: 16),
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

  String _columnToggleLabel(CnDataTableColumn<T> column) {
    return column.toggleLabel ?? column.id;
  }

  bool _canToggleColumn(
    Map<String, bool> visibility,
    String id,
    int visibleCount,
  ) {
    final isVisible = visibility[id] ?? true;
    if (!isVisible) {
      return true;
    }
    return visibleCount > 1;
  }

  void _toggleColumnVisibility(String id, bool value) {
    final current = _normalizedVisibility(_currentVisibility);
    final next = Map<String, bool>.from(current);
    final visibleCount = next.values.where((item) => item).length;
    if (!value && visibleCount <= 1) {
      return;
    }
    next[id] = value;
    final clearSort = !value && _sortColumnId == id;
    widget.onColumnVisibilityChanged?.call(next);
    if (widget.columnVisibility != null) {
      setState(() {
        if (clearSort) {
          _sortColumnId = null;
        }
      });
      return;
    }
    setState(() {
      if (clearSort) {
        _sortColumnId = null;
      }
      _columnVisibility = _resolveVisibility(next);
    });
  }

  Map<String, bool> get _currentVisibility {
    return widget.columnVisibility ?? _columnVisibility;
  }

  Map<String, bool> _resolveVisibility(Map<String, bool>? input) {
    final resolved = <String, bool>{
      for (final column in widget.columns) column.id: input?[column.id] ?? true,
    };
    return resolved;
  }

  Map<String, bool> _normalizedVisibility(Map<String, bool> input) {
    final resolved = _resolveVisibility(input);
    final hasVisible = resolved.values.any((value) => value);
    if (hasVisible || widget.columns.isEmpty) {
      return resolved;
    }
    resolved[widget.columns.first.id] = true;
    return resolved;
  }

  List<CnDataTableColumn<T>> _visibleColumns(Map<String, bool> visibility) {
    return [
      for (final column in widget.columns)
        if (visibility[column.id] ?? true) column,
    ];
  }

  Widget _buildHeaderCell(CnDataTableColumn<T> column) {
    final scheme = CnTheme.colorSchemeOf(context);
    if (!column.canSort) {
      return column.label;
    }
    final isSorted = _sortColumnId == column.id;
    final icon = isSorted
        ? (_sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
        : Icons.unfold_more;
    final iconColor = isSorted ? scheme.onSurfaceVariant : scheme.outline;

    return InkWell(
      onTap: () => _toggleSort(column),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: .max,
          mainAxisAlignment: column.resolvedAlignment == Alignment.centerRight
              ? .end
              : .start,
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
                      Text(
                        'No results.',
                        style: CnTheme.textThemeOf(context).bodyMedium,
                      ),
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
    final effectivePage = _page.clamp(1, pageCount);
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
    if (widget.selectedRowIds != null) {
      widget.onSelectionChanged?.call(next);
      return;
    }
    setState(() => _selectedRowIds = next);
    widget.onSelectionChanged?.call(next);
  }

  void _handlePageChanged(int page) {
    setState(() => _page = page);
    widget.onPageChanged?.call(page);
  }

  void _handleSearchChanged() {
    setState(() => _page = 1);
  }
}
