// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardHash() => r'bc8d97e651a45b725763803a124d982c8a018a69';

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

abstract class _$Board
    extends BuildlessAutoDisposeAsyncNotifier<List<BoardModel>> {
  late final String projectId;
  late final StairsDatabase database;

  FutureOr<List<BoardModel>> build({
    required String projectId,
    required StairsDatabase database,
  });
}

/// See also [Board].
@ProviderFor(Board)
const boardProvider = BoardFamily();

/// See also [Board].
class BoardFamily extends Family<AsyncValue<List<BoardModel>>> {
  /// See also [Board].
  const BoardFamily();

  /// See also [Board].
  BoardProvider call({
    required String projectId,
    required StairsDatabase database,
  }) {
    return BoardProvider(
      projectId: projectId,
      database: database,
    );
  }

  @override
  BoardProvider getProviderOverride(
    covariant BoardProvider provider,
  ) {
    return call(
      projectId: provider.projectId,
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
  String? get name => r'boardProvider';
}

/// See also [Board].
class BoardProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Board, List<BoardModel>> {
  /// See also [Board].
  BoardProvider({
    required String projectId,
    required StairsDatabase database,
  }) : this._internal(
          () => Board()
            ..projectId = projectId
            ..database = database,
          from: boardProvider,
          name: r'boardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boardHash,
          dependencies: BoardFamily._dependencies,
          allTransitiveDependencies: BoardFamily._allTransitiveDependencies,
          projectId: projectId,
          database: database,
        );

  BoardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
    required this.database,
  }) : super.internal();

  final String projectId;
  final StairsDatabase database;

  @override
  FutureOr<List<BoardModel>> runNotifierBuild(
    covariant Board notifier,
  ) {
    return notifier.build(
      projectId: projectId,
      database: database,
    );
  }

  @override
  Override overrideWith(Board Function() create) {
    return ProviderOverride(
      origin: this,
      override: BoardProvider._internal(
        () => create()
          ..projectId = projectId
          ..database = database,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
        database: database,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Board, List<BoardModel>>
      createElement() {
    return _BoardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardProvider &&
        other.projectId == projectId &&
        other.database == database;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);
    hash = _SystemHash.combine(hash, database.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BoardRef on AutoDisposeAsyncNotifierProviderRef<List<BoardModel>> {
  /// The parameter `projectId` of this provider.
  String get projectId;

  /// The parameter `database` of this provider.
  StairsDatabase get database;
}

class _BoardProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Board, List<BoardModel>>
    with BoardRef {
  _BoardProviderElement(super.provider);

  @override
  String get projectId => (origin as BoardProvider).projectId;
  @override
  StairsDatabase get database => (origin as BoardProvider).database;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
