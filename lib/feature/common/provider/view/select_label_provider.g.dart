// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_label_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectLabelHash() => r'5bf60db317627406126bfbff4dcf8107782a556e';

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

abstract class _$SelectLabel
    extends BuildlessAutoDisposeNotifier<List<CheckedLabelModel>> {
  late final List<LabelModel> labelList;
  late final List<String> checkedIdList;

  List<CheckedLabelModel> build({
    required List<LabelModel> labelList,
    required List<String> checkedIdList,
  });
}

/// See also [SelectLabel].
@ProviderFor(SelectLabel)
const selectLabelProvider = SelectLabelFamily();

/// See also [SelectLabel].
class SelectLabelFamily extends Family<List<CheckedLabelModel>> {
  /// See also [SelectLabel].
  const SelectLabelFamily();

  /// See also [SelectLabel].
  SelectLabelProvider call({
    required List<LabelModel> labelList,
    required List<String> checkedIdList,
  }) {
    return SelectLabelProvider(
      labelList: labelList,
      checkedIdList: checkedIdList,
    );
  }

  @override
  SelectLabelProvider getProviderOverride(
    covariant SelectLabelProvider provider,
  ) {
    return call(
      labelList: provider.labelList,
      checkedIdList: provider.checkedIdList,
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
  String? get name => r'selectLabelProvider';
}

/// See also [SelectLabel].
class SelectLabelProvider extends AutoDisposeNotifierProviderImpl<SelectLabel,
    List<CheckedLabelModel>> {
  /// See also [SelectLabel].
  SelectLabelProvider({
    required List<LabelModel> labelList,
    required List<String> checkedIdList,
  }) : this._internal(
          () => SelectLabel()
            ..labelList = labelList
            ..checkedIdList = checkedIdList,
          from: selectLabelProvider,
          name: r'selectLabelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectLabelHash,
          dependencies: SelectLabelFamily._dependencies,
          allTransitiveDependencies:
              SelectLabelFamily._allTransitiveDependencies,
          labelList: labelList,
          checkedIdList: checkedIdList,
        );

  SelectLabelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.labelList,
    required this.checkedIdList,
  }) : super.internal();

  final List<LabelModel> labelList;
  final List<String> checkedIdList;

  @override
  List<CheckedLabelModel> runNotifierBuild(
    covariant SelectLabel notifier,
  ) {
    return notifier.build(
      labelList: labelList,
      checkedIdList: checkedIdList,
    );
  }

  @override
  Override overrideWith(SelectLabel Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectLabelProvider._internal(
        () => create()
          ..labelList = labelList
          ..checkedIdList = checkedIdList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        labelList: labelList,
        checkedIdList: checkedIdList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectLabel, List<CheckedLabelModel>>
      createElement() {
    return _SelectLabelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectLabelProvider &&
        other.labelList == labelList &&
        other.checkedIdList == checkedIdList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, labelList.hashCode);
    hash = _SystemHash.combine(hash, checkedIdList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectLabelRef
    on AutoDisposeNotifierProviderRef<List<CheckedLabelModel>> {
  /// The parameter `labelList` of this provider.
  List<LabelModel> get labelList;

  /// The parameter `checkedIdList` of this provider.
  List<String> get checkedIdList;
}

class _SelectLabelProviderElement extends AutoDisposeNotifierProviderElement<
    SelectLabel, List<CheckedLabelModel>> with SelectLabelRef {
  _SelectLabelProviderElement(super.provider);

  @override
  List<LabelModel> get labelList => (origin as SelectLabelProvider).labelList;
  @override
  List<String> get checkedIdList =>
      (origin as SelectLabelProvider).checkedIdList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
