// ignore_for_file: invalid_annotation_target
// lib/shared/models/transaction_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String type, // 'income' or 'expense'
    required int amount,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'order_id') String? orderId,
    @JsonKey(name: 'note') String? description,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
