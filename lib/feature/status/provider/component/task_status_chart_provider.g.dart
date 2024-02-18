// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_status_chart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskStatusChartHash() => r'c7952f02f25619a563521bb57f35d04e0a0229d4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TaskStatusChart
    extends BuildlessAutoDisposeNotifier<TaskStatusChartState> {
  late final int displayedColumnCount;
  late final List<TaskStatusModel> taskStatusModelList;

  TaskStatusChartState build({
    required int displayedColumnCount,
    required List<TaskStatusModel> taskStatusModelList,
  });
}

/// See also [TaskStatusChart].
@ProviderFor(TaskStatusChart)
const taskStatusChartProvider = TaskStatusChartFamily();

/// See also [TaskStatusChart].
class TaskStatusChartFamily extends Family<TaskStatusChartState> {
  /// See also [TaskStatusChart].
  const TaskStatusChartFamily();

  /// See also [TaskStatusChart].
  TaskStatusChartProvider call({
    required int displayedColumnCount,
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    return TaskStatusChartProvider(
      displayedColumnCount: displayedColumnCount,
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  TaskStatusChartProvider getProviderOverride(
    covariant TaskStatusChartProvider provider,
  ) {
    return call(
      displayedColumnCount: provider.displayedColumnCount,
      taskStatusModelList: provider.taskStatusModelList,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskStatusChartProvider';
}

/// See also [TaskStatusChart].
class TaskStatusChartProvider extends AutoDisposeNotifierProviderImpl<
    TaskStatusChart, TaskStatusChartState> {
  /// See also [TaskStatusChart].
  TaskStatusChartProvider({
    required int displayedColumnCount,
    required List<TaskStatusModel> taskStatusModelList,
  }) : this._internal(
          () => TaskStatusChart()
            ..displayedColumnCount = displayedColumnCount
            ..taskStatusModelList = taskStatusModelList,
          from: taskStatusChartProvider,
          name: r'taskStatusChartProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskStatusChartHash,
          dependencies: TaskStatusChartFamily._dependencies,
          allTransitiveDependencies:
              TaskStatusChartFamily._allTransitiveDependencies,
          displayedColumnCount: displayedColumnCount,
          taskStatusModelList: taskStatusModelList,
        );

  TaskStatusChartProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.displayedColumnCount,
    required this.taskStatusModelList,
  }) : super.internal();

  final int displayedColumnCount;
  final List<TaskStatusModel> taskStatusModelList;

  @override
  TaskStatusChartState runNotifierBuild(
    covariant TaskStatusChart notifier,
  ) {
    return notifier.build(
      displayedColumnCount: displayedColumnCount,
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  Override overrideWith(TaskStatusChart Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskStatusChartProvider._internal(
        () => create()
          ..displayedColumnCount = displayedColumnCount
          ..taskStatusModelList = taskStatusModelList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        displayedColumnCount: displayedColumnCount,
        taskStatusModelList: taskStatusModelList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskStatusChart, TaskStatusChartState>
      createElement() {
    return _TaskStatusChartProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskStatusChartProvider &&
        other.displayedColumnCount == displayedColumnCount &&
        other.taskStatusModelList == taskStatusModelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, displayedColumnCount.hashCode);
    hash = _SystemHash.combine(hash, taskStatusModelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskStatusChartRef
    on AutoDisposeNotifierProviderRef<TaskStatusChartState> {
  /// The parameter `displayedColumnCount` of this provider.
  int get displayedColumnCount;

  /// The parameter `taskStatusModelList` of this provider.
  List<TaskStatusModel> get taskStatusModelList;
}

class _TaskStatusChartProviderElement
    extends AutoDisposeNotifierProviderElement<TaskStatusChart,
        TaskStatusChartState> with TaskStatusChartRef {
  _TaskStatusChartProviderElement(super.provider);

  @override
  int get displayedColumnCount =>
      (origin as TaskStatusChartProvider).displayedColumnCount;
  @override
  List<TaskStatusModel> get taskStatusModelList =>
      (origin as TaskStatusChartProvider).taskStatusModelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
