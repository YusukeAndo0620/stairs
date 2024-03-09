import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/feature/status/provider/component/label_table_provider.dart';
import 'package:stairs/feature/status/view/component/count_indicator.dart';
import 'package:stairs/loom/loom_package.dart';

const _kHeaderLabelText = "ラベル名";
const _kHeaderTotalCountText = "総数";
const _kEmptyText = "タスクに設定されているラベルがありません。";

const _kBorderWidth = 1.0;
const _kHeaderHeight = 20.0;
const _kRowHeight = 48.0;
const _kCountWidth = 40.0;
const _kEmptyIconAndTxtSpace = 8.0;

// ラベル一覧表
class LabelTable extends ConsumerWidget {
  const LabelTable({
    super.key,
    this.margin,
    required this.totalLabelTaskCount,
    required this.labelStatusList,
  });
  final EdgeInsets? margin;
  final int totalLabelTaskCount;
  final List<LabelStatusModel> labelStatusList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LoomTheme.of(context);

    final labelTableState =
        ref.watch(labelTableProvider(labelStatusList: labelStatusList));
    final labelTableNotifier = ref
        .watch(labelTableProvider(labelStatusList: labelStatusList).notifier);

    return Container(
      margin: margin,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        // 4レコードまで一覧に表示
        maxHeight: labelTableState.list.isEmpty
            ? MediaQuery.of(context).size.height * 0.15
            : _kHeaderHeight +
                _kRowHeight *
                    (labelTableState.list.length <= 4
                        ? labelTableState.list.length
                        : 4),
      ),
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
      ),
      child: DataTable2(
        sortColumnIndex: 0,
        sortAscending: true,
        headingRowHeight: _kHeaderHeight,
        columnSpacing: 10.0,
        horizontalMargin: 10.0,
        empty: const _EmptyArea(),
        headingRowColor: MaterialStateProperty.resolveWith(
            (states) => theme.colorFgDisabled.withOpacity(0.3)),
        columns: [
          DataColumn(
            label: Align(
              child: Text(
                _kHeaderLabelText,
                style: theme.textStyleBody,
              ),
            ),
            onSort: (columnIndex, ascending) => labelTableNotifier.sortList(
                columnIdx: columnIndex, isAsc: ascending),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                _kHeaderTotalCountText,
                style: theme.textStyleBody,
              ),
            ),
            onSort: (columnIndex, ascending) => labelTableNotifier.sortList(
                columnIdx: columnIndex, isAsc: ascending),
          ),
        ],
        rows: [
          if (labelTableState.list.isNotEmpty) ...[
            for (final item in labelTableState.list) ...[
              DataRow(
                cells: [
                  DataCell(
                    LabelTip(
                      width: MediaQuery.of(context).size.width * 0.5,
                      label: item.labelName,
                      themeColor: item.themeColorModel.color,
                    ),
                  ),
                  DataCell(
                    CountIndicator(
                      countWidth: _kCountWidth,
                      percentIndicatorWidth:
                          MediaQuery.of(context).size.width * 0.28,
                      count: item.taskIdList.length,
                      totalCount: totalLabelTaskCount,
                    ),
                  ),
                ],
              )
            ],
          ]
        ],
      ),
    );
  }
}

class _EmptyArea extends StatelessWidget {
  const _EmptyArea();

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.info,
          color: theme.colorPrimary,
        ),
        const SizedBox(
          width: _kEmptyIconAndTxtSpace,
        ),
        Text(
          _kEmptyText,
          style: theme.textStyleBody,
        )
      ],
    );
  }
}
