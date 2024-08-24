// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchMemoryHash() => r'd5f30f77c08f637842f6ba5ca8d8702f8ba19c9f';

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

/// See also [fetchMemory].
@ProviderFor(fetchMemory)
const fetchMemoryProvider = FetchMemoryFamily();

/// See also [fetchMemory].
class FetchMemoryFamily extends Family {
  /// See also [fetchMemory].
  const FetchMemoryFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchMemoryProvider';

  /// See also [fetchMemory].
  FetchMemoryProvider call({
    required String id,
  }) {
    return FetchMemoryProvider(
      id: id,
    );
  }

  @visibleForOverriding
  @override
  FetchMemoryProvider getProviderOverride(
    covariant FetchMemoryProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FutureOr<Memory?> Function(FetchMemoryRef ref) create) {
    return _$FetchMemoryFamilyOverride(this, create);
  }
}

class _$FetchMemoryFamilyOverride implements FamilyOverride {
  _$FetchMemoryFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Memory?> Function(FetchMemoryRef ref) create;

  @override
  final FetchMemoryFamily overriddenFamily;

  @override
  FetchMemoryProvider getProviderOverride(
    covariant FetchMemoryProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [fetchMemory].
class FetchMemoryProvider extends AutoDisposeFutureProvider<Memory?> {
  /// See also [fetchMemory].
  FetchMemoryProvider({
    required String id,
  }) : this._internal(
          (ref) => fetchMemory(
            ref as FetchMemoryRef,
            id: id,
          ),
          from: fetchMemoryProvider,
          name: r'fetchMemoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMemoryHash,
          dependencies: FetchMemoryFamily._dependencies,
          allTransitiveDependencies:
              FetchMemoryFamily._allTransitiveDependencies,
          id: id,
        );

  FetchMemoryProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Memory?> Function(FetchMemoryRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchMemoryProvider._internal(
        (ref) => create(ref as FetchMemoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  ({
    String id,
  }) get argument {
    return (id: id,);
  }

  @override
  AutoDisposeFutureProviderElement<Memory?> createElement() {
    return _FetchMemoryProviderElement(this);
  }

  FetchMemoryProvider _copyWith(
    FutureOr<Memory?> Function(FetchMemoryRef ref) create,
  ) {
    return FetchMemoryProvider._internal(
      (ref) => create(ref as FetchMemoryRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FetchMemoryProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchMemoryRef on AutoDisposeFutureProviderRef<Memory?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FetchMemoryProviderElement
    extends AutoDisposeFutureProviderElement<Memory?> with FetchMemoryRef {
  _FetchMemoryProviderElement(super.provider);

  @override
  String get id => (origin as FetchMemoryProvider).id;
}

String _$memoriesHash() => r'cfb4bb5ebce4098a4804ce468364eeba72f38908';

/// See also [Memories].
@ProviderFor(Memories)
final memoriesProvider =
    AutoDisposeAsyncNotifierProvider<Memories, List<Memory>>.internal(
  Memories.new,
  name: r'memoriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$memoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Memories = AutoDisposeAsyncNotifier<List<Memory>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
