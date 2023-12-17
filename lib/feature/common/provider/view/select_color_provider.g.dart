// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectColorHash() => r'fc923d7b0a88fa72a6651c758815351e6bff2944';

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

abstract class _$SelectColor
    extends BuildlessAutoDisposeNotifier<SelectColorModel> {
  late final List<ColorModel> colorList;
  late final int selectedColorId;

  SelectColorModel build({
    required List<ColorModel> colorList,
    required int selectedColorId,
  });
}

/// See also [SelectColor].
@ProviderFor(SelectColor)
const selectColorProvider = SelectColorFamily();

/// See also [SelectColor].
class SelectColorFamily extends Family<SelectColorModel> {
  /// See also [SelectColor].
  const SelectColorFamily();

  /// See also [SelectColor].
  SelectColorProvider call({
    required List<ColorModel> colorList,
    required int selectedColorId,
  }) {
    return SelectColorProvider(
      colorList: colorList,
      selectedColorId: selectedColorId,
    );
  }

  @override
  SelectColorProvider getProviderOverride(
    covariant SelectColorProvider provider,
  ) {
    return call(
      colorList: provider.colorList,
      selectedColorId: provider.selectedColorId,
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
  String? get name => r'selectColorProvider';
}

/// See also [SelectColor].
class SelectColorProvider
    extends AutoDisposeNotifierProviderImpl<SelectColor, SelectColorModel> {
  /// See also [SelectColor].
  SelectColorProvider({
    required List<ColorModel> colorList,
    required int selectedColorId,
  }) : this._internal(
          () => SelectColor()
            ..colorList = colorList
            ..selectedColorId = selectedColorId,
          from: selectColorProvider,
          name: r'selectColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectColorHash,
          dependencies: SelectColorFamily._dependencies,
          allTransitiveDependencies:
              SelectColorFamily._allTransitiveDependencies,
          colorList: colorList,
          selectedColorId: selectedColorId,
        );

  SelectColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.colorList,
    required this.selectedColorId,
  }) : super.internal();

  final List<ColorModel> colorList;
  final int selectedColorId;

  @override
  SelectColorModel runNotifierBuild(
    covariant SelectColor notifier,
  ) {
    return notifier.build(
      colorList: colorList,
      selectedColorId: selectedColorId,
    );
  }

  @override
  Override overrideWith(SelectColor Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectColorProvider._internal(
        () => create()
          ..colorList = colorList
          ..selectedColorId = selectedColorId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        colorList: colorList,
        selectedColorId: selectedColorId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectColor, SelectColorModel>
      createElement() {
    return _SelectColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectColorProvider &&
        other.colorList == colorList &&
        other.selectedColorId == selectedColorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, colorList.hashCode);
    hash = _SystemHash.combine(hash, selectedColorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectColorRef on AutoDisposeNotifierProviderRef<SelectColorModel> {
  /// The parameter `colorList` of this provider.
  List<ColorModel> get colorList;

  /// The parameter `selectedColorId` of this provider.
  int get selectedColorId;
}

class _SelectColorProviderElement
    extends AutoDisposeNotifierProviderElement<SelectColor, SelectColorModel>
    with SelectColorRef {
  _SelectColorProviderElement(super.provider);

  @override
  List<ColorModel> get colorList => (origin as SelectColorProvider).colorList;
  @override
  int get selectedColorId => (origin as SelectColorProvider).selectedColorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
