// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionNotifierHash() =>
    r'8539dab283de5516afe06eeb10c6470a40734c71';

/// See also [TransactionNotifier].
@ProviderFor(TransactionNotifier)
final transactionNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      TransactionNotifier,
      List<TransactionModel>
    >.internal(
      TransactionNotifier.new,
      name: r'transactionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TransactionNotifier =
    AutoDisposeAsyncNotifier<List<TransactionModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
