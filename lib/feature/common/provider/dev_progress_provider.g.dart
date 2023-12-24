// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$devProgressHash() => r'4bc186a89084e40326561cc8ba76c81e168b6993';

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

abstract class _$DevProgress
    extends BuildlessAutoDisposeAsyncNotifier<List<LabelModel>> {
  late final StairsDatabase db;

  FutureOr<List<LabelModel>> build({
    required StairsDatabase db,
  });
}

/// See also [DevProgress].
@ProviderFor(DevProgress)
const devProgressProvider = DevProgressFamily();

/// See also [DevProgress].
class DevProgressFamily extends Family<AsyncValue<List<LabelModel>>> {
  /// See also [DevProgress].
  const DevProgressFamily();

  /// See also [DevProgress].
  DevProgressProvider call({
    required StairsDatabase db,
  }) {
    return DevProgressProvider(
      db: db,
    );
  }

  @override
  DevProgressProvider getProviderOverride(
    covariant DevProgressProvider provider,
  ) {
    return call(
      db: provider.db,
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
  String? get name => r'devProgressProvider';
}

/// See also [DevProgress].
class DevProgressProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DevProgress, List<LabelModel>> {
  /// See also [DevProgress].
  DevProgressProvider({
    required StairsDatabase db,
  }) : this._internal(
          () => DevProgress()..db = db,
          from: devProgressProvider,
          name: r'devProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$devProgressHash,
          dependencies: DevProgressFamily._dependencies,
          allTransitiveDependencies:
              DevProgressFamily._allTransitiveDependencies,
          db: db,
        );

  DevProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.db,
  }) : super.internal();

  final StairsDatabase db;

  @override
  FutureOr<List<LabelModel>> runNotifierBuild(
    covariant DevProgress notifier,
  ) {
    return notifier.build(
      db: db,
    );
  }

  @override
  Override overrideWith(DevProgress Function() create) {
    return ProviderOverride(
      origin: this,
      override: DevProgressProvider._internal(
        () => create()..db = db,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        db: db,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DevProgress, List<LabelModel>>
      createElement() {
    return _DevProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DevProgressProvider && other.db == db;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, db.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DevProgressRef on AutoDisposeAsyncNotifierProviderRef<List<LabelModel>> {
  /// The parameter `db` of this provider.
  StairsDatabase get db;
}

class _DevProgressProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DevProgress,
        List<LabelModel>> with DevProgressRef {
  _DevProgressProviderElement(super.provider);

  @override
  StairsDatabase get db => (origin as DevProgressProvider).db;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
