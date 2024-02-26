// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_status_chart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskStatusChartHash() => r'6fe514242482389884ded1aa9f9c0b9e3d4406a8';

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
  late final List<TaskStatusModel> taskStatusModelList;

  TaskStatusChartState build({
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
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    return TaskStatusChartProvider(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  TaskStatusChartProvider getProviderOverride(
    covariant TaskStatusChartProvider provider,
  ) {
    return call(
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
    required List<TaskStatusModel> taskStatusModelList,
  }) : this._internal(
          () => TaskStatusChart()..taskStatusModelList = taskStatusModelList,
          from: taskStatusChartProvider,
          name: r'taskStatusChartProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskStatusChartHash,
          dependencies: TaskStatusChartFamily._dependencies,
          allTransitiveDependencies:
              TaskStatusChartFamily._allTransitiveDependencies,
          taskStatusModelList: taskStatusModelList,
        );

  TaskStatusChartProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskStatusModelList,
  }) : super.internal();

  final List<TaskStatusModel> taskStatusModelList;

  @override
  TaskStatusChartState runNotifierBuild(
    covariant TaskStatusChart notifier,
  ) {
    return notifier.build(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  Override overrideWith(TaskStatusChart Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskStatusChartProvider._internal(
        () => create()..taskStatusModelList = taskStatusModelList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
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
        other.taskStatusModelList == taskStatusModelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskStatusModelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskStatusChartRef
    on AutoDisposeNotifierProviderRef<TaskStatusChartState> {
  /// The parameter `taskStatusModelList` of this provider.
  List<TaskStatusModel> get taskStatusModelList;
}

class _TaskStatusChartProviderElement
    extends AutoDisposeNotifierProviderElement<TaskStatusChart,
        TaskStatusChartState> with TaskStatusChartRef {
  _TaskStatusChartProviderElement(super.provider);

  @override
  List<TaskStatusModel> get taskStatusModelList =>
      (origin as TaskStatusChartProvider).taskStatusModelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
