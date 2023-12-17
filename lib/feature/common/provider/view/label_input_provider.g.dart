// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_input_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labelInputHash() => r'fadfe2735b0d4c3554ad4bdcab63c78df147eec7';

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

abstract class _$LabelInput
    extends BuildlessAutoDisposeNotifier<List<LabelModel>> {
  late final List<LabelModel> labelList;

  List<LabelModel> build({
    required List<LabelModel> labelList,
  });
}

/// See also [LabelInput].
@ProviderFor(LabelInput)
const labelInputProvider = LabelInputFamily();

/// See also [LabelInput].
class LabelInputFamily extends Family<List<LabelModel>> {
  /// See also [LabelInput].
  const LabelInputFamily();

  /// See also [LabelInput].
  LabelInputProvider call({
    required List<LabelModel> labelList,
  }) {
    return LabelInputProvider(
      labelList: labelList,
    );
  }

  @override
  LabelInputProvider getProviderOverride(
    covariant LabelInputProvider provider,
  ) {
    return call(
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
  String? get name => r'labelInputProvider';
}

/// See also [LabelInput].
class LabelInputProvider
    extends AutoDisposeNotifierProviderImpl<LabelInput, List<LabelModel>> {
  /// See also [LabelInput].
  LabelInputProvider({
    required List<LabelModel> labelList,
  }) : this._internal(
          () => LabelInput()..labelList = labelList,
          from: labelInputProvider,
          name: r'labelInputProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$labelInputHash,
          dependencies: LabelInputFamily._dependencies,
          allTransitiveDependencies:
              LabelInputFamily._allTransitiveDependencies,
          labelList: labelList,
        );

  LabelInputProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.labelList,
  }) : super.internal();

  final List<LabelModel> labelList;

  @override
  List<LabelModel> runNotifierBuild(
    covariant LabelInput notifier,
  ) {
    return notifier.build(
      labelList: labelList,
    );
  }

  @override
  Override overrideWith(LabelInput Function() create) {
    return ProviderOverride(
      origin: this,
      override: LabelInputProvider._internal(
        () => create()..labelList = labelList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        labelList: labelList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LabelInput, List<LabelModel>>
      createElement() {
    return _LabelInputProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LabelInputProvider && other.labelList == labelList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, labelList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LabelInputRef on AutoDisposeNotifierProviderRef<List<LabelModel>> {
  /// The parameter `labelList` of this provider.
  List<LabelModel> get labelList;
}

class _LabelInputProviderElement
    extends AutoDisposeNotifierProviderElement<LabelInput, List<LabelModel>>
    with LabelInputRef {
  _LabelInputProviderElement(super.provider);

  @override
  List<LabelModel> get labelList => (origin as LabelInputProvider).labelList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
