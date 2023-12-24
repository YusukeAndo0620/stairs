// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskItemHash() => r'75ca2e87d5f8bb80a993773355e5e1c248a32c70';

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
  late final String boardId;
  late final String taskItemId;
  late final String? title;
  late final String? description;
  late final DateTime? startDate;
  late final DateTime? endDate;
  late final List<ColorLabelModel>? labelList;

  TaskItemModel build({
    required String boardId,
    required String taskItemId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<ColorLabelModel>? labelList,
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
    required String boardId,
    required String taskItemId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<ColorLabelModel>? labelList,
  }) {
    return TaskItemProvider(
      boardId: boardId,
      taskItemId: taskItemId,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      labelList: labelList,
    );
  }

  @override
  TaskItemProvider getProviderOverride(
    covariant TaskItemProvider provider,
  ) {
    return call(
      boardId: provider.boardId,
      taskItemId: provider.taskItemId,
      title: provider.title,
      description: provider.description,
      startDate: provider.startDate,
      endDate: provider.endDate,
      labelList: provider.labelList,
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
    required String boardId,
    required String taskItemId,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<ColorLabelModel>? labelList,
  }) : this._internal(
          () => TaskItem()
            ..boardId = boardId
            ..taskItemId = taskItemId
            ..title = title
            ..description = description
            ..startDate = startDate
            ..endDate = endDate
            ..labelList = labelList,
          from: taskItemProvider,
          name: r'taskItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskItemHash,
          dependencies: TaskItemFamily._dependencies,
          allTransitiveDependencies: TaskItemFamily._allTransitiveDependencies,
          boardId: boardId,
          taskItemId: taskItemId,
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          labelList: labelList,
        );

  TaskItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.boardId,
    required this.taskItemId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.labelList,
  }) : super.internal();

  final String boardId;
  final String taskItemId;
  final String? title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<ColorLabelModel>? labelList;

  @override
  TaskItemModel runNotifierBuild(
    covariant TaskItem notifier,
  ) {
    return notifier.build(
      boardId: boardId,
      taskItemId: taskItemId,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      labelList: labelList,
    );
  }

  @override
  Override overrideWith(TaskItem Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskItemProvider._internal(
        () => create()
          ..boardId = boardId
          ..taskItemId = taskItemId
          ..title = title
          ..description = description
          ..startDate = startDate
          ..endDate = endDate
          ..labelList = labelList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        boardId: boardId,
        taskItemId: taskItemId,
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        labelList: labelList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskItem, TaskItemModel> createElement() {
    return _TaskItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskItemProvider &&
        other.boardId == boardId &&
        other.taskItemId == taskItemId &&
        other.title == title &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.labelList == labelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boardId.hashCode);
    hash = _SystemHash.combine(hash, taskItemId.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);
    hash = _SystemHash.combine(hash, description.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);
    hash = _SystemHash.combine(hash, labelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskItemRef on AutoDisposeNotifierProviderRef<TaskItemModel> {
  /// The parameter `boardId` of this provider.
  String get boardId;

  /// The parameter `taskItemId` of this provider.
  String get taskItemId;

  /// The parameter `title` of this provider.
  String? get title;

  /// The parameter `description` of this provider.
  String? get description;

  /// The parameter `startDate` of this provider.
  DateTime? get startDate;

  /// The parameter `endDate` of this provider.
  DateTime? get endDate;

  /// The parameter `labelList` of this provider.
  List<ColorLabelModel>? get labelList;
}

class _TaskItemProviderElement
    extends AutoDisposeNotifierProviderElement<TaskItem, TaskItemModel>
    with TaskItemRef {
  _TaskItemProviderElement(super.provider);

  @override
  String get boardId => (origin as TaskItemProvider).boardId;
  @override
  String get taskItemId => (origin as TaskItemProvider).taskItemId;
  @override
  String? get title => (origin as TaskItemProvider).title;
  @override
  String? get description => (origin as TaskItemProvider).description;
  @override
  DateTime? get startDate => (origin as TaskItemProvider).startDate;
  @override
  DateTime? get endDate => (origin as TaskItemProvider).endDate;
  @override
  List<ColorLabelModel>? get labelList =>
      (origin as TaskItemProvider).labelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
