// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectDetailHash() => r'97875d08d42d1a57439e6458440fd71ffcf34c5f';

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

abstract class _$ProjectDetail
    extends BuildlessAutoDisposeAsyncNotifier<ProjectDetailModel?> {
  late final String projectId;

  FutureOr<ProjectDetailModel?> build({
    required String projectId,
  });
}

/// See also [ProjectDetail].
@ProviderFor(ProjectDetail)
const projectDetailProvider = ProjectDetailFamily();

/// See also [ProjectDetail].
class ProjectDetailFamily extends Family<AsyncValue<ProjectDetailModel?>> {
  /// See also [ProjectDetail].
  const ProjectDetailFamily();

  /// See also [ProjectDetail].
  ProjectDetailProvider call({
    required String projectId,
  }) {
    return ProjectDetailProvider(
      projectId: projectId,
    );
  }

  @override
  ProjectDetailProvider getProviderOverride(
    covariant ProjectDetailProvider provider,
  ) {
    return call(
      projectId: provider.projectId,
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
  String? get name => r'projectDetailProvider';
}

/// See also [ProjectDetail].
class ProjectDetailProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProjectDetail, ProjectDetailModel?> {
  /// See also [ProjectDetail].
  ProjectDetailProvider({
    required String projectId,
  }) : this._internal(
          () => ProjectDetail()..projectId = projectId,
          from: projectDetailProvider,
          name: r'projectDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectDetailHash,
          dependencies: ProjectDetailFamily._dependencies,
          allTransitiveDependencies:
              ProjectDetailFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  ProjectDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  FutureOr<ProjectDetailModel?> runNotifierBuild(
    covariant ProjectDetail notifier,
  ) {
    return notifier.build(
      projectId: projectId,
    );
  }

  @override
  Override overrideWith(ProjectDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectDetailProvider._internal(
        () => create()..projectId = projectId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProjectDetail, ProjectDetailModel?>
      createElement() {
    return _ProjectDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectDetailProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectDetailRef
    on AutoDisposeAsyncNotifierProviderRef<ProjectDetailModel?> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _ProjectDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProjectDetail,
        ProjectDetailModel?> with ProjectDetailRef {
  _ProjectDetailProviderElement(super.provider);

  @override
  String get projectId => (origin as ProjectDetailProvider).projectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
