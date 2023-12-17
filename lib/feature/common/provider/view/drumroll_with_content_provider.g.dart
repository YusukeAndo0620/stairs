// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drumroll_with_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$drumrollWithContentHash() =>
    r'27e17ae8721c38491e2daa2ae7191eefabe38e69';

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

abstract class _$DrumrollWithContent
    extends BuildlessAutoDisposeNotifier<SelectItemListModel> {
  late final List<LabelModel> labeList;
  late final List<LabelWithContent> selectedList;

  SelectItemListModel build({
    required List<LabelModel> labeList,
    required List<LabelWithContent> selectedList,
  });
}

/// See also [DrumrollWithContent].
@ProviderFor(DrumrollWithContent)
const drumrollWithContentProvider = DrumrollWithContentFamily();

/// See also [DrumrollWithContent].
class DrumrollWithContentFamily extends Family<SelectItemListModel> {
  /// See also [DrumrollWithContent].
  const DrumrollWithContentFamily();

  /// See also [DrumrollWithContent].
  DrumrollWithContentProvider call({
    required List<LabelModel> labeList,
    required List<LabelWithContent> selectedList,
  }) {
    return DrumrollWithContentProvider(
      labeList: labeList,
      selectedList: selectedList,
    );
  }

  @override
  DrumrollWithContentProvider getProviderOverride(
    covariant DrumrollWithContentProvider provider,
  ) {
    return call(
      labeList: provider.labeList,
      selectedList: provider.selectedList,
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
  String? get name => r'drumrollWithContentProvider';
}

/// See also [DrumrollWithContent].
class DrumrollWithContentProvider extends AutoDisposeNotifierProviderImpl<
    DrumrollWithContent, SelectItemListModel> {
  /// See also [DrumrollWithContent].
  DrumrollWithContentProvider({
    required List<LabelModel> labeList,
    required List<LabelWithContent> selectedList,
  }) : this._internal(
          () => DrumrollWithContent()
            ..labeList = labeList
            ..selectedList = selectedList,
          from: drumrollWithContentProvider,
          name: r'drumrollWithContentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$drumrollWithContentHash,
          dependencies: DrumrollWithContentFamily._dependencies,
          allTransitiveDependencies:
              DrumrollWithContentFamily._allTransitiveDependencies,
          labeList: labeList,
          selectedList: selectedList,
        );

  DrumrollWithContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.labeList,
    required this.selectedList,
  }) : super.internal();

  final List<LabelModel> labeList;
  final List<LabelWithContent> selectedList;

  @override
  SelectItemListModel runNotifierBuild(
    covariant DrumrollWithContent notifier,
  ) {
    return notifier.build(
      labeList: labeList,
      selectedList: selectedList,
    );
  }

  @override
  Override overrideWith(DrumrollWithContent Function() create) {
    return ProviderOverride(
      origin: this,
      override: DrumrollWithContentProvider._internal(
        () => create()
          ..labeList = labeList
          ..selectedList = selectedList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        labeList: labeList,
        selectedList: selectedList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DrumrollWithContent, SelectItemListModel>
      createElement() {
    return _DrumrollWithContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DrumrollWithContentProvider &&
        other.labeList == labeList &&
        other.selectedList == selectedList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, labeList.hashCode);
    hash = _SystemHash.combine(hash, selectedList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DrumrollWithContentRef
    on AutoDisposeNotifierProviderRef<SelectItemListModel> {
  /// The parameter `labeList` of this provider.
  List<LabelModel> get labeList;

  /// The parameter `selectedList` of this provider.
  List<LabelWithContent> get selectedList;
}

class _DrumrollWithContentProviderElement
    extends AutoDisposeNotifierProviderElement<DrumrollWithContent,
        SelectItemListModel> with DrumrollWithContentRef {
  _DrumrollWithContentProviderElement(super.provider);

  @override
  List<LabelModel> get labeList =>
      (origin as DrumrollWithContentProvider).labeList;
  @override
  List<LabelWithContent> get selectedList =>
      (origin as DrumrollWithContentProvider).selectedList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
