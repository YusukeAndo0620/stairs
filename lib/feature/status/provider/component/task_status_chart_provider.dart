import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/feature/status/enum/task_chart_type.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

part 'task_status_chart_provider.g.dart';

final _logger = stairsLogger(name: 'task_status_chart_provider');

class TaskBarData {
  TaskBarData({
    required this.x,
    required this.firstDate,
    required this.lastDate,
    required this.y1,
    required this.y2,
    required this.y3,
  });

  final String x;
  final DateTime firstDate;
  final DateTime lastDate;
  final double y1;
  final double y2;
  final double y3;
}

class TaskStatusChartState extends Equatable {
  const TaskStatusChartState({
    this.chartType = TaskChartType.weekly,
    required this.taskInitialDate,
    required this.taskStatusList,
    required this.progressCountMap,
    required this.overDueDateCountMap,
    required this.completedCountMap,
  });

  @override
  List<Object?> get props => [
        chartType,
        taskInitialDate,
        taskStatusList,
        progressCountMap,
        overDueDateCountMap,
        completedCountMap,
      ];

  // 表示形式
  final TaskChartType chartType;
  // タスクの中で最も登録日が古い日付
  final DateTime taskInitialDate;
  // タスクリスト
  final List<TaskBarData> taskStatusList;
  // 進行中タスク key: 週初めの日付, value: タスク数
  final Map<DateTime, int> progressCountMap;
  // 期限切れタスク key: 週初めの日付, value: タスク数
  final Map<DateTime, int> overDueDateCountMap;
  //完了タスク key: 週初めの日付, value: タスク数
  final Map<DateTime, int> completedCountMap;

  TaskStatusChartState copyWith({
    TaskChartType? chartType,
    DateTime? taskInitialDate,
    List<TaskBarData>? taskStatusList,
    Map<DateTime, int>? progressCountMap,
    Map<DateTime, int>? overDueDateCountMap,
    Map<DateTime, int>? completedCountMap,
  }) =>
      TaskStatusChartState(
        chartType: chartType ?? this.chartType,
        taskInitialDate: taskInitialDate ?? this.taskInitialDate,
        progressCountMap: progressCountMap ?? this.progressCountMap,
        taskStatusList: taskStatusList ?? this.taskStatusList,
        overDueDateCountMap: overDueDateCountMap ?? this.overDueDateCountMap,
        completedCountMap: completedCountMap ?? this.completedCountMap,
      );
}

@riverpod
class TaskStatusChart extends _$TaskStatusChart {
  @override
  TaskStatusChartState build(
      {required List<TaskStatusModel> taskStatusModelList}) {
    final copyList = [...taskStatusModelList];
    // タスク登録日時でソート
    copyList.sort((a, b) => a.startDate.compareTo(b.startDate));
    // タスクの中で最も古い日付
    final initialDate =
        copyList.isNotEmpty ? copyList.first.startDate : DateTime.now();
    // チャートx軸の開始基準の日付
    final criteriaDay = getWeeklyInitialDate(date: initialDate);

    // 週ごとのタスク状況を取得
    final dateMapList = getDateMapList(
      criteriaDay: criteriaDay,
      latestDate: DateTime.now(),
      taskStatusModelList: copyList,
    );

    final list = getWeeklyList(
      criteriaDay: criteriaDay,
      latestDate: DateTime.now(),
      progressCountMap: dateMapList[0],
      overDueDateCountMap: dateMapList[1],
      completedCountMap: dateMapList[2],
    );

    return TaskStatusChartState(
      chartType: TaskChartType.weekly,
      taskInitialDate: initialDate,
      taskStatusList: list,
      progressCountMap: dateMapList[0],
      overDueDateCountMap: dateMapList[1],
      completedCountMap: dateMapList[2],
    );
  }

  void init() {
    state = TaskStatusChartState(
      chartType: TaskChartType.weekly,
      taskInitialDate: DateTime.now(),
      taskStatusList: const [],
      progressCountMap: const {},
      overDueDateCountMap: const {},
      completedCountMap: const {},
    );
  }

  void setItem({
    required TaskChartType type,
  }) {
    final list = _getTaskList(
      type: type,
    );
    state = state.copyWith(
      chartType: type,
      taskStatusList: [...list],
    );
  }

  /// 週単位、月単位でタスクリストを取得
  List<TaskBarData> _getTaskList({
    required TaskChartType type,
  }) {
    // タスクの中で最も古い日付
    final initialDate = state.taskInitialDate;

    switch (type) {
      case TaskChartType.weekly:
        // チャートx軸の開始基準の日付
        final criteriaDay = getWeeklyInitialDate(date: initialDate);

        return getWeeklyList(
          criteriaDay: criteriaDay,
          latestDate: DateTime.now(),
          progressCountMap: state.progressCountMap,
          overDueDateCountMap: state.overDueDateCountMap,
          completedCountMap: state.completedCountMap,
        );
      case TaskChartType.monthly:
        // チャートx軸の開始基準の日付
        final criteriaDay = DateTime(initialDate.year, initialDate.month);

        return getMonthlyList(
          criteriaDay: criteriaDay,
          latestDate: DateTime.now(),
          progressCountMap: state.progressCountMap,
          overDueDateCountMap: state.overDueDateCountMap,
          completedCountMap: state.completedCountMap,
        );
      case TaskChartType.threeMonth:
        // チャートx軸の開始基準の日付
        final criteriaDay = DateTime(initialDate.year, initialDate.month);

        return getThreeMonthlyList(
          criteriaDay: criteriaDay,
          latestDate: DateTime.now(),
          progressCountMap: state.progressCountMap,
          overDueDateCountMap: state.overDueDateCountMap,
          completedCountMap: state.completedCountMap,
        );
      default:
        return [];
    }
  }

  /// 週単位でタスクの進捗状況のリストを取得
  List<TaskBarData> getWeeklyList({
    required DateTime criteriaDay,
    required DateTime latestDate,
    required Map<DateTime, int> progressCountMap,
    required Map<DateTime, int> overDueDateCountMap,
    required Map<DateTime, int> completedCountMap,
  }) {
    // 返却用のリスト
    final List<TaskBarData> targetList = [];

    // 1週間ごと
    for (DateTime weekDay = criteriaDay;
        weekDay.isBefore(latestDate);
        weekDay = weekDay.add(const Duration(days: 7))) {
      // 今週末
      final thisWeekend =
          weekDay.add(const Duration(days: 6, hours: 23, minutes: 59));

      // 進行中、期限切れ、完了タスクを１つの棒データにセット
      targetList.add(
        TaskBarData(
          x: getFormattedMonthDate(weekDay),
          firstDate: weekDay,
          lastDate: thisWeekend,
          y1: _getTotalTaskCountWithTargetDate(
                  dateMap: progressCountMap, targetDate: thisWeekend)
              .toDouble(),
          y2: _getTotalTaskCountWithTargetDate(
                  dateMap: overDueDateCountMap, targetDate: thisWeekend)
              .toDouble(),
          y3: _getTotalTaskCountWithTargetDate(
                  dateMap: completedCountMap, targetDate: thisWeekend)
              .toDouble(),
        ),
      );
    }
    return targetList;
  }

  /// 1ヶ月単位でタスクの進捗状況のリストを取得
  List<TaskBarData> getMonthlyList({
    required DateTime criteriaDay,
    required DateTime latestDate,
    required Map<DateTime, int> progressCountMap,
    required Map<DateTime, int> overDueDateCountMap,
    required Map<DateTime, int> completedCountMap,
  }) {
    // 返却用のリスト
    final List<TaskBarData> targetList = [];

    // 1ヶ月ごと
    for (DateTime monthDay = DateTime(criteriaDay.year, criteriaDay.month);
        monthDay.isBefore(latestDate);
        monthDay = monthDay.add(Duration(
            days: DateTime(monthDay.year, monthDay.month + 1)
                .difference(monthDay)
                .inDays))) {
      // 今月末
      final thisMonthEnd = DateTime(monthDay.year, monthDay.month + 1)
          .add(const Duration(days: -1, hours: 23, minutes: 59));

      // 進行中、期限切れ、完了タスクを１つの棒データにセット
      targetList.add(
        TaskBarData(
          x: getFormattedYearMonthDate(monthDay),
          firstDate: monthDay,
          lastDate: thisMonthEnd,
          y1: _getTotalTaskCountWithTargetDate(
                  dateMap: progressCountMap, targetDate: thisMonthEnd)
              .toDouble(),
          y2: _getTotalTaskCountWithTargetDate(
                  dateMap: overDueDateCountMap, targetDate: thisMonthEnd)
              .toDouble(),
          y3: _getTotalTaskCountWithTargetDate(
                  dateMap: completedCountMap, targetDate: thisMonthEnd)
              .toDouble(),
        ),
      );
    }
    return targetList;
  }

  /// 3ヶ月単位でタスクの進捗状況のリストを取得
  List<TaskBarData> getThreeMonthlyList({
    required DateTime criteriaDay,
    required DateTime latestDate,
    required Map<DateTime, int> progressCountMap,
    required Map<DateTime, int> overDueDateCountMap,
    required Map<DateTime, int> completedCountMap,
  }) {
    // 返却用のリスト
    final List<TaskBarData> targetList = [];

    // 3ヶ月ごと
    for (DateTime threeMonthDay = DateTime(criteriaDay.year, criteriaDay.month);
        threeMonthDay.isBefore(latestDate);
        threeMonthDay = threeMonthDay.add(Duration(
            days: DateTime(threeMonthDay.year, threeMonthDay.month + 3)
                .difference(threeMonthDay)
                .inDays))) {
      // 3ヶ月後の月末
      final thisMonthEnd = DateTime(threeMonthDay.year, threeMonthDay.month + 3)
          .add(const Duration(days: -1, hours: 23, minutes: 59));

      // 進行中、期限切れ、完了タスクを１つの棒データにセット
      targetList.add(
        TaskBarData(
          x: getFormattedYearMonthDate(threeMonthDay),
          firstDate: threeMonthDay,
          lastDate: thisMonthEnd,
          y1: _getTotalTaskCountWithTargetDate(
                  dateMap: progressCountMap, targetDate: thisMonthEnd)
              .toDouble(),
          y2: _getTotalTaskCountWithTargetDate(
                  dateMap: overDueDateCountMap, targetDate: thisMonthEnd)
              .toDouble(),
          y3: _getTotalTaskCountWithTargetDate(
                  dateMap: completedCountMap, targetDate: thisMonthEnd)
              .toDouble(),
        ),
      );
    }
    return targetList;
  }

  // 進行中、期限切れ、完了タスクを日付をキーにタスク数をマッピング
  // 以下Mapは該当週における変動したタスク数を設定
  // ex) 2024-01-01 進行: +3,         期限切れ: 0, 完了: 0（進行中は３つとなる）
  // ex) 2024-01-08 進行: -2,         期限切れ: +1, 完了: +1（2つの既存タスクが期限切れ、完了となり、進行中は1つとなる）
  // ex) 2024-01-15 進行: +1, (+2 -1) 期限切れ: +1, 完了: 0（新規で２つ追加され、既存進行タスクが期限切れ）
  // → 進行中: 2, 期限切れ: 2, 完了: 1, の計5つのタスクが登録されている
  List<Map<DateTime, int>> getDateMapList({
    required DateTime criteriaDay,
    required DateTime latestDate,
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    // 進行中タスク key: 週初めの曜日, value: タスク数
    Map<DateTime, int> progressCountMap = {};
    // 期限切れタスク key: 週初めの曜日, value: タスク数
    Map<DateTime, int> overDueDateCountMap = {};
    //完了タスク key: 週初めの曜日, value: タスク数
    Map<DateTime, int> completedCountMap = {};

    // 返却用のリスト
    final List<Map<DateTime, int>> targetMapList = [];

    // 1週間ごと
    for (DateTime weekDay = criteriaDay;
        weekDay.isBefore(latestDate);
        weekDay = weekDay.add(const Duration(days: 7))) {
      // 今週末
      final thisWeekend =
          weekDay.add(const Duration(days: 6, hours: 23, minutes: 59));

      // 対象日付ごとのタスク進捗状況を確認し、タスク数を設定
      for (final task in taskStatusModelList) {
        // 1. 完了タスク
        // 前週では完了しておらず、該当週で完了している場合に算出
        if (task.doneDate != null &&
            isDateBetweenRange(
                start: weekDay, end: thisWeekend, target: task.doneDate!)) {
          // 1.1 完了タスク追加
          completedCountMap.containsKey(weekDay)
              ? completedCountMap[weekDay] = completedCountMap[weekDay]! + 1
              : completedCountMap[weekDay] = 1;

          // 1.2 期限切れタスクを減らす
          // 前週以前から期限切れタスク、となっていて、期限を超えてタスクが完了した場合、期限切れタスクを減らす
          // 同一週に「今週に期限切れ→今週に完了」になった場合は減らさない
          if (task.dueDate.isBefore(weekDay) &&
              task.doneDate!.isAfter(task.dueDate)) {
            overDueDateCountMap.containsKey(weekDay)
                ? overDueDateCountMap[weekDay] =
                    overDueDateCountMap[weekDay]! - 1
                : overDueDateCountMap[weekDay] = -1;
          }
          // 1.3 進行中タスクを減らす
          // 前週以前から進行中タスクとなっていて、期限前にタスクが完了した場合、進行中タスクを減らす
          // 前週以前から進行中タスクとなっていて、概要週に期日があり、該当週で完了した場合、進行中タスクを減らす
          // 同一週に[「今週にタスク追加→今週完了」になった場合は減らさない
          else if (task.startDate.isBefore(weekDay) &&
              (task.dueDate.isBefore(weekDay) ||
                  isDateBetweenRange(
                      start: weekDay,
                      end: thisWeekend,
                      target: task.dueDate))) {
            progressCountMap.containsKey(weekDay)
                ? progressCountMap[weekDay] = progressCountMap[weekDay]! - 1
                : progressCountMap[weekDay] = -1;
          }

          // 2. 期限切れタスク
          // 2.1 前週では期限切れになっておらず、まだ完了していないタスクのケース
          // ・期日が今週~来週の月曜日の間にある
          // ・期日が現在日時を越えている
          // ・まだ完了していない、または完了しているが、対象の週では期限切れとなっていたタスク
        } else if (isDateBetweenRange(
                start: weekDay, end: thisWeekend, target: task.dueDate) &&
            task.dueDate.isBefore(DateTime.now()) &&
            (task.doneDate == null ||
                (task.doneDate != null &&
                    task.doneDate!.isAfter(task.dueDate)))) {
          overDueDateCountMap.containsKey(weekDay)
              ? overDueDateCountMap[weekDay] = overDueDateCountMap[weekDay]! + 1
              : overDueDateCountMap[weekDay] = 1;

          // 2.2 進行中タスクを減らす
          // 同一週に[「進行中→期限切れ」になった場合は減らさない
          if (weekDay.isAfter(task.startDate)) {
            progressCountMap.containsKey(weekDay)
                ? progressCountMap[weekDay] = progressCountMap[weekDay]! - 1
                : progressCountMap[weekDay] = -1;
          }

          // 3. 進行中タスク
        } else {
          // 3.1 前週で進行中タスクがない場合は追加する（該当週で追加されたと判定）
          if (isDateBetweenRange(
              start: weekDay, end: thisWeekend, target: task.startDate)) {
            progressCountMap.containsKey(weekDay)
                ? progressCountMap[weekDay] = progressCountMap[weekDay]! + 1
                : progressCountMap[weekDay] = 1;
          }
        }
      }
    }
    targetMapList.add(progressCountMap);
    targetMapList.add(overDueDateCountMap);
    targetMapList.add(completedCountMap);
    return targetMapList;
  }

  // 対象日付より過去日のタスク数を取得
  int _getTotalTaskCountWithTargetDate(
      {required Map<DateTime, int> dateMap, required DateTime targetDate}) {
    int count = 0;
    // 対象日付の12:00に設定
    final date =
        DateTime(targetDate.year, targetDate.month, targetDate.day, 12);
    for (final item in dateMap.keys) {
      // mapの日付 <= 対象日付の場合、タスク数を取得
      if (date.isAfter(item)) {
        count += dateMap[item] ?? 0;
      }
    }
    return count;
  }
}
