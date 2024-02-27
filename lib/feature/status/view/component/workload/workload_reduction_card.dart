import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/feature/status/view/component/workload/task_workload_card.dart';
import 'package:stairs/loom/loom_package.dart';

const _kAnimation = 800.0;
const _kWorkloadFluctuationIconSize = 18.0;
const _kWorkloadFluctuationSpace = 8.0;

const _kTitle = "工数削減・超過タスク数";
const _kWorkloadReductionTxt = "工数削減";
const _kWorkloadExcessTxt = "工数超過";
const _kProgressTaskCountTxt = "進行中";
const _kWorkloadTitlePadding = EdgeInsets.zero;

// 工数削減情報カード
class WorkloadReductionCard extends TaskWorkloadCard {
  const WorkloadReductionCard({
    super.key,
    required super.height,
    this.firstDate,
    this.lastDate,
    required this.taskStatusModelList,
  });

  final DateTime? firstDate;
  final DateTime? lastDate;
  final List<TaskStatusModel> taskStatusModelList;

  @override
  Widget buildMainContents(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // タイトル
        TextIcon(
          title: _kTitle,
          padding: _kWorkloadTitlePadding,
          icon: Icon(
            Icons.info,
            size: _kWorkloadFluctuationIconSize,
            color: theme.colorPrimary,
          ),
        ),
        const SizedBox(
          height: _kWorkloadFluctuationSpace,
        ),
        SizedBox(
          height: height * 0.82,
          child: SfCircularChart(
            // 凡例の表示
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.scroll,
              textStyle:
                  theme.textStyleFootnote.copyWith(color: theme.colorFgDefault),
            ),
            palette: [
              theme.colorPrimary,
              theme.colorDangerBgDefault,
              theme.colorFgDisabled
            ],
            series: <PieSeries<_PieChartData, String>>[
              PieSeries<_PieChartData, String>(
                animationDuration: _kAnimation,
                explode: true,
                explodeIndex: 0,
                dataSource: _getChartData(
                    firstDate: firstDate,
                    lastDate: lastDate,
                    taskStatusModelList: taskStatusModelList),
                xValueMapper: (_PieChartData data, _) => data.x,
                yValueMapper: (_PieChartData data, _) => data.y,
                dataLabelMapper: (_PieChartData data, _) => data.text,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.inside,
                  alignment: ChartAlignment.far,
                  textStyle: theme.textStyleFootnote
                      .copyWith(color: theme.colorFgDefault),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<_PieChartData> _getChartData({
  DateTime? firstDate,
  DateTime? lastDate,
  required List<TaskStatusModel> taskStatusModelList,
}) {
  if (firstDate == null || lastDate == null) {
    return [
      // 期日前に完了したタスク
      _PieChartData(
        x: _kWorkloadReductionTxt,
        text: getLabelTxt(count: 0),
        y: 0,
      ),
      // 期限切れとなったタスク
      _PieChartData(
        x: _kWorkloadExcessTxt,
        text: getLabelTxt(count: 0),
        y: 0,
      ),
      // 進行中タスク数
      _PieChartData(
        x: _kProgressTaskCountTxt,
        text: getLabelTxt(count: 0),
        y: 0,
      ),
    ];
  }
  // 期日をこえたタスク数
  int overDueDateTaskCount = 0;
  // 期日前に完了したタスク数
  int beforeDueDateTaskCount = 0;

  for (final item in taskStatusModelList) {
    // 期日を越えている
    if (item.isOverDuDate(firstDate: firstDate, lastDate: lastDate)) {
      overDueDateTaskCount += 1;
      // 期日前に完了
    } else if (item.isBeforeDuDate(firstDate: firstDate, lastDate: lastDate)) {
      beforeDueDateTaskCount += 1;
    }
  }
  final List<_PieChartData> chartList = [];
  // 期日前に完了したタスク
  chartList.add(
    _PieChartData(
      x: _kWorkloadReductionTxt,
      text: getLabelTxt(count: beforeDueDateTaskCount),
      y: beforeDueDateTaskCount,
    ),
  );
  // 期限切れとなったタスク
  chartList.add(
    _PieChartData(
      x: _kWorkloadExcessTxt,
      text: getLabelTxt(count: overDueDateTaskCount),
      y: overDueDateTaskCount,
    ),
  );
  final progressTaskCount = taskStatusModelList.length -
      beforeDueDateTaskCount -
      overDueDateTaskCount;
  // 進行中タスク数
  chartList.add(
    _PieChartData(
      x: _kProgressTaskCountTxt,
      text: getLabelTxt(count: progressTaskCount),
      y: progressTaskCount,
    ),
  );
  return chartList;
}

String getLabelTxt({required int count}) {
  return count > 0 ? '${count.toString()}件' : '';
}

class _PieChartData {
  _PieChartData({required this.x, required this.y, this.text});

  final String x;
  final int y;
  String? text;
}
