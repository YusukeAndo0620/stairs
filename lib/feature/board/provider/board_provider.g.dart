// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardHash() => r'd6b56141eff30931ada3c26fff6d89073b27187a';

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

abstract class _$Board extends BuildlessAutoDisposeAsyncNotifier<BoardState> {
  late final String projectId;

  FutureOr<BoardState> build({
    required String projectId,
  });
}

/// See also [Board].
@ProviderFor(Board)
const boardProvider = BoardFamily();

/// See also [Board].
class BoardFamily extends Family<AsyncValue<BoardState>> {
  /// See also [Board].
  const BoardFamily();

  /// See also [Board].
  BoardProvider call({
    required String projectId,
  }) {
    return BoardProvider(
      projectId: projectId,
    );
  }

  @override
  BoardProvider getProviderOverride(
    covariant BoardProvider provider,
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
  String? get name => r'boardProvider';
}

/// See also [Board].
class BoardProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Board, BoardState> {
  /// See also [Board].
  BoardProvider({
    required String projectId,
  }) : this._internal(
          () => Board()..projectId = projectId,
          from: boardProvider,
          name: r'boardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$boardHash,
          dependencies: BoardFamily._dependencies,
          allTransitiveDependencies: BoardFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  BoardProvider._internal(
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
  FutureOr<BoardState> runNotifierBuild(
    covariant Board notifier,
  ) {
    return notifier.build(
      projectId: projectId,
    );
  }

  @override
  Override overrideWith(Board Function() create) {
    return ProviderOverride(
      origin: this,
      override: BoardProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Board, BoardState> createElement() {
    return _BoardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BoardRef on AutoDisposeAsyncNotifierProviderRef<BoardState> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _BoardProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Board, BoardState>
    with BoardRef {
  _BoardProviderElement(super.provider);

  @override
  String get projectId => (origin as BoardProvider).projectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
