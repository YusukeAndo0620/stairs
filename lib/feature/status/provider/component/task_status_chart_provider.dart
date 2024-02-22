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
    required this.pageController,
    required this.taskInitialDate,
    required this.taskStatusList,
    required this.progressCountMap,
    required this.overDueDateCountMap,
    required this.completedCountMap,
  });

  @override
  List<Object?> get props => [
        chartType,
        pageController,
        taskInitialDate,
        taskStatusList,
        progressCountMap,
        overDueDateCountMap,
        completedCountMap,
      ];

  // 表示形式
  final TaskChartType chartType;
  // ページコントローラー
  final PageController pageController;
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
    PageController? pageController,
    DateTime? taskInitialDate,
    List<TaskBarData>? taskStatusList,
    Map<DateTime, int>? progressCountMap,
    Map<DateTime, int>? overDueDateCountMap,
    Map<DateTime, int>? completedCountMap,
  }) =>
      TaskStatusChartState(
        chartType: chartType ?? this.chartType,
        pageController: pageController ?? this.pageController,
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
      {required int displayedColumnCount,
      required List<TaskStatusModel> taskStatusModelList}) {
    final copyList = [...taskStatusModelList];
    if (copyList.isEmpty) {
      return TaskStatusChartState(
        chartType: TaskChartType.weekly,
        taskInitialDate: DateTime.now(),
        taskStatusList: const [],
        pageController: PageController(initialPage: 0),
        progressCountMap: const {},
        overDueDateCountMap: const {},
        completedCountMap: const {},
      );
    }
    // タスク登録日時でソート
    copyList.sort((a, b) => a.startDate.compareTo(b.startDate));
    // タスクの中で最も古い日付
    final initialDate = copyList.first.startDate;
    // チャートx軸の開始基準の日付
    final criteriaDay = getWeeklyInitialDate(date: initialDate);
    final minusDays = (((getWeeklyInitialDate(date: DateTime.now())
                        .difference(criteriaDay)
                        .inDays) /
                    7 %
                    displayedColumnCount)
                .ceil() +
            1) *
        7;

    // 週ごとのタスク状況を取得
    final dateMapList = getDateMapList(
        criteriaDay: criteriaDay.add(Duration(days: -minusDays)),
        latestDate: DateTime.now(),
        taskStatusModelList: copyList,
        displayedColumnCount: displayedColumnCount);

    final list = getWeeklyList(
      criteriaDay: criteriaDay.add(Duration(days: -minusDays)),
      latestDate: DateTime.now(),
      displayedColumnCount: displayedColumnCount,
      progressCountMap: dateMapList[0],
      overDueDateCountMap: dateMapList[1],
      completedCountMap: dateMapList[2],
    );

    final displayedPageNo = (list.length / displayedColumnCount).ceil() - 1;

    return TaskStatusChartState(
      chartType: TaskChartType.weekly,
      pageController: PageController(
        initialPage: displayedPageNo < 0 ? 0 : displayedPageNo,
      ),
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
      pageController: PageController(initialPage: 0),
      taskInitialDate: DateTime.now(),
      taskStatusList: const [],
      progressCountMap: const {},
      overDueDateCountMap: const {},
      completedCountMap: const {},
    );
  }

  void setItem({
    required TaskChartType type,
    required int displayedColumnCount,
  }) {
    final list = _getTaskList(
      type: type,
      displayedColumnCount: displayedColumnCount,
    );

    // 表示するページ番号。一番最後のページを表示
    final displayedPageNo = (list.length / displayedColumnCount).ceil() - 1;

    state = state.copyWith(
      chartType: type,
      taskStatusList: [...list],
    );

    state.pageController.animateToPage(
      displayedPageNo < 0 ? 0 : displayedPageNo,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  /// 週単位、月単位でタスクリストを取得
  List<TaskBarData> _getTaskList({
    required TaskChartType type,
    required int displayedColumnCount,
  }) {
    // タスクの中で最も古い日付
    final initialDate = state.taskInitialDate;

    switch (type) {
      case TaskChartType.weekly:
        // チャートx軸の開始基準の日付
        final criteriaDay = getWeeklyInitialDate(date: initialDate);
        // 1画面あたりに表示する個数は4, 4, 2などリスト数に依存するので、常に同じにするため
        // 足りない個数分、criteriaDayより過去日から始めるように調整し、どの画面も常に4つのデータが表示されるようにする
        final minusDays = (((getWeeklyInitialDate(date: DateTime.now())
                            .difference(criteriaDay)
                            .inDays) /
                        7 %
                        displayedColumnCount)
                    .ceil() +
                1) *
            7;

        return getWeeklyList(
          criteriaDay: criteriaDay.add(Duration(days: -minusDays)),
          latestDate: DateTime.now(),
          displayedColumnCount: displayedColumnCount,
          progressCountMap: state.progressCountMap,
          overDueDateCountMap: state.overDueDateCountMap,
          completedCountMap: state.completedCountMap,
        );
      case TaskChartType.monthly:
        // チャートx軸の開始基準の日付
        final criteriaDay = DateTime(initialDate.year, initialDate.month);
        final minusDays = ((DateTime(DateTime.now().year, DateTime.now().month)
                        .difference(criteriaDay)
                        .inDays) /
                    30 %
                    displayedColumnCount)
                .ceil() *
            30;
        return getMonthlyList(
          criteriaDay: criteriaDay.add(Duration(days: -minusDays)),
          latestDate: DateTime.now(),
          displayedColumnCount: displayedColumnCount,
          progressCountMap: state.progressCountMap,
          overDueDateCountMap: state.overDueDateCountMap,
          completedCountMap: state.completedCountMap,
        );
      case TaskChartType.threeMonth:
        // チャートx軸の開始基準の日付
        final criteriaDay = DateTime(initialDate.year, initialDate.month);
        final minusDays = ((DateTime(DateTime.now().year, DateTime.now().month)
                        .difference(criteriaDay)
                        .inDays) /
                    90 %
                    displayedColumnCount)
                .ceil() *
            90;
        return getThreeMonthlyList(
          criteriaDay: criteriaDay.add(Duration(days: -minusDays)),
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
    required int displayedColumnCount,
    required Map<DateTime, int> progressCountMap,
    required Map<DateTime, int> overDueDateCountMap,
    required Map<DateTime, int> completedCountMap,
  }) {
    // 返却用のリスト
    final List<TaskBarData> targetList = [];

    // x軸の個数(データ数)
    final xAxisCount =
        ((latestDate.difference(criteriaDay).inDays) / 7).ceil() <
                displayedColumnCount
            ? displayedColumnCount
            : ((latestDate.difference(criteriaDay).inDays) / 7).ceil();

    for (int i = 0; i < xAxisCount; i++) {
      // 週ごとの進行中、期限切れ、完了しているタスクを分類するための週初めの日付
      DateTime weekDay = DateTime(
          criteriaDay.year, criteriaDay.month, criteriaDay.day + (i * 7));

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
    required int displayedColumnCount,
    required Map<DateTime, int> progressCountMap,
    required Map<DateTime, int> overDueDateCountMap,
    required Map<DateTime, int> completedCountMap,
  }) {
    // 返却用のリスト
    final List<TaskBarData> targetList = [];

    // x軸の個数(データ数)
    final xAxisCount =
        ((latestDate.difference(criteriaDay).inDays) / 30).ceil() <
                displayedColumnCount
            ? displayedColumnCount
            : ((latestDate.difference(criteriaDay).inDays) / 30).ceil();

    for (int i = 0; i < xAxisCount; i++) {
      // 1ヶ月ごとの進行中、期限切れ、完了しているタスクを分類するための週初めの日付
      DateTime monthDay = DateTime(
        criteriaDay.year,
        criteriaDay.month + (i),
      );

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

    // x軸の個数(データ数)
    final xAxisCount =
        ((latestDate.difference(criteriaDay).inDays) / 90).ceil();

    for (int i = 0; i < xAxisCount; i++) {
      // 3ヶ月ごとの進行中、期限切れ、完了しているタスクを分類するための週初めの日付
      DateTime threeMonthDay = DateTime(
        criteriaDay.year,
        criteriaDay.month + (i * 3),
      );

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
    required int displayedColumnCount,
  }) {
    // 進行中タスク key: 週初めの曜日, value: タスク数
    Map<DateTime, int> progressCountMap = {};
    // 期限切れタスク key: 週初めの曜日, value: タスク数
    Map<DateTime, int> overDueDateCountMap = {};
    //完了タスク key: 週初めの曜日, value: タスク数
    Map<DateTime, int> completedCountMap = {};

    // 返却用のリスト
    final List<Map<DateTime, int>> targetMapList = [];

    // x軸の個数(データ数)
    final xAxisCount = ((latestDate.difference(criteriaDay).inDays) / 7).ceil();

    for (int i = 0; i < xAxisCount; i++) {
      // 週ごとの進行中、期限切れ、完了しているタスクを分類するための週初めの日付
      DateTime weekDay = DateTime(
          criteriaDay.year, criteriaDay.month, criteriaDay.day + (i * 7));

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
          // 完了しているが、対象の週では期限切れとなっていたタスク
        } else if (isDateBetweenRange(
                start: weekDay, end: thisWeekend, target: task.dueDate) &&
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

// xxxx/xx/xx ~ xxxxx/xx/xx形式で取得
  String _getFormattedWeeklyVal({required DateTime date}) {
    return '${getFormattedMonthDate(date)} \n ~ \n ${getFormattedMonthDate(
      date.add(
        const Duration(days: 6),
      ),
    )}';
  }
}
