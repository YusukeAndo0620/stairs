// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountHash() => r'da7e1a2b2da3535db63aaf23835e17a330150718';

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

abstract class _$Account extends BuildlessAsyncNotifier<AccountModel?> {
  late final StairsDatabase db;

  FutureOr<AccountModel?> build({
    required StairsDatabase db,
  });
}

/// See also [Account].
@ProviderFor(Account)
const accountProvider = AccountFamily();

/// See also [Account].
class AccountFamily extends Family<AsyncValue<AccountModel?>> {
  /// See also [Account].
  const AccountFamily();

  /// See also [Account].
  AccountProvider call({
    required StairsDatabase db,
  }) {
    return AccountProvider(
      db: db,
    );
  }

  @override
  AccountProvider getProviderOverride(
    covariant AccountProvider provider,
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
  String? get name => r'accountProvider';
}

/// See also [Account].
class AccountProvider
    extends AsyncNotifierProviderImpl<Account, AccountModel?> {
  /// See also [Account].
  AccountProvider({
    required StairsDatabase db,
  }) : this._internal(
          () => Account()..db = db,
          from: accountProvider,
          name: r'accountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountHash,
          dependencies: AccountFamily._dependencies,
          allTransitiveDependencies: AccountFamily._allTransitiveDependencies,
          db: db,
        );

  AccountProvider._internal(
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
  FutureOr<AccountModel?> runNotifierBuild(
    covariant Account notifier,
  ) {
    return notifier.build(
      db: db,
    );
  }

  @override
  Override overrideWith(Account Function() create) {
    return ProviderOverride(
      origin: this,
      override: AccountProvider._internal(
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
  AsyncNotifierProviderElement<Account, AccountModel?> createElement() {
    return _AccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountProvider && other.db == db;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, db.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AccountRef on AsyncNotifierProviderRef<AccountModel?> {
  /// The parameter `db` of this provider.
  StairsDatabase get db;
}

class _AccountProviderElement
    extends AsyncNotifierProviderElement<Account, AccountModel?>
    with AccountRef {
  _AccountProviderElement(super.provider);

  @override
  StairsDatabase get db => (origin as AccountProvider).db;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
