// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userManagerHash() => r'7f2188ebf453deb826d8d0bd3886ebee73f02582';

/// See also [userManager].
@ProviderFor(userManager)
final userManagerProvider = FutureProvider<UserManager>.internal(
  userManager,
  name: r'userManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserManagerRef = FutureProviderRef<UserManager>;
String _$getCurrentUserHash() => r'33f115b3baf229220b2657e0653e3e9c573abe21';

/// See also [getCurrentUser].
@ProviderFor(getCurrentUser)
final getCurrentUserProvider = AutoDisposeFutureProvider<UserModel>.internal(
  getCurrentUser,
  name: r'getCurrentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCurrentUserRef = AutoDisposeFutureProviderRef<UserModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
