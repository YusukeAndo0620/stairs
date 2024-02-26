import 'package:stairs/feature/status/enum/task_chart_type.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/feature/status/provider/component/task_status_chart_provider.dart';
import 'package:stairs/feature/status/view/component/status_header.dart';
import 'package:stairs/loom/loom_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _kDisplayedColumnCount = 4;
const _kPageTransitionIconSize = 20.0;
const _kSelectTypeBarHeight = 30.0;
const _kSelectTypeBarWidth = 45.0;
const _kBarAnimation = 700.0;
const _kContentPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);
const _kContentMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
const _kChartAreaMargin = EdgeInsets.only(top: 56.0, right: 28.0, left: 28.0);
const _kChartMargin = EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0);
const _kSelectTypeBarPadding =
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0);

const _kHeaderTitle = "タスク数推移";
const _kProgressTitle = "進行中タスク";
const _kOverDueTitle = "期限切れタスク";
const _kCompletedTitle = "完了タスク";

final _logger = stairsLogger(name: 'task_status_chart');

class TaskStatusChart extends ConsumerStatefulWidget {
  const TaskStatusChart({
    super.key,
    this.y1Color,
    this.y2Color,
    this.y3Color,
    this.isHorizontal = false,
    required this.taskStatusModelList,
  });

  final Color? y1Color;
  final Color? y2Color;
  final Color? y3Color;
  final bool isHorizontal;
  final List<TaskStatusModel> taskStatusModelList;
  @override
  ConsumerState<TaskStatusChart> createState() => _TaskStatusChartState();
}

class _TaskStatusChartState extends ConsumerState<TaskStatusChart> {
  TaskChartType selectedDisplayType = TaskChartType.weekly;
  bool isDisabledPrevious = true;
  bool isDisabledNext = true;

  @override
  void initState() {
    super.initState();
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
    final taskStatusChartState = ref.watch(taskStatusChartProvider(
        displayedColumnCount: _kDisplayedColumnCount,
        taskStatusModelList: widget.taskStatusModelList));

    final taskStatusChartNotifier = ref.watch(taskStatusChartProvider(
            displayedColumnCount: _kDisplayedColumnCount,
            taskStatusModelList: widget.taskStatusModelList)
        .notifier);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: _kContentPadding,
      margin: _kContentMargin,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            margin: _kChartAreaMargin,
            child: PageView(
              controller: taskStatusChartState.pageController,
              onPageChanged: (index) => _onPageChanged(
                  index: index,
                  taskListLength: taskStatusChartState.taskStatusList.length),
              children: [
                // タスク数推移チャート
                for (int i = 0;
                    i <
                        taskStatusChartState.taskStatusList.length /
                            _kDisplayedColumnCount.ceil();
                    i++) ...[
                  _TaskBarChart(
                    title: _getFixedWeeklyTitle(
                      firstDate: taskStatusChartState
                          .taskStatusList[i * _kDisplayedColumnCount].firstDate,
                      lastDate: taskStatusChartState
                          .taskStatusList[taskStatusChartState
                                      .taskStatusList.length <=
                                  (i + 1) * _kDisplayedColumnCount
                              ? taskStatusChartState.taskStatusList.length - 1
                              : (i + 1) * _kDisplayedColumnCount - 1]
                          .lastDate,
                    ),
                    y1Color: widget.y1Color ?? theme.colorProgress,
                    y2Color: widget.y2Color ?? theme.colorDangerBgDefault,
                    y3Color: widget.y3Color ?? theme.colorPrimary,
                    y1LegendName: _kProgressTitle,
                    y2LegendName: _kOverDueTitle,
                    y3LegendName: _kCompletedTitle,
                    isHorizontal: widget.isHorizontal,
                    chartData: taskStatusChartState.taskStatusList.sublist(
                        i * _kDisplayedColumnCount,
                        taskStatusChartState.taskStatusList.length <
                                (i + 1) * _kDisplayedColumnCount
                            ? taskStatusChartState.taskStatusList.length
                            : (i + 1) * _kDisplayedColumnCount),
                  ),
                ],
              ],
            ),
          ),
          // ヘッダー
          Align(
            alignment: const Alignment(0, -1),
            child: StatusHeader(
              title: _kHeaderTitle,
              trailWidget: _SelectTypeBar(
                selectedType: selectedDisplayType,
                onTap: (type) {
                  taskStatusChartNotifier.setItem(
                      type: type, displayedColumnCount: _kDisplayedColumnCount);
                  setState(
                    () {
                      selectedDisplayType = type;
                    },
                  );
                },
              ),
            ),
          ),
          // ページインジケーター
          Align(
            alignment: const Alignment(0, 0.1),
            child: _PageIndicator(
              isDisabledPrevious: isDisabledPrevious,
              isDisabledNext: isDisabledNext,
              onMovePrevious: () {
                if (taskStatusChartState.pageController.page! == 0) return;
                taskStatusChartState.pageController.animateToPage(
                  taskStatusChartState.pageController.page!.toInt() - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onMoveNext: () {
                if (taskStatusChartState.pageController.page! ==
                    (taskStatusChartState.taskStatusList.length /
                                _kDisplayedColumnCount)
                            .ceil() -
                        1) {
                  return;
                }
                taskStatusChartState.pageController.animateToPage(
                  taskStatusChartState.pageController.page!.toInt() + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onPageChanged({required int index, required int taskListLength}) {
    setState(
      () {
        isDisabledPrevious = index == 0;
        isDisabledNext =
            (taskListLength / _kDisplayedColumnCount).ceil() - 1 == 0 ||
                index == (taskListLength / _kDisplayedColumnCount).ceil() - 1;
      },
    );
  }
}

// 棒チャート
class _TaskBarChart extends StatelessWidget {
  const _TaskBarChart({
    this.title,
    this.y1Color,
    this.y2Color,
    this.y3Color,
    required this.y1LegendName,
    this.y2LegendName,
    this.y3LegendName,
    required this.isHorizontal,
    required this.chartData,
  });

  final String? title;
  final Color? y1Color;
  final Color? y2Color;
  final Color? y3Color;
  final String y1LegendName;
  final String? y2LegendName;
  final String? y3LegendName;
  final bool isHorizontal;
  final List<TaskBarData> chartData;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return SfCartesianChart(
      isTransposed: isHorizontal,
      // タイトル
      title: title != null
          ? ChartTitle(text: title!, textStyle: theme.textStyleBody)
          : const ChartTitle(),
      margin: _kChartMargin,
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        interval: 1,
        labelFormat: '{value}件',
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<TaskBarData, String>>[
        StackedBarSeries<TaskBarData, String>(
          name: y1LegendName,
          dataSource: chartData,
          xValueMapper: (TaskBarData data, _) => data.x,
          yValueMapper: (TaskBarData data, _) => data.y1,
          width: 0.3,
          color: y1Color ?? theme.colorProgress,
          animationDuration: _kBarAnimation,
        ),
        StackedBarSeries<TaskBarData, String>(
          name: y2LegendName,
          dataSource: chartData,
          xValueMapper: (TaskBarData data, _) => data.x,
          yValueMapper: (TaskBarData data, _) => data.y2,
          width: 0.3,
          color: y2Color ?? theme.colorDangerBgDefault,
          animationDuration: _kBarAnimation,
        ),
        StackedBarSeries<TaskBarData, String>(
          name: y3LegendName,
          dataSource: chartData,
          xValueMapper: (TaskBarData data, _) => data.x,
          yValueMapper: (TaskBarData data, _) => data.y3,
          width: 0.3,
          color: y3Color ?? theme.colorPrimary,
          animationDuration: _kBarAnimation,
        ),
      ],
    );
  }
}

// チャート ページ遷移操作
class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    this.isDisabledPrevious = false,
    this.isDisabledNext = false,
    required this.onMovePrevious,
    required this.onMoveNext,
  });

  final bool isDisabledPrevious;
  final bool isDisabledNext;
  final VoidCallback onMovePrevious;
  final VoidCallback onMoveNext;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AbsorbPointer(
          absorbing: isDisabledPrevious,
          child: IconButton(
            iconSize: _kPageTransitionIconSize,
            onPressed: () => onMovePrevious(),
            icon: Icon(
              Icons.skip_previous,
              size: _kPageTransitionIconSize,
              color: isDisabledPrevious
                  ? theme.colorDisabled
                  : theme.colorFgDefault.withOpacity(0.7),
            ),
          ),
        ),
        AbsorbPointer(
          absorbing: isDisabledNext,
          child: IconButton(
            iconSize: _kPageTransitionIconSize,
            onPressed: () => onMoveNext(),
            icon: Icon(
              Icons.skip_next,
              size: _kPageTransitionIconSize,
              color: isDisabledNext
                  ? theme.colorDisabled
                  : theme.colorFgDefault.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}

// 表示タイプ選択エリア
class _SelectTypeBar extends StatelessWidget {
  const _SelectTypeBar({
    required this.selectedType,
    required this.onTap,
  });

  final TaskChartType selectedType;
  final Function(TaskChartType) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = LoomTheme.of(context);
    return ToggleButtons(
      constraints: const BoxConstraints(
          maxHeight: _kSelectTypeBarHeight, minWidth: _kSelectTypeBarWidth),
      borderRadius: BorderRadius.circular(5.0),
      fillColor: theme.colorPrimary,
      isSelected:
          TaskChartType.values.map((type) => type == selectedType).toList(),
      onPressed: (index) => onTap(TaskChartType.values[index]),
      children: [
        for (final item in TaskChartType.values) ...[
          Padding(
            padding: _kSelectTypeBarPadding,
            child: Text(
              item.typeValue,
              style: theme.textStyleFootnote.copyWith(
                color: item == selectedType
                    ? theme.colorBgLayer1
                    : theme.colorFgDefault,
              ),
            ),
          )
        ]
      ],
    );
  }
}

// xxxx/xx/xx ~ xxxxx/xx/xx形式に変換
String _getFixedWeeklyTitle(
    {required DateTime firstDate, required DateTime lastDate}) {
  return '${getFormattedDate(firstDate)}~${getFormattedDate(lastDate)}';
}
