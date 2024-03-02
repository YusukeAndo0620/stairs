import 'package:stairs/feature/status/model/label_status_model.dart';
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
class StatusLabelTable extends StatefulWidget {
  const StatusLabelTable({
    super.key,
    this.margin,
    required this.totalLabelTaskCount,
    required this.labelStatusList,
  });
  final EdgeInsets? margin;
  final int totalLabelTaskCount;
  final List<LabelStatusModel> labelStatusList;
  @override
  State<StatefulWidget> createState() => _StatusLabelTableState();
}

class _StatusLabelTableState extends State<StatusLabelTable> {
  bool sortAscending = true;
  int sortedColumnIdx = 0;
  final List<LabelStatusModel> list = [];

  @override
  void initState() {
    super.initState();
    list.addAll(widget.labelStatusList);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      margin: widget.margin,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          // 4レコードまで一覧に表示
          maxHeight: list.isEmpty
              ? MediaQuery.of(context).size.height * 0.15
              : _kHeaderHeight +
                  _kRowHeight * (list.length <= 4 ? list.length : 4)),
      decoration: BoxDecoration(
        color: theme.colorFgDefaultWhite,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorFgDisabled,
          width: _kBorderWidth,
        ),
      ),
      child: DataTable2(
        sortColumnIndex: sortedColumnIdx,
        sortAscending: sortAscending,
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
            onSort: (columnIndex, ascending) =>
                sortList(columnIdx: columnIndex, isAsc: ascending),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                _kHeaderTotalCountText,
                style: theme.textStyleBody,
              ),
            ),
            onSort: (columnIndex, ascending) =>
                sortList(columnIdx: columnIndex, isAsc: ascending),
          ),
        ],
        rows: [
          if (list.isNotEmpty) ...[
            for (final item in list) ...[
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
                      totalCount: widget.totalLabelTaskCount,
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

  void sortList({required int columnIdx, required bool isAsc}) {
    list.sort(
      (a, b) {
        switch (columnIdx) {
          // ラベル名
          case 0:
            return isAsc
                ? a.labelId.compareTo(b.labelId)
                : b.labelId.compareTo(a.labelId);
          case 1:
            // 総数
            return isAsc
                ? a.taskIdList.length.compareTo(b.taskIdList.length)
                : b.taskIdList.length.compareTo(a.taskIdList.length);
          case 2:
            // 比率
            return isAsc
                ? a.taskIdList.length.compareTo(b.taskIdList.length)
                : b.taskIdList.length.compareTo(a.taskIdList.length);
          default:
            return isAsc
                ? a.labelId.compareTo(b.labelId)
                : b.labelId.compareTo(a.labelId);
        }
      },
    );

    setState(() {
      sortAscending = isAsc;
      sortedColumnIdx = columnIdx;
    });
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
