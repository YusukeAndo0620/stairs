// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectListHash() => r'b4b30e9c683d21b05d1a91076049c60c71406441';

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

abstract class _$ProjectList
    extends BuildlessAutoDisposeAsyncNotifier<List<ProjectListItemModel>> {
  late final StairsDatabase database;

  FutureOr<List<ProjectListItemModel>> build({
    required StairsDatabase database,
  });
}

/// See also [ProjectList].
@ProviderFor(ProjectList)
const projectListProvider = ProjectListFamily();

/// See also [ProjectList].
class ProjectListFamily extends Family<AsyncValue<List<ProjectListItemModel>>> {
  /// See also [ProjectList].
  const ProjectListFamily();

  /// See also [ProjectList].
  ProjectListProvider call({
    required StairsDatabase database,
  }) {
    return ProjectListProvider(
      database: database,
    );
  }

  @override
  ProjectListProvider getProviderOverride(
    covariant ProjectListProvider provider,
  ) {
    return call(
      database: provider.database,
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
  String? get name => r'projectListProvider';
}

/// See also [ProjectList].
class ProjectListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProjectList, List<ProjectListItemModel>> {
  /// See also [ProjectList].
  ProjectListProvider({
    required StairsDatabase database,
  }) : this._internal(
          () => ProjectList()..database = database,
          from: projectListProvider,
          name: r'projectListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectListHash,
          dependencies: ProjectListFamily._dependencies,
          allTransitiveDependencies:
              ProjectListFamily._allTransitiveDependencies,
          database: database,
        );

  ProjectListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.database,
  }) : super.internal();

  final StairsDatabase database;

  @override
  FutureOr<List<ProjectListItemModel>> runNotifierBuild(
    covariant ProjectList notifier,
  ) {
    return notifier.build(
      database: database,
    );
  }

  @override
  Override overrideWith(ProjectList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectListProvider._internal(
        () => create()..database = database,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        database: database,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProjectList,
      List<ProjectListItemModel>> createElement() {
    return _ProjectListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectListProvider && other.database == database;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, database.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectListRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProjectListItemModel>> {
  /// The parameter `database` of this provider.
  StairsDatabase get database;
}

class _ProjectListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProjectList,
        List<ProjectListItemModel>> with ProjectListRef {
  _ProjectListProviderElement(super.provider);

  @override
  StairsDatabase get database => (origin as ProjectListProvider).database;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
