// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_workload_line_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskWorkloadLineHash() => r'175938e531828ce5adef2c914259dd86cc050ddb';

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

abstract class _$TaskWorkloadLine
    extends BuildlessAutoDisposeNotifier<List<TaskWorkloadLineData>> {
  late final List<TaskStatusModel> taskStatusModelList;

  List<TaskWorkloadLineData> build({
    required List<TaskStatusModel> taskStatusModelList,
  });
}

/// See also [TaskWorkloadLine].
@ProviderFor(TaskWorkloadLine)
const taskWorkloadLineProvider = TaskWorkloadLineFamily();

/// See also [TaskWorkloadLine].
class TaskWorkloadLineFamily extends Family<List<TaskWorkloadLineData>> {
  /// See also [TaskWorkloadLine].
  const TaskWorkloadLineFamily();

  /// See also [TaskWorkloadLine].
  TaskWorkloadLineProvider call({
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    return TaskWorkloadLineProvider(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  TaskWorkloadLineProvider getProviderOverride(
    covariant TaskWorkloadLineProvider provider,
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
  String? get name => r'taskWorkloadLineProvider';
}

/// See also [TaskWorkloadLine].
class TaskWorkloadLineProvider extends AutoDisposeNotifierProviderImpl<
    TaskWorkloadLine, List<TaskWorkloadLineData>> {
  /// See also [TaskWorkloadLine].
  TaskWorkloadLineProvider({
    required List<TaskStatusModel> taskStatusModelList,
  }) : this._internal(
          () => TaskWorkloadLine()..taskStatusModelList = taskStatusModelList,
          from: taskWorkloadLineProvider,
          name: r'taskWorkloadLineProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskWorkloadLineHash,
          dependencies: TaskWorkloadLineFamily._dependencies,
          allTransitiveDependencies:
              TaskWorkloadLineFamily._allTransitiveDependencies,
          taskStatusModelList: taskStatusModelList,
        );

  TaskWorkloadLineProvider._internal(
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
  List<TaskWorkloadLineData> runNotifierBuild(
    covariant TaskWorkloadLine notifier,
  ) {
    return notifier.build(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  Override overrideWith(TaskWorkloadLine Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskWorkloadLineProvider._internal(
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
  AutoDisposeNotifierProviderElement<TaskWorkloadLine,
      List<TaskWorkloadLineData>> createElement() {
    return _TaskWorkloadLineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskWorkloadLineProvider &&
        other.taskStatusModelList == taskStatusModelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskStatusModelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskWorkloadLineRef
    on AutoDisposeNotifierProviderRef<List<TaskWorkloadLineData>> {
  /// The parameter `taskStatusModelList` of this provider.
  List<TaskStatusModel> get taskStatusModelList;
}

class _TaskWorkloadLineProviderElement
    extends AutoDisposeNotifierProviderElement<TaskWorkloadLine,
        List<TaskWorkloadLineData>> with TaskWorkloadLineRef {
  _TaskWorkloadLineProviderElement(super.provider);

  @override
  List<TaskStatusModel> get taskStatusModelList =>
      (origin as TaskWorkloadLineProvider).taskStatusModelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
