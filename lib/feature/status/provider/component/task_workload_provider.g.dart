// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_workload_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskWorkloadHash() => r'0e47c234dbb7aaecd2521763cbdc2adb7c8b5443';

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

abstract class _$TaskWorkload
    extends BuildlessAutoDisposeNotifier<TaskWorkloadState> {
  late final List<TaskStatusModel> taskStatusModelList;

  TaskWorkloadState build({
    required List<TaskStatusModel> taskStatusModelList,
  });
}

/// See also [TaskWorkload].
@ProviderFor(TaskWorkload)
const taskWorkloadProvider = TaskWorkloadFamily();

/// See also [TaskWorkload].
class TaskWorkloadFamily extends Family<TaskWorkloadState> {
  /// See also [TaskWorkload].
  const TaskWorkloadFamily();

  /// See also [TaskWorkload].
  TaskWorkloadProvider call({
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    return TaskWorkloadProvider(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  TaskWorkloadProvider getProviderOverride(
    covariant TaskWorkloadProvider provider,
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
  String? get name => r'taskWorkloadProvider';
}

/// See also [TaskWorkload].
class TaskWorkloadProvider
    extends AutoDisposeNotifierProviderImpl<TaskWorkload, TaskWorkloadState> {
  /// See also [TaskWorkload].
  TaskWorkloadProvider({
    required List<TaskStatusModel> taskStatusModelList,
  }) : this._internal(
          () => TaskWorkload()..taskStatusModelList = taskStatusModelList,
          from: taskWorkloadProvider,
          name: r'taskWorkloadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskWorkloadHash,
          dependencies: TaskWorkloadFamily._dependencies,
          allTransitiveDependencies:
              TaskWorkloadFamily._allTransitiveDependencies,
          taskStatusModelList: taskStatusModelList,
        );

  TaskWorkloadProvider._internal(
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
  TaskWorkloadState runNotifierBuild(
    covariant TaskWorkload notifier,
  ) {
    return notifier.build(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  Override overrideWith(TaskWorkload Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskWorkloadProvider._internal(
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
  AutoDisposeNotifierProviderElement<TaskWorkload, TaskWorkloadState>
      createElement() {
    return _TaskWorkloadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskWorkloadProvider &&
        other.taskStatusModelList == taskStatusModelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskStatusModelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskWorkloadRef on AutoDisposeNotifierProviderRef<TaskWorkloadState> {
  /// The parameter `taskStatusModelList` of this provider.
  List<TaskStatusModel> get taskStatusModelList;
}

class _TaskWorkloadProviderElement
    extends AutoDisposeNotifierProviderElement<TaskWorkload, TaskWorkloadState>
    with TaskWorkloadRef {
  _TaskWorkloadProviderElement(super.provider);

  @override
  List<TaskStatusModel> get taskStatusModelList =>
      (origin as TaskWorkloadProvider).taskStatusModelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
