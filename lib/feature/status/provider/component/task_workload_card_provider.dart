import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stairs/feature/status/enum/workload_type.dart';
import 'package:stairs/feature/status/model/task_status_model.dart';
import 'package:stairs/loom/loom_package.dart';

part 'task_workload_card_provider.g.dart';

// 1日8時間労働
const _kWorkHour = 8;
// 9:00始業とする
const _kWorkStartHourTime = 9;

final _logger = stairsLogger(name: 'task_workload_card_provider');

final _initialState = TaskWorkloadCardState(
  weekLyWorkload: Workload(
    firstDate: DateTime.now(),
    lastDate: DateTime.now(),
    totalWorkloadHour: 0,
    actualWorkloadHour: 0,
    workloadPercent: 0.0,
  ),
  monthlyWorkload: Workload(
    firstDate: DateTime.now(),
    lastDate: DateTime.now(),
    totalWorkloadHour: 0,
    actualWorkloadHour: 0,
    workloadPercent: 0.0,
  ),
  totalWorkload: Workload(
    firstDate: DateTime.now(),
    lastDate: DateTime.now(),
    totalWorkloadHour: 0,
    actualWorkloadHour: 0,
    workloadPercent: 0.0,
  ),
);

class Workload {
  Workload({
    this.firstDate,
    this.lastDate,
    required this.totalWorkloadHour,
    required this.actualWorkloadHour,
    required this.workloadPercent,
  });

  final DateTime? firstDate;
  final DateTime? lastDate;
  final double totalWorkloadHour;
  final double actualWorkloadHour;
  final double workloadPercent;
}

class TaskWorkloadCardState extends Equatable {
  const TaskWorkloadCardState({
    required this.weekLyWorkload,
    required this.monthlyWorkload,
    required this.totalWorkload,
  });

  @override
  List<Object?> get props => [
        weekLyWorkload,
        monthlyWorkload,
        totalWorkload,
      ];

  /// 直近1週間の工数
  final Workload weekLyWorkload;

  /// 直近1ヶ月の工数
  final Workload monthlyWorkload;

  /// 全期間の工数
  final Workload totalWorkload;

  TaskWorkloadCardState copyWith({
    Workload? weekLyWorkload,
    Workload? monthlyWorkload,
    Workload? totalWorkload,
  }) =>
      TaskWorkloadCardState(
        weekLyWorkload: weekLyWorkload ?? this.weekLyWorkload,
        monthlyWorkload: monthlyWorkload ?? this.monthlyWorkload,
        totalWorkload: totalWorkload ?? this.totalWorkload,
      );
}

@riverpod
class TaskWorkloadCard extends _$TaskWorkloadCard {
  @override
  TaskWorkloadCardState build({
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    if (taskStatusModelList.isEmpty) {
      return _initialState;
    }
    final weekLyWorkload = _getWorkLoad(
        workloadType: WorkloadType.weekly,
        taskStatusModelList: taskStatusModelList);
    final monthlyWorkload = _getWorkLoad(
        workloadType: WorkloadType.monthly,
        taskStatusModelList: taskStatusModelList);
    final totalWorkload = _getWorkLoad(
        workloadType: WorkloadType.all,
        taskStatusModelList: taskStatusModelList);
    // 初回表示は全期間で表示
    return TaskWorkloadCardState(
      weekLyWorkload: weekLyWorkload,
      monthlyWorkload: monthlyWorkload,
      totalWorkload: totalWorkload,
    );
  }

  void init() {
    state = _initialState;
  }

  /// 種別に応じて工数を取得
  Workload _getWorkLoad({
    required WorkloadType workloadType,
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    final copyList = [...taskStatusModelList];
    // タスク登録日時降順でソート。新しい日付順
    copyList.sort((a, b) => b.startDate.compareTo(a.startDate));

    List<TaskStatusModel> targetTaskList = copyList;
    // タスクリストを工数種別に合わせてトリミング
    if (workloadType != WorkloadType.all) {
      targetTaskList = copyList
          .map(
            (task) {
              if (workloadType == WorkloadType.weekly) {
                if (task.startDate
                    .isAfter(DateTime.now().add(const Duration(days: -7)))) {
                  return task;
                }
              } else {
                if (task.startDate
                    .isAfter(DateTime.now().add(const Duration(days: -30)))) {
                  return task;
                }
              }
            },
          )
          .whereType<TaskStatusModel>()
          .toList();
    }

    // 工数(h)
    double workloadHour = 0;
    // 実際に要した工数(h)
    double actualWorkloadHour = 0;

    for (final task in targetTaskList) {
      // 期日を元に取得
      workloadHour += getWeekdaysDifferenceInHours(
        startDate: task.startDate,
        endDate: task.dueDate,
        startHour: _kWorkStartHourTime,
        addingHour: _kWorkHour,
      );
      // 完了日を元に取得。完了していない場合、期日が本日を越えて入れば本日、そうでない場合は期日をendに設定
      actualWorkloadHour += getWeekdaysDifferenceInHours(
        startDate: task.startDate,
        endDate: task.doneDate ??
            (task.dueDate.isAfter(DateTime.now())
                ? task.dueDate
                : DateTime.now()),
        startHour: _kWorkStartHourTime,
        addingHour: _kWorkHour,
      );
    }
    final workloadPercent = workloadHour == 0.0 || actualWorkloadHour == 0.0
        ? 0.0
        : double.parse(
            ((1 - actualWorkloadHour / workloadHour) * 100).toStringAsFixed(2),
          );

    // タスク登録日が最も古い日付
    final oldTaskStartDate =
        targetTaskList.isEmpty ? null : targetTaskList.last.startDate;

    // タスク登録日が最も新しい日付
    final latestTaskStartDate =
        targetTaskList.isEmpty ? null : targetTaskList.first.startDate;

    return Workload(
      firstDate: oldTaskStartDate,
      lastDate: latestTaskStartDate,
      totalWorkloadHour: workloadHour,
      actualWorkloadHour: actualWorkloadHour,
      workloadPercent: workloadPercent,
    );
  }
}
