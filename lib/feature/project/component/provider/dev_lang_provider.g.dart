// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_lang_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$devLangHash() => r'd62c1c9925bb9f9e6639b72a87d3cf20acfc43fb';

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

abstract class _$DevLang
    extends BuildlessAutoDisposeAsyncNotifier<List<LabelModel>> {
  late final StairsDatabase db;

  FutureOr<List<LabelModel>> build({
    required StairsDatabase db,
  });
}

/// See also [DevLang].
@ProviderFor(DevLang)
const devLangProvider = DevLangFamily();

/// See also [DevLang].
class DevLangFamily extends Family<AsyncValue<List<LabelModel>>> {
  /// See also [DevLang].
  const DevLangFamily();

  /// See also [DevLang].
  DevLangProvider call({
    required StairsDatabase db,
  }) {
    return DevLangProvider(
      db: db,
    );
  }

  @override
  DevLangProvider getProviderOverride(
    covariant DevLangProvider provider,
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
  String? get name => r'devLangProvider';
}

/// See also [DevLang].
class DevLangProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DevLang, List<LabelModel>> {
  /// See also [DevLang].
  DevLangProvider({
    required StairsDatabase db,
  }) : this._internal(
          () => DevLang()..db = db,
          from: devLangProvider,
          name: r'devLangProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$devLangHash,
          dependencies: DevLangFamily._dependencies,
          allTransitiveDependencies: DevLangFamily._allTransitiveDependencies,
          db: db,
        );

  DevLangProvider._internal(
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
    covariant DevLang notifier,
  ) {
    return notifier.build(
      db: db,
    );
  }

  @override
  Override overrideWith(DevLang Function() create) {
    return ProviderOverride(
      origin: this,
      override: DevLangProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DevLang, List<LabelModel>>
      createElement() {
    return _DevLangProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DevLangProvider && other.db == db;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, db.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DevLangRef on AutoDisposeAsyncNotifierProviderRef<List<LabelModel>> {
  /// The parameter `db` of this provider.
  StairsDatabase get db;
}

class _DevLangProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DevLang, List<LabelModel>>
    with DevLangRef {
  _DevLangProviderElement(super.provider);

  @override
  StairsDatabase get db => (origin as DevLangProvider).db;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
