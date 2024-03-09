// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_table_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labelTableHash() => r'b7dea7edb96dfcbafc9f73dba8f60d6ce9efcba9';

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

abstract class _$LabelTable
    extends BuildlessAutoDisposeNotifier<LabelTableState> {
  late final List<LabelStatusModel> labelStatusList;

  LabelTableState build({
    required List<LabelStatusModel> labelStatusList,
  });
}

/// See also [LabelTable].
@ProviderFor(LabelTable)
const labelTableProvider = LabelTableFamily();

/// See also [LabelTable].
class LabelTableFamily extends Family<LabelTableState> {
  /// See also [LabelTable].
  const LabelTableFamily();

  /// See also [LabelTable].
  LabelTableProvider call({
    required List<LabelStatusModel> labelStatusList,
  }) {
    return LabelTableProvider(
      labelStatusList: labelStatusList,
    );
  }

  @override
  LabelTableProvider getProviderOverride(
    covariant LabelTableProvider provider,
  ) {
    return call(
      labelStatusList: provider.labelStatusList,
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
  String? get name => r'labelTableProvider';
}

/// See also [LabelTable].
class LabelTableProvider
    extends AutoDisposeNotifierProviderImpl<LabelTable, LabelTableState> {
  /// See also [LabelTable].
  LabelTableProvider({
    required List<LabelStatusModel> labelStatusList,
  }) : this._internal(
          () => LabelTable()..labelStatusList = labelStatusList,
          from: labelTableProvider,
          name: r'labelTableProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$labelTableHash,
          dependencies: LabelTableFamily._dependencies,
          allTransitiveDependencies:
              LabelTableFamily._allTransitiveDependencies,
          labelStatusList: labelStatusList,
        );

  LabelTableProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.labelStatusList,
  }) : super.internal();

  final List<LabelStatusModel> labelStatusList;

  @override
  LabelTableState runNotifierBuild(
    covariant LabelTable notifier,
  ) {
    return notifier.build(
      labelStatusList: labelStatusList,
    );
  }

  @override
  Override overrideWith(LabelTable Function() create) {
    return ProviderOverride(
      origin: this,
      override: LabelTableProvider._internal(
        () => create()..labelStatusList = labelStatusList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        labelStatusList: labelStatusList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LabelTable, LabelTableState>
      createElement() {
    return _LabelTableProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LabelTableProvider &&
        other.labelStatusList == labelStatusList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, labelStatusList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LabelTableRef on AutoDisposeNotifierProviderRef<LabelTableState> {
  /// The parameter `labelStatusList` of this provider.
  List<LabelStatusModel> get labelStatusList;
}

class _LabelTableProviderElement
    extends AutoDisposeNotifierProviderElement<LabelTable, LabelTableState>
    with LabelTableRef {
  _LabelTableProviderElement(super.provider);

  @override
  List<LabelStatusModel> get labelStatusList =>
      (origin as LabelTableProvider).labelStatusList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
