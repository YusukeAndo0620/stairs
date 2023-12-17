// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tagHash() => r'59932b9a940a9a8b49b84413e631b8a606acd9b8';

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

abstract class _$Tag
    extends BuildlessAutoDisposeNotifier<List<ColorLabelModel>> {
  late final List<ColorLabelModel> tagList;

  List<ColorLabelModel> build({
    required List<ColorLabelModel> tagList,
  });
}

/// See also [Tag].
@ProviderFor(Tag)
const tagProvider = TagFamily();

/// See also [Tag].
class TagFamily extends Family<List<ColorLabelModel>> {
  /// See also [Tag].
  const TagFamily();

  /// See also [Tag].
  TagProvider call({
    required List<ColorLabelModel> tagList,
  }) {
    return TagProvider(
      tagList: tagList,
    );
  }

  @override
  TagProvider getProviderOverride(
    covariant TagProvider provider,
  ) {
    return call(
      tagList: provider.tagList,
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
  String? get name => r'tagProvider';
}

/// See also [Tag].
class TagProvider
    extends AutoDisposeNotifierProviderImpl<Tag, List<ColorLabelModel>> {
  /// See also [Tag].
  TagProvider({
    required List<ColorLabelModel> tagList,
  }) : this._internal(
          () => Tag()..tagList = tagList,
          from: tagProvider,
          name: r'tagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$tagHash,
          dependencies: TagFamily._dependencies,
          allTransitiveDependencies: TagFamily._allTransitiveDependencies,
          tagList: tagList,
        );

  TagProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tagList,
  }) : super.internal();

  final List<ColorLabelModel> tagList;

  @override
  List<ColorLabelModel> runNotifierBuild(
    covariant Tag notifier,
  ) {
    return notifier.build(
      tagList: tagList,
    );
  }

  @override
  Override overrideWith(Tag Function() create) {
    return ProviderOverride(
      origin: this,
      override: TagProvider._internal(
        () => create()..tagList = tagList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tagList: tagList,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Tag, List<ColorLabelModel>>
      createElement() {
    return _TagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TagProvider && other.tagList == tagList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tagList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TagRef on AutoDisposeNotifierProviderRef<List<ColorLabelModel>> {
  /// The parameter `tagList` of this provider.
  List<ColorLabelModel> get tagList;
}

class _TagProviderElement
    extends AutoDisposeNotifierProviderElement<Tag, List<ColorLabelModel>>
    with TagRef {
  _TagProviderElement(super.provider);

  @override
  List<ColorLabelModel> get tagList => (origin as TagProvider).tagList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
