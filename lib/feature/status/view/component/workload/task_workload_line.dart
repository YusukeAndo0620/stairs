import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/feature/status/provider/component/task_workload_line_provider.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kLineMargin = EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0);
const _kTooltipSpace = 8.0;
const _kTaskWorkloadTxt = "工数短縮率推移";
const _kXAxisTxt = "タスク開始日";
final _logger = stairsLogger(name: 'task_workload_line');

class TaskWorkloadLine extends ConsumerWidget {
  const TaskWorkloadLine({
    super.key,
    required this.taskStatusModelList,
  });

  final List<TaskStatusModel> taskStatusModelList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _logger.d('===================================');
    _logger.d('ビルド開始');

    final taskWorkloadLineState = ref.watch(
        taskWorkloadLineProvider(taskStatusModelList: taskStatusModelList));

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.38,
      child: _WorkLoadLine(chartData: taskWorkloadLineState),
    );
  }
}

// 折れ線
class _WorkLoadLine extends StatelessWidget {
  const _WorkLoadLine({
    required this.chartData,
  });

  final List<TaskWorkloadLineData> chartData;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return SfCartesianChart(
      margin: _kLineMargin,
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(text: _kXAxisTxt, textStyle: theme.textStyleBody),
        dateFormat: DateFormat('MM/dd'),
        edgeLabelPlacement: EdgeLabelPlacement.none,
        interval: 7,
      ),
      primaryYAxis: const NumericAxis(labelFormat: '{value}%'),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          if (chartData.length < pointIndex) {
            return const SizedBox.shrink();
          }
          final item = chartData[pointIndex];
          return _Tooltip(
            date: item.date,
            workloadPercent: item.workloadPercent,
          );
        },
      ),
      series: <CartesianSeries>[
        FastLineSeries<TaskWorkloadLineData, DateTime>(
          name: _kTaskWorkloadTxt,
          dataSource: chartData,
          xValueMapper: (TaskWorkloadLineData data, _) => data.date,
          yValueMapper: (TaskWorkloadLineData data, _) => data.workloadPercent,
        )
      ],
    );
  }
}

// ツールチップ
class _Tooltip extends StatelessWidget {
  const _Tooltip({
    required this.date,
    required this.workloadPercent,
  });
  final DateTime date;
  final double workloadPercent;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);

    return Container(
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: theme.colorBgLayer1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getFormattedDate(date),
            style: theme.textStyleBody,
          ),
          const SizedBox(
            height: _kTooltipSpace,
          ),
          Text(
            "$workloadPercent%",
            style: theme.textStyleSubHeading.copyWith(
                color: workloadPercent < 0
                    ? theme.colorDangerBgDefault
                    : theme.colorPrimary),
          ),
        ],
      ),
    );
  }
}
