// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_workload_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskWorkloadCardHash() => r'4582c58855920b6a0e96bcaca8aaea204f8bef8b';

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

abstract class _$TaskWorkloadCard
    extends BuildlessAutoDisposeNotifier<TaskWorkloadCardState> {
  late final List<TaskStatusModel> taskStatusModelList;

  TaskWorkloadCardState build({
    required List<TaskStatusModel> taskStatusModelList,
  });
}

/// See also [TaskWorkloadCard].
@ProviderFor(TaskWorkloadCard)
const taskWorkloadCardProvider = TaskWorkloadCardFamily();

/// See also [TaskWorkloadCard].
class TaskWorkloadCardFamily extends Family<TaskWorkloadCardState> {
  /// See also [TaskWorkloadCard].
  const TaskWorkloadCardFamily();

  /// See also [TaskWorkloadCard].
  TaskWorkloadCardProvider call({
    required List<TaskStatusModel> taskStatusModelList,
  }) {
    return TaskWorkloadCardProvider(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  TaskWorkloadCardProvider getProviderOverride(
    covariant TaskWorkloadCardProvider provider,
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
  String? get name => r'taskWorkloadCardProvider';
}

/// See also [TaskWorkloadCard].
class TaskWorkloadCardProvider extends AutoDisposeNotifierProviderImpl<
    TaskWorkloadCard, TaskWorkloadCardState> {
  /// See also [TaskWorkloadCard].
  TaskWorkloadCardProvider({
    required List<TaskStatusModel> taskStatusModelList,
  }) : this._internal(
          () => TaskWorkloadCard()..taskStatusModelList = taskStatusModelList,
          from: taskWorkloadCardProvider,
          name: r'taskWorkloadCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskWorkloadCardHash,
          dependencies: TaskWorkloadCardFamily._dependencies,
          allTransitiveDependencies:
              TaskWorkloadCardFamily._allTransitiveDependencies,
          taskStatusModelList: taskStatusModelList,
        );

  TaskWorkloadCardProvider._internal(
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
  TaskWorkloadCardState runNotifierBuild(
    covariant TaskWorkloadCard notifier,
  ) {
    return notifier.build(
      taskStatusModelList: taskStatusModelList,
    );
  }

  @override
  Override overrideWith(TaskWorkloadCard Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskWorkloadCardProvider._internal(
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
  AutoDisposeNotifierProviderElement<TaskWorkloadCard, TaskWorkloadCardState>
      createElement() {
    return _TaskWorkloadCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskWorkloadCardProvider &&
        other.taskStatusModelList == taskStatusModelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskStatusModelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskWorkloadCardRef
    on AutoDisposeNotifierProviderRef<TaskWorkloadCardState> {
  /// The parameter `taskStatusModelList` of this provider.
  List<TaskStatusModel> get taskStatusModelList;
}

class _TaskWorkloadCardProviderElement
    extends AutoDisposeNotifierProviderElement<TaskWorkloadCard,
        TaskWorkloadCardState> with TaskWorkloadCardRef {
  _TaskWorkloadCardProviderElement(super.provider);

  @override
  List<TaskStatusModel> get taskStatusModelList =>
      (origin as TaskWorkloadCardProvider).taskStatusModelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
