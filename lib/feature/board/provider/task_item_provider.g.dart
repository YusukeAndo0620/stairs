// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskItemHash() => r'b03e8eb634f61385dc42161acf7f23a2d80b535b';

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

abstract class _$TaskItem extends BuildlessAutoDisposeNotifier<TaskItemModel> {
  late final String taskItemId;

  TaskItemModel build({
    required String taskItemId,
  });
}

/// See also [TaskItem].
@ProviderFor(TaskItem)
const taskItemProvider = TaskItemFamily();

/// See also [TaskItem].
class TaskItemFamily extends Family<TaskItemModel> {
  /// See also [TaskItem].
  const TaskItemFamily();

  /// See also [TaskItem].
  TaskItemProvider call({
    required String taskItemId,
  }) {
    return TaskItemProvider(
      taskItemId: taskItemId,
    );
  }

  @override
  TaskItemProvider getProviderOverride(
    covariant TaskItemProvider provider,
  ) {
    return call(
      taskItemId: provider.taskItemId,
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
  String? get name => r'taskItemProvider';
}

/// See also [TaskItem].
class TaskItemProvider
    extends AutoDisposeNotifierProviderImpl<TaskItem, TaskItemModel> {
  /// See also [TaskItem].
  TaskItemProvider({
    required String taskItemId,
  }) : this._internal(
          () => TaskItem()..taskItemId = taskItemId,
          from: taskItemProvider,
          name: r'taskItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskItemHash,
          dependencies: TaskItemFamily._dependencies,
          allTransitiveDependencies: TaskItemFamily._allTransitiveDependencies,
          taskItemId: taskItemId,
        );

  TaskItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskItemId,
  }) : super.internal();

  final String taskItemId;

  @override
  TaskItemModel runNotifierBuild(
    covariant TaskItem notifier,
  ) {
    return notifier.build(
      taskItemId: taskItemId,
    );
  }

  @override
  Override overrideWith(TaskItem Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskItemProvider._internal(
        () => create()..taskItemId = taskItemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskItemId: taskItemId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskItem, TaskItemModel> createElement() {
    return _TaskItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskItemProvider && other.taskItemId == taskItemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskItemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskItemRef on AutoDisposeNotifierProviderRef<TaskItemModel> {
  /// The parameter `taskItemId` of this provider.
  String get taskItemId;
}

class _TaskItemProviderElement
    extends AutoDisposeNotifierProviderElement<TaskItem, TaskItemModel>
    with TaskItemRef {
  _TaskItemProviderElement(super.provider);

  @override
  String get taskItemId => (origin as TaskItemProvider).taskItemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
