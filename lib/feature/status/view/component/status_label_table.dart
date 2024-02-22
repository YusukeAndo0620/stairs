import 'package:stairs/feature/status/model/label_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

const _kHeaderLabelText = "ラベル名";
const _kHeaderTotalCountText = "総数";
const _kHeaderPercentText = "比率";
const _kHeaderHeight = 20.0;
const _kLabelNameWidth = 120.0;
const _kProgressPercentHeight = 20.0;
const _kProgressPercentAnimation = 1000;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);

final _logger = stairsLogger(name: 'status_label_table');

class StatusLabelTable extends StatefulWidget {
  const StatusLabelTable({
    super.key,
    required this.totalLabelTaskCount,
    required this.labelStatusList,
  });
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
    _logger.d('===================================');
    _logger.d('ビルド開始');
    final theme = LoomTheme.of(context);

    return Container(
      padding: _kContentPadding,
      margin: _kContentMargin,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.33),
      child: DataTable2(
        sortColumnIndex: sortedColumnIdx,
        sortAscending: sortAscending,
        headingRowHeight: _kHeaderHeight,
        columnSpacing: 10.0,
        horizontalMargin: 10.0,
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
              alignment: Alignment.centerRight,
              child: Text(
                _kHeaderTotalCountText,
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
                _kHeaderPercentText,
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
                      width: _kLabelNameWidth,
                      label: item.labelName,
                      themeColor: item.themeColorModel.color,
                    ),
                  ),
                  DataCell(
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        item.taskIdList.length.toString(),
                        style: theme.textStyleBody,
                      ),
                    ),
                  ),
                  DataCell(
                    LinearPercentIndicator(
                      animation: true,
                      lineHeight: _kProgressPercentHeight,
                      animationDuration: _kProgressPercentAnimation,
                      percent:
                          item.taskIdList.length / widget.totalLabelTaskCount,
                      center: Text(
                        getFormattedPercent(
                          percent: (item.taskIdList.length /
                                  widget.totalLabelTaskCount *
                                  100)
                              .toInt(),
                        ),
                        style: theme.textStyleBody,
                      ),
                      barRadius: const Radius.circular(10),
                      backgroundColor: theme.colorFgDisabled,
                      progressColor: theme.colorPrimary,
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
