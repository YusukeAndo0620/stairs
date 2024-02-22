import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

part 'task_workload_line_provider.g.dart';

// 1日8時間労働
const _kWorkHour = 8;
// 9:00始業とする
const _kWorkStartHourTime = 9;

final _logger = stairsLogger(name: 'task_workload_line_provider');

class TaskWorkloadLineData {
  TaskWorkloadLineData({
    required this.date,
    required this.workloadPercent,
  });

  final DateTime date;
  final double workloadPercent;
}

@riverpod
class TaskWorkloadLine extends _$TaskWorkloadLine {
  @override
  List<TaskWorkloadLineData> build({
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    if (taskStatusModelList.isEmpty) {
      return [];
    }
    return _getTaskWorkloadProgressList(
        taskStatusModelList: taskStatusModelList);
  }

  void init() {
    state = [];
  }

  /// 全期間分の工数推移を取得
  /// 週ごとに取得
  List<TaskWorkloadLineData> _getTaskWorkloadProgressList({
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    final copyList = [...taskStatusModelList];
    // タスク登録日時でソード
    copyList.sort((a, b) => a.startDate.compareTo(b.startDate));
    // タスクの中で最も古い日付
    final initialDate = copyList.first.startDate;
    // チャートx軸の開始基準の日付
    final criteriaDay = getWeeklyInitialDate(date: initialDate);

    // 工数Map key: 週初めの曜日, value: 工数短縮率
    Map<DateTime, double> workloadMap = {};

    // x軸の個数(データ数)
    final xAxisCount =
        ((DateTime.now().difference(criteriaDay).inDays) / 7).ceil();

    for (int i = 0; i < xAxisCount; i++) {
      // 週初め
      DateTime weekDay = DateTime(
          criteriaDay.year, criteriaDay.month, criteriaDay.day + (i * 7));

      // 対象週の末日
      final thisWeekend =
          weekDay.add(const Duration(days: 6, hours: 23, minutes: 59));

      for (final task in taskStatusModelList) {
        if (isDateBetweenRange(
            start: weekDay, end: thisWeekend, target: task.startDate)) {
          // 期日を元に取得
          final workloadHour = getWeekdaysDifferenceInHours(
            startDate: task.startDate,
            endDate: task.dueDate,
            startHour: _kWorkStartHourTime,
            addingHour: _kWorkHour,
          );
          // 完了日を元に取得。完了していない場合は現在時刻。
          final actualWorkloadHour = getWeekdaysDifferenceInHours(
            startDate: task.startDate,
            endDate: task.doneDate ?? DateTime.now(),
            startHour: _kWorkStartHourTime,
            addingHour: _kWorkHour,
          );
          final reducingPercent = 100 - actualWorkloadHour / workloadHour * 100;
          workloadMap.containsKey(weekDay)
              ? workloadMap[weekDay] =
                  (workloadMap[weekDay]! + reducingPercent) / 2
              : workloadMap[weekDay] = reducingPercent;
        }
      }
    }
    // 返却用リスト
    List<TaskWorkloadLineData> targetList = [];
    for (final item in workloadMap.entries) {
      targetList.add(
        TaskWorkloadLineData(
          date: item.key,
          workloadPercent: double.parse(
            item.value.toStringAsFixed(2),
          ),
        ),
      );
    }
    return targetList;
  }
}
