// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mColorHash() => r'512bb91bacb00b0e197924fb178fa113ce4f9bf7';

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

abstract class _$MColor
    extends BuildlessAutoDisposeAsyncNotifier<List<ColorModel>?> {
  late final StairsDatabase db;

  FutureOr<List<ColorModel>?> build({
    required StairsDatabase db,
  });
}

/// See also [MColor].
@ProviderFor(MColor)
const mColorProvider = MColorFamily();

/// See also [MColor].
class MColorFamily extends Family<AsyncValue<List<ColorModel>?>> {
  /// See also [MColor].
  const MColorFamily();

  /// See also [MColor].
  MColorProvider call({
    required StairsDatabase db,
  }) {
    return MColorProvider(
      db: db,
    );
  }

  @override
  MColorProvider getProviderOverride(
    covariant MColorProvider provider,
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
  String? get name => r'mColorProvider';
}

/// See also [MColor].
class MColorProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MColor, List<ColorModel>?> {
  /// See also [MColor].
  MColorProvider({
    required StairsDatabase db,
  }) : this._internal(
          () => MColor()..db = db,
          from: mColorProvider,
          name: r'mColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mColorHash,
          dependencies: MColorFamily._dependencies,
          allTransitiveDependencies: MColorFamily._allTransitiveDependencies,
          db: db,
        );

  MColorProvider._internal(
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
  FutureOr<List<ColorModel>?> runNotifierBuild(
    covariant MColor notifier,
  ) {
    return notifier.build(
      db: db,
    );
  }

  @override
  Override overrideWith(MColor Function() create) {
    return ProviderOverride(
      origin: this,
      override: MColorProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<MColor, List<ColorModel>?>
      createElement() {
    return _MColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MColorProvider && other.db == db;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, db.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MColorRef on AutoDisposeAsyncNotifierProviderRef<List<ColorModel>?> {
  /// The parameter `db` of this provider.
  StairsDatabase get db;
}

class _MColorProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MColor, List<ColorModel>?>
    with MColorRef {
  _MColorProviderElement(super.provider);

  @override
  StairsDatabase get db => (origin as MColorProvider).db;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
